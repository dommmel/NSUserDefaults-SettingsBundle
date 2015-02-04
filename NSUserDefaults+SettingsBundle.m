//
//  NSUserDefaults+SettingsBundle.m
//
//  Created by Dominik Heier on 04/02/15.
//

#import "NSUserDefaults+SettingsBundle.h"

@implementation NSUserDefaults (SettingsBundle)

/* Stolen from here:
 * http://stackoverflow.com/questions/510216/can-you-make-the-settings-in-settings-bundle-default-even-if-you-dont-open-the
 */

- (void)registerDefaultsFromSettingsBundle {
  NSString *settingsBundle = [[NSBundle mainBundle] pathForResource:@"Settings" ofType:@"bundle"];
  if(!settingsBundle) {
    NSLog(@"Could not find Settings.bundle");
    return;
  }
  
  NSDictionary *settings = [NSDictionary dictionaryWithContentsOfFile:[settingsBundle stringByAppendingPathComponent:@"Root.plist"]];
  NSArray *preferences = [settings objectForKey:@"PreferenceSpecifiers"];
  
  NSMutableDictionary *defaultsToRegister = [[NSMutableDictionary alloc] initWithCapacity:[preferences count]];
  for(NSDictionary *prefSpecification in preferences) {
    NSString *key = [prefSpecification objectForKey:@"Key"];
    if(key && [[prefSpecification allKeys] containsObject:@"DefaultValue"]) {
      [defaultsToRegister setObject:[prefSpecification objectForKey:@"DefaultValue"] forKey:key];
    }
  }
  
  [self registerDefaults:defaultsToRegister];
}

@end
