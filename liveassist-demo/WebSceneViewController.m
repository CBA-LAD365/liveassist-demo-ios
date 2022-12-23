#import "WebSceneViewController.h"
#import "AppSettings.h"

@interface WebSceneViewController ()
@property (weak, nonatomic) IBOutlet WKWebView *webView;

@end

@implementation WebSceneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString * webSite = [AppSettings webSite];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:webSite]];
    [_webView loadRequest:request];
}
@end
