# ARWebServerActivity

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

To pull the [swisspol/GCDWebServer](https://github.com/swisspol/GCDWebServer) submodule run `git clone --recursive git@github.com:alexruperez/ARWebServerActivity.git`

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
