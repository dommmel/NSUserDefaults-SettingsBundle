## Example usage  
    #import "AppDelegate.h"
    #import "NSUserDefaults+SettingsBundle.h"

    @interface AppDelegate ()

    @end

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