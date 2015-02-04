NSUserDefaults+SettingsBundle lets you initialize your NSUserDefaults' default values with the "DefaultValue" of your Settings.bundle/Root.plist file. That way you don't have to specify them twice.

## Installation with CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Objective-C, which automates and simplifies the process of using 3rd-party code like NSUserDefaults+SettingsBundle in your projects.

### Podfile

```ruby
pod 'NSUserDefaults+SettingsBundle'
```

## Usage

```objective-c
#import "AppDelegate.h"
#import "NSUserDefaults+SettingsBundle.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(UIApplication *)application {
    NSUserDefaults * standardDefaults = [NSUserDefaults standardUserDefaults];
    NSString *name = [standardDefaults stringForKey:@"name"];

    NSLog(@"name before is %@", name);
    if(!name) {
        [standardDefaults registerDefaultsFromSettingsBundle];
        name = [standardDefaults stringForKey:@"name"];
    }
    NSLog(@"name after is %@", name);
}

@end
```