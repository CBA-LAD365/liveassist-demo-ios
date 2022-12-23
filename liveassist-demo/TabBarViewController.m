#import "TabBarViewController.h"
#import "AppSettings.h"
#import <LiveAssist/LiveAssist.h>
@import WebKit;

@interface TabBarViewController ()<UITabBarDelegate,UITabBarControllerDelegate,LiveAssistDelegate> {
    
}
@end

@implementation TabBarViewController

bool useConstraints = true;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupLiveAssist];
    self.delegate = self;
}

-(void) setupLiveAssist {
    AssistConfig* assistConfig = [self getLiveAssistConfigFromSettings];
    assistConfig.mask = [self getLiveAssistMaskFromSettings];
    
    _assistView = [[LiveAssistView alloc] initWithAssistConfig:assistConfig];
    [self.view addSubview:_assistView];
    
    if(useConstraints){
        _assistView.translatesAutoresizingMaskIntoConstraints = NO;
        if (@available(iOS 11, *)) {
            [NSLayoutConstraint activateConstraints:@[
                                                      [_assistView.leftAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leftAnchor],
                                                      [_assistView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor],
                                                      [_assistView.rightAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.rightAnchor],
                                                      [_assistView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor]
                                                      ]];
            
        }
    }
}

// The App is designed to go into its Settings on the device and look for this section and feed the result into UserDefaults. In the settings is where you want to enter **AccountId**
// Alternatively you can uncomment the accountId line and set this value in Info.plist
-(AssistConfig*) getLiveAssistConfigFromSettings {
    long accountId = [[[NSBundle mainBundle] objectForInfoDictionaryKey:@"AccountId"] intValue];
    LiveAssistChatStyle style = [AppSettings chatStyle];
    //NSArray *mobileSections = [self getSectionArrayByIndex:0];
    NSArray *mobileSections = @[@"mobile"];
    
    CGRect frametoUse = self.view.frame;
    
    if(useConstraints){
        frametoUse = CGRectZero;
    }
    BOOL notifications = YES;
    return [AssistConfig assistConfigWithAccountId:accountId sections:mobileSections chatStyle:style frame:frametoUse notifications:notifications];
}

-(AssistMask*) getLiveAssistMaskFromSettings {
    UIColor* color = [AppSettings maskColor];
    NSString *masks = [AppSettings masks];
    NSMutableSet* sets = [[NSMutableSet alloc] init];

    for(NSString *mask in [masks componentsSeparatedByString:@","]){
        [sets addObject:[NSNumber numberWithInteger:[mask integerValue]]];
    }
    
    return [AssistMask withTagSet:sets andColor:color];
}


- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    [_assistView setSections:[self getSectionArrayByIndex:self.selectedIndex]];
}

/// The App is deisgned to go into it's Settings on the device and look for these 2 sections and feed the result into UserDefaults. In the settings is where you want to enter **mobile**
-(NSArray*) getSectionArrayByIndex : (NSInteger) index  {
    NSArray* sectionStrings = @[@"web_sections",@"control_sections"];
    NSArray *sections = [[NSMutableArray alloc] init];
    
    if(index >= 0 && index < sectionStrings.count) {
       NSString *csvSections = [[NSUserDefaults standardUserDefaults] objectForKey:sectionStrings[index]];
        sections = [csvSections componentsSeparatedByString:@","];
    }
    return sections;
}

-(void) authoriseChatWithCallback : (AuthoriseCallback)  callback {

    NSString *authString = [AppSettings jwt];
    callback(authString);
}
@end
