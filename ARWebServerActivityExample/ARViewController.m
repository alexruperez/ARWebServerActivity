//
//  ARViewController.m
//  ARWebServerActivityExample
//
//  Created by alexruperez on 18/04/14.
//  Copyright (c) 2014 alexruperez. All rights reserved.
//

#import "ARViewController.h"
#import <ARWebServerActivity/ARWebServerActivity.h>

@interface ARViewController ()

@end

@implementation ARViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	UIButton *showActivitiesButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[showActivitiesButton setTitle:NSLocalizedString(@"Show Activities", @"Show Activities button") forState:UIControlStateNormal];
	[showActivitiesButton addTarget:self action:@selector(showActivities:) forControlEvents:UIControlEventTouchUpInside];
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
	[showActivitiesButton setFrame:CGRectMake((screenSize.width/2)-100, (screenSize.height/2)-30, 200, 60)];
    [self.view addSubview:showActivitiesButton];
}

- (void)showActivities:(UIButton *)button
{
	ARWebServerActivity *webServerActivity = [[ARWebServerActivity alloc] init];
    
	UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:@[@"Hello World!", [UIImage imageNamed:[NSString stringWithFormat:@"%@.bundle/%@", webServerActivity.activityType, webServerActivity.activityType]], [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:[[NSString stringWithFormat:@"%@.bundle/%@", webServerActivity.activityType, webServerActivity.activityType] stringByAppendingString:@"@2x~ipad"] ofType:@"png"]], [NSURL URLWithString:@"http://humanstxt.org/humans.txt"], [@"data" dataUsingEncoding:NSUTF8StringEncoding], @{@"key": @[@"value1", @"value2"]}, @[@"value1", @"value2"]] applicationActivities:@[webServerActivity]];
    
    if ([activityViewController respondsToSelector:NSSelectorFromString(@"popoverPresentationController")])
    {
        activityViewController.popoverPresentationController.sourceView = button;
        activityViewController.popoverPresentationController.sourceRect = button.bounds;
    }
    
	[self presentViewController:activityViewController animated:YES completion:nil];
}

@end
