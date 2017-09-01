#import "TabBarViewController.h"
#import <LiveAssist/LiveAssist.h>
@import WebKit;

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupLiveAssist];
}

-(void) setupLiveAssist {
    AssistConfig* assistConfig = [self assistConfig];
    assistConfig.mask = [self assistMask];
    _assistView = [[LiveAssistView alloc] initWithAssistConfig:assistConfig];
    [self.view addSubview:_assistView];
}

-(AssistConfig*) assistConfig {
    NSInteger accountId = [[[NSBundle mainBundle] objectForInfoDictionaryKey:@"AccountId"] integerValue];
    LiveAssistChatStyle style = LiveAssistChatStyleAuto;
    BOOL notifications = YES;
    NSArray *sections = @[@""];
    
    return [AssistConfig assistConfigWithAccountId:accountId sections:sections chatStyle:style frame:self.view.frame notifications:notifications];
}

-(AssistMask*) assistMask {
    NSSet* sets = [NSSet setWithArray:@[@1,@2]];
    return [AssistMask withTagSet:sets andColor:[UIColor blackColor]];
}


-(void) showNoAccountIdAlert {
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@"Info"
                                  message:@"Please set your account identifer in the plist"
                                  preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    
    [alert addAction:defaultAction];
    
    [self presentViewController:alert animated:NO completion:nil];
}

-(void) viewDidLayoutSubviews {
    if([[NSBundle mainBundle] objectForInfoDictionaryKey:@"AccountId"] == nil){
        [self showNoAccountIdAlert];
    }
}
@end
