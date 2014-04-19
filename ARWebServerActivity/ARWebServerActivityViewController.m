//
//  ARWebServerActivityViewController.m
//  ARWebServerActivityExample
//
//  Created by alexruperez on 18/04/14.
//  Copyright (c) 2014 alexruperez. All rights reserved.
//

#import "ARWebServerActivityViewController.h"

@interface ARWebServerActivityViewController ()

@end

@implementation ARWebServerActivityViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)])
    {
        [self setNeedsStatusBarAppearanceUpdate];
    }
    
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0f, [[UIScreen mainScreen] bounds].size.height - 100.0f, [[UIScreen mainScreen] bounds].size.width, 100.0f)];
    [self.view addSubview:toolbar];
    
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(activityDidFinish:)]];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0.0f, [[UIScreen mainScreen] bounds].size.height - 100.0f, [[UIScreen mainScreen] bounds].size.width, 100.0f)];
    [button addTarget:self action:@selector(goToSafari:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:[self.view tintColor] forState:UIControlStateNormal];
    if (self.webServerActivity && [self.webServerActivity isRunning] && [self.webServerActivity serverURL] && [[UIApplication sharedApplication] canOpenURL:[self.webServerActivity serverURL]])
    {
        [button setTitle:[[self.webServerActivity serverURL] absoluteString] forState:UIControlStateNormal];
    }
    else if (self.webServerActivity && [self.webServerActivity isRunning] && [self.webServerActivity port])
    {
        if (![[self.webServerActivity port] isEqualToNumber:@80])
        {
            [button setTitle:[NSString stringWithFormat:@"http://localhost:%@/", [self.webServerActivity port]] forState:UIControlStateNormal];
        }
        else
        {
            [button setTitle:@"http://localhost/" forState:UIControlStateNormal];
        }
    }
    [self.view addSubview:button];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [UIView animateWithDuration:0.3f animations:^{
        [self.view setBackgroundColor:[UIColor colorWithWhite:0.0f alpha:0.3f]];
    }];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (IBAction)goToSafari:(id)sender
{
    if (self.webServerActivity && [self.webServerActivity isRunning] && [self.webServerActivity port])
    {
        if (![[self.webServerActivity port] isEqualToNumber:@80])
        {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://localhost:%@/", [self.webServerActivity port]]]];
        }
        else
        {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://localhost/"]];
        }
    }
}

- (IBAction)activityDidFinish:(id)sender
{
    if (self.webServerActivity)
    {
        [self.view setBackgroundColor:[UIColor clearColor]];
        [self.webServerActivity activityDidFinish:YES];
    }
}

@end
