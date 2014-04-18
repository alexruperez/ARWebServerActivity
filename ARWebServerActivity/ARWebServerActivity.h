//
//  ARWebServerActivity.h
//  ARWebServerActivityExample
//
//  Created by alexruperez on 18/04/14.
//  Copyright (c) 2014 alexruperez. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GCDWebUploader.h"

@interface ARWebServerActivity : UIActivity

@property (strong, nonatomic) NSNumber *port;
@property (strong, nonatomic) NSString *bonjourName;
@property (strong, nonatomic) NSString *path;
@property (strong, nonatomic) UIViewController *activityViewController;

- (instancetype)initWithPort:(NSNumber *)port bonjourName:(NSString *)bonjourName path:(NSString *)path activityViewController:(UIViewController *)activityViewController;

- (BOOL)isRunning;
- (BOOL)start;
- (void)stop;
- (NSURL *)serverURL;
- (NSURL *)bonjourServerURL;

@end
