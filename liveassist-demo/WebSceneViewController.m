#import "WebSceneViewController.h"

@interface WebSceneViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation WebSceneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString * webSite = @"http://www.cafex.com";
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:webSite]];
    [_webView loadRequest:request];
}
@end
