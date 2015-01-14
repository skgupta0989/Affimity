//
//  ViewController.m
//  Affimity
//
//  Created by Sandeep on 14/01/15.
//  Copyright (c) 2015 neevtech. All rights reserved.
//

#import "ViewController.h"
#import "Constants.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginButtonClicked:(id)sender {
    NSString *userName =  self.usernameTextValue.text;
    NSString *password = self.passwordTextValue.text;
    NSString *loginURL = [NSString stringWithFormat:@"%@%@",BaseURL,LoginURI];
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success" message:loginURL delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
//    [alert show];
    if (![password isEqualToString:@"sandeep"]) {
        [self lockAnimationForView:self.passwordTextValue];
    }
}

-(void)lockAnimationForView:(UIView*)view
{
    CALayer *lbl = [view layer];
    CGPoint posLbl = [lbl position];
    CGPoint y = CGPointMake(posLbl.x-10, posLbl.y);
    CGPoint x = CGPointMake(posLbl.x+10, posLbl.y);
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"position"];
    [animation setTimingFunction:[CAMediaTimingFunction
                                  functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [animation setFromValue:[NSValue valueWithCGPoint:x]];
    [animation setToValue:[NSValue valueWithCGPoint:y]];
    [animation setAutoreverses:YES];
    [animation setDuration:0.08];
    [animation setRepeatCount:3];
    [lbl addAnimation:animation forKey:nil];
}
@end
