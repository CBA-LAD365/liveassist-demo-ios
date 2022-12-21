#import "AppSettings.h"

@implementation AppSettings

+ (void)registerDefaultsFromSettingsBundle {
    // this function writes default settings as settings
    NSUserDefaults * standardUserDefaults = [NSUserDefaults standardUserDefaults];
    NSString * web_site_preference = [standardUserDefaults objectForKey:@"web_site"];
    if (!web_site_preference) {
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
            if(key) {
                [defaultsToRegister setObject:[prefSpecification objectForKey:@"DefaultValue"] forKey:key];
                NSLog(@"writing as default %@ to the key %@",[prefSpecification objectForKey:@"DefaultValue"],key);
                [[NSUserDefaults standardUserDefaults] setObject:[prefSpecification objectForKey:@"DefaultValue"] forKey:key];

            }
        }
        
        [[NSUserDefaults standardUserDefaults] registerDefaults:defaultsToRegister];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

    
+ (NSString*) accountIdentifier {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"account_identifer"];
}

+ (LiveAssistChatStyle) chatStyle {
    NSInteger settingsValue = [[[NSUserDefaults standardUserDefaults] objectForKey:@"chat_style"] integerValue];
    switch (settingsValue) {
        case 0: return LiveAssistChatStyleAuto; break;
        case 1: return LiveAssistChatStyleFullScreen; break;
        case 2: return LiveAssistChatStylePopup; break;
        default: return LiveAssistChatStyleAuto; break;
    }
}

+ (UIColor*) maskColor {
    NSArray *colors = @[ [UIColor redColor],[UIColor greenColor],[UIColor blueColor]];
    NSInteger colorIndex = [[[NSUserDefaults standardUserDefaults] objectForKey:@"mask_color"] integerValue];
    UIColor* color = colors[colorIndex];
    return color;
}

+ (NSString*) masks {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"masks"];
}

+ (NSString*) webSite {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"web_site"];
}

+ (NSString*) jwt {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"jwt"];
}

+(NSString*) javascriptMethodName{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"javascriptMethodName"];
}

@end
