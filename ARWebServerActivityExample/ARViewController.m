//
//  ARViewController.m
//  ARWebServerActivityExample
//
//  Created by alexruperez on 18/04/14.
//  Copyright (c) 2014 alexruperez. All rights reserved.
//

#import "ARViewController.h"
#import "ARWebServerActivity.h"

@interface ARViewController ()

@end

@implementation ARViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor redColor]];
    
	UIButton *showActivitiesButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[showActivitiesButton setTitle:NSLocalizedString(@"Show Activities", @"Show Activities button") forState:UIControlStateNormal];
	[showActivitiesButton addTarget:self action:@selector(showActivities:) forControlEvents:UIControlEventTouchUpInside];
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
	[showActivitiesButton setFrame:CGRectMake((screenSize.width/2)-100, (screenSize.height/2)-30, 200, 60)];
    [self.view addSubview:showActivitiesButton];
}

- (void)showActivities:(id)sender
{
	ARWebServerActivity *webServerActivity = [[ARWebServerActivity alloc] init];
    
	UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:@[@"Hola", [UIImage imageNamed:NSStringFromClass([ARWebServerActivity class])], [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:[NSStringFromClass([ARWebServerActivity class]) stringByAppendingString:@"@2x"] ofType:@"png"]], [NSURL URLWithString:@"http://humanstxt.org/humans.txt"], [@"data" dataUsingEncoding:NSUTF8StringEncoding], @{@"key": @[@"value1", @"vale2"]}, @[@"value1", @"vale2"]] applicationActivities:@[webServerActivity]];
    
	[self presentViewController:activityViewController animated:YES completion:nil];
}

@end
