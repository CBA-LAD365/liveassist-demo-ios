#import "WebSceneViewController.h"

@interface WebSceneViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation WebSceneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString * webSite = @"http://liveassistfor365.com";
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:webSite]];
    [_webView loadRequest:request];
}
@end
