#import "NativeViewController.h"
#import "TabBarViewController.h"

@interface NativeViewController (){
    NSArray* textFields;
}

@end

@implementation NativeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    textFields=[self findAllTextFieldsInView:self.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)hideButtonChanged:(id)sender {
    [self invertTextFieldTags];
}

-(void) invertTextFieldTags {
    for(UITextField* textField in textFields){
        textField.tag = -textField.tag;
    }
}

-(NSArray*)findAllTextFieldsInView:(UIView*)view{
    NSMutableArray* textfieldarray = [[NSMutableArray alloc] init];
    for(id x in [view subviews]){
        if([x isKindOfClass:[UITextField class]])
        [textfieldarray addObject:x];
        
        if([x respondsToSelector:@selector(subviews)]){
            [textfieldarray addObjectsFromArray:[self findAllTextFieldsInView:x]];
        }
    }
    return textfieldarray;
}
@end
