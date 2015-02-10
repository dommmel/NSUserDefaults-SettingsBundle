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
  [self registerDefaults:[self defaultsFromPlistNamed:@"Root"]];
}

- (NSDictionary *)defaultsFromPlistNamed:(NSString *)plistName {
  NSString *settingsBundle = [[NSBundle mainBundle] pathForResource:@"Settings" ofType:@"bundle"];
  NSAssert(settingsBundle, @"Could not find Settings.bundle while loading defaults.");
  
  NSString *plistFullName = [NSString stringWithFormat:@"%@.plist", plistName];
  
  NSDictionary *settings = [NSDictionary dictionaryWithContentsOfFile:[settingsBundle stringByAppendingPathComponent:plistFullName]];
  NSAssert1(settings, @"Could not load plist '%@' while loading defaults.", plistFullName);
  
  NSArray *preferences = [settings objectForKey:@"PreferenceSpecifiers"];
  NSAssert1(preferences, @"Could not find preferences entry in plist '%@' while loading defaults.", plistFullName);
  
  NSMutableDictionary *defaults = [NSMutableDictionary dictionary];
  for(NSDictionary *prefSpecification in preferences) {
    NSString *key = [prefSpecification objectForKey:@"Key"];
    id value = [prefSpecification objectForKey:@"DefaultValue"];
    if(key && value) {
      [defaults setObject:value forKey:key];
    }
    
    NSString *type = [prefSpecification objectForKey:@"Type"];
    if ([type isEqualToString:@"PSChildPaneSpecifier"]) {
      NSString *file = [prefSpecification objectForKey:@"File"];
      NSAssert1(file, @"Unable to get child plist name from plist '%@'", plistFullName);
      [defaults addEntriesFromDictionary:[self defaultsFromPlistNamed:file]];
    }
  }
  
  return defaults;
}

@end
