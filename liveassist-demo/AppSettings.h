#import <Foundation/Foundation.h>
#import <LiveAssist/LiveAssist.h>

/**
    Facade onto app settings stored in NSUserDefaults.
*/
@interface AppSettings : NSObject

+ (void)registerDefaultsFromSettingsBundle;

+ (NSString*) accountIdentifier;
+ (LiveAssistChatStyle) chatStyle;
+ (UIColor*) maskColor;
+ (NSString*) masks;
+ (NSString*) webSite;
+ (NSString*) javascriptMethodName;
+ (NSString*) jwt;

@end
