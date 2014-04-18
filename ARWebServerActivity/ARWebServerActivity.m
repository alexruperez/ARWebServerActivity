//
//  ARWebServerActivity.m
//  ARWebServerActivityExample
//
//  Created by alexruperez on 18/04/14.
//  Copyright (c) 2014 alexruperez. All rights reserved.
//

#import "ARWebServerActivity.h"

#import "GCDWebServerPrivate.h"
#import "ARWebServerActivityViewController.h"

@interface ARWebServerActivity () <GCDWebUploaderDelegate>

@property (strong, nonatomic) NSFileManager *fileManager;
@property (strong, nonatomic) GCDWebUploader *webUploader;

@end

@implementation ARWebServerActivity

- (instancetype)init
{
    return [self initWithPort:nil bonjourName:nil path:nil activityViewController:nil];
}

- (instancetype)initWithPort:(NSNumber *)port bonjourName:(NSString *)bonjourName path:(NSString *)path activityViewController:(UIViewController *)activityViewController
{
    self = [super init];
    if (self)
    {
        self.fileManager = [NSFileManager defaultManager];
        
        self.port = port ? port : @8080;
        
        self.bonjourName = bonjourName ? bonjourName : nil;
        
        self.path = path ? path : [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:NSStringFromClass([self class])];

        [self setActivityViewController:activityViewController ? activityViewController : [[ARWebServerActivityViewController alloc] init]];
    }
    return self;
}

- (GCDWebUploader *)webUploader
{
    if (!_webUploader)
    {
        _webUploader = [[GCDWebUploader alloc] initWithUploadDirectory:self.path];
        [_webUploader setDelegate:self];
    }
    return _webUploader;
}

- (BOOL)isRunning
{
    return [self.webUploader isRunning];
}

- (BOOL)start
{
    if ([self isRunning])
    {
        return YES;
    }
    
    NSMutableDictionary *options = [[NSMutableDictionary alloc] init];
    
    [options setObject:@NO forKey:GCDWebServerOption_AutomaticallySuspendInBackground];
    if (self.port)
    {
        [options setObject:self.port forKey:GCDWebServerOption_Port];
    }
    if (self.bonjourName)
    {
        [options setObject:self.bonjourName forKey:GCDWebServerOption_BonjourName];
    }
    
    return [self.webUploader startWithOptions:options];
}

- (void)stop
{
    if ([self isRunning])
    {
        [self.webUploader stop];
    }
}

- (NSURL *)serverURL
{
    return [self.webUploader serverURL];
}

- (NSURL *)bonjourServerURL
{
    return [self.webUploader bonjourServerURL];
}

- (NSString *)activityType
{
	return NSStringFromClass([self class]);
}

- (UIImage *)activityImage
{
	return [UIImage imageNamed:NSStringFromClass([self class])];
}

- (NSString *)activityTitle
{
	return @"Share by WebServer";
}

- (BOOL)canPerformWithActivityItems:(NSArray *)activityItems
{
    for (id activityItem in activityItems)
    {
		if ([activityItem isKindOfClass:[NSString class]] || [activityItem isKindOfClass:[UIImage class]] || [activityItem isKindOfClass:[NSURL class]] || [activityItem isKindOfClass:[NSData class]] || [activityItem isKindOfClass:[NSDictionary class]] || [activityItem isKindOfClass:[NSArray class]])
        {
            return YES;
		}
	}
	return NO;
}

- (void)prepareWithActivityItems:(NSArray *)activityItems
{
    NSError *error;
    if ([self.fileManager fileExistsAtPath:self.path])
    {
        [self.fileManager removeItemAtPath:self.path error:&error];
    }
    
    [self.fileManager createDirectoryAtPath:self.path withIntermediateDirectories:YES attributes:nil error:&error];
    
    for (id activityItem in activityItems)
    {
        NSData *data;
        NSString *filename;
        if ([activityItem isKindOfClass:[NSString class]])
        {
            data = [activityItem dataUsingEncoding:NSUTF8StringEncoding];
            filename = [NSString stringWithFormat:@"%lu.txt", (unsigned long)[activityItems indexOfObject:activityItem]];
		}
        if ([activityItem isKindOfClass:[UIImage class]])
        {
            data = UIImagePNGRepresentation(activityItem);
            filename = [NSString stringWithFormat:@"%lu.png", (unsigned long)[activityItems indexOfObject:activityItem]];
		}
        if ([activityItem isKindOfClass:[NSURL class]])
        {
            if ([activityItem isFileURL])
            {
                if ([self.fileManager fileExistsAtPath:[(NSURL *)activityItem path]])
                {
                    data = [NSData dataWithContentsOfFile:[(NSURL *)activityItem path]];
                    filename = [[(NSURL *)activityItem path] lastPathComponent];
                }
            }
            else
            {
                data = [NSData dataWithContentsOfURL:activityItem];
                filename = [[(NSURL *)activityItem path] lastPathComponent];
            }
		}
        if ([activityItem isKindOfClass:[NSData class]])
        {
            data = activityItem;
            filename = [NSString stringWithFormat:@"%lu.data", (unsigned long)[activityItems indexOfObject:activityItem]];
		}
        if ([activityItem isKindOfClass:[NSDictionary class]] || [activityItem isKindOfClass:[NSArray class]])
        {
            data = [NSJSONSerialization dataWithJSONObject:activityItem options:NSJSONWritingPrettyPrinted error:&error];
            filename = [NSString stringWithFormat:@"%lu.json", (unsigned long)[activityItems indexOfObject:activityItem]];
		}
        if (data && filename)
        {
            [self.fileManager createFileAtPath:[self.path stringByAppendingPathComponent:filename] contents:data attributes:nil];
        }
	}
}

- (UIViewController *)activityViewController
{
    if ([_activityViewController isKindOfClass:[ARWebServerActivityViewController class]])
    {
        ARWebServerActivityViewController *activityViewController = (ARWebServerActivityViewController *)_activityViewController;
        [activityViewController setWebServerActivity:self];
        [self start];
    }
    
    return _activityViewController;
}

- (void)activityDidFinish:(BOOL)completed
{
    [self stop];
    
    NSError *error;
    if ([self.fileManager fileExistsAtPath:self.path])
    {
        [self.fileManager removeItemAtPath:self.path error:&error];
    }
    
    [super activityDidFinish:completed];
}

@end
