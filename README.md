# ARWebServerActivity

[![Twitter](http://img.shields.io/badge/contact-@alexruperez-blue.svg?style=flat)](http://twitter.com/alexruperez)
[![Version](https://img.shields.io/cocoapods/v/ARWebServerActivity.svg?style=flat)](http://cocoadocs.org/docsets/ARWebServerActivity)
[![License](https://img.shields.io/cocoapods/l/ARWebServerActivity.svg?style=flat)](http://cocoadocs.org/docsets/ARWebServerActivity)
[![Platform](https://img.shields.io/cocoapods/p/ARWebServerActivity.svg?style=flat)](http://cocoadocs.org/docsets/ARWebServerActivity)
[![Analytics](https://ga-beacon.appspot.com/UA-55329295-1/ARWebServerActivity/readme?pixel)](https://github.com/igrigorik/ga-beacon)

## Overview

`ARWebServerActivity` is a `UIActivity` subclass that provides an "Share via web server" action to a `UIActivityViewController` to share files via [swisspol/GCDWebServer](https://github.com/swisspol/GCDWebServer) with Twitter Bootstrap UI.

You can share:
- NSString as TXT File.
- UIImage as PNG File.
- NSURL to a local/remote file.
- NSData as DATA File.
- NSDictionary as JSON File. 
- NSArray as JSON File.

![ARWebServerActivity screenshot](https://raw.github.com/alexruperez/ARWebServerActivity/master/screenshot.png "ARWebServerActivity screenshot")

## Clone the example proyect

To pull the [swisspol/GCDWebServer](https://github.com/swisspol/GCDWebServer) submodule run:

`git clone --recursive git@github.com:alexruperez/ARWebServerActivity.git`

## Requirements

- As `UIActivity` is iOS >= 6 only, so is the subclass.
- This project uses ARC. If you want to use it in a non ARC project, you must add the `-fobjc-arc` compiler flag to ARWebServerActivity.m and ARWebServerActivityViewController.m in Target Settings > Build Phases > Compile Sources.

## Installation

Add the `ARWebServerActivity` subfolder to your project. There are no required libraries other than [swisspol/GCDWebServer](https://github.com/swisspol/GCDWebServer) and its requirements.

## Usage

*(See example Xcode project)*

Simply `alloc`/`init` an instance of `ARWebServerActivity` and pass that object into the applicationActivities array when creating a `UIActivityViewController`.

```objectivec
ARWebServerActivity *webServerActivity = [[ARWebServerActivity alloc] init];
UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:@[@"Hello World!", [UIImage imageNamed:@"Example"], [NSURL fileURLWithPath:@"file/path"], [NSURL URLWithString:@"file/url"], [@"data" dataUsingEncoding:NSUTF8StringEncoding], @{@"key": @[@"value1", @"value2"]}, @[@"value1", @"value2"]] applicationActivities:@[webServerActivity]];
[self presentViewController:activityViewController animated:YES completion:nil];
```

Note that you can include the activity in any UIActivityViewController and it will only be shown to the user if there is a valid object in the activity items.

## Customization

To customize this control you can use:

```objectivec
- (instancetype)initWithPort:(NSNumber *)port bonjourName:(NSString *)bonjourName path:(NSString *)path activityViewController:(UIViewController *)activityViewController;
```

- `port`: [swisspol/GCDWebServer](https://github.com/swisspol/GCDWebServer) port.
- `bonjourName`: If you want your server be visible at Bonjour.
- `path`: If you want to change the local files path shared by your server. Note that will be removed after sharing.
- `activityViewController`: If you want to change the default control UI, you can subclass `ARWebServerActivityViewController` and not call `[super viewWillAppear:animated];`, make your own UIViewController or improve my `ARWebServerActivityViewController` and make a pull request.

## TO-DO (Help needed!)

- Add (programmatically) Auto Layout constraints to `ARWebServerActivityViewController` and example Xcode project for screen rotation.
- Improve `ARWebServerActivityViewController` UI.
