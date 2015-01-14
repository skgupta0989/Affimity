//
//  ViewController.m
//  Affimity
//
//  Created by Sandeep on 14/01/15.
//  Copyright (c) 2015 neevtech. All rights reserved.
//

#import "LoginViewController.h"
#import "Constants.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

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
    NSString *result = [self validEmail:userName password:password];
    
    if ([result isEqualToString:@"bothblank"]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Enter Username and Password !" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alert show];

    }else if ([result isEqualToString:@"emailblank"]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Enter Username !" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alert show];
        
    }else if ([result isEqualToString:@"passwordblank"]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Enter Password !" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alert show];
        
    }
    else if ([result isEqualToString:@"notproper"]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Username not proper !" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alert show];

    }else if ([result isEqualToString:@"proper"] && [result isEqualToString:@"pass"]){
        [self doLogin:userName password:password];
        
    }
    
    if (![password isEqualToString:@"sandeep"]) {
        [self lockAnimationForView:self.passwordTextValue];
    }
}

- (NSString*) validEmail:(NSString*) emailString password:(NSString*) password{
    
    if([emailString length]==0 && [password length] == 0){
        return @"bothblank";
    }else if ([emailString length] == 0){
        return @"emailblank";
    }else if ([password length] == 0){
        return @"passwordblank";
    }else if ([password length] > 0){
        return @"pass";
    }
    
    NSString *regExPattern = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    
    NSRegularExpression *regEx = [[NSRegularExpression alloc] initWithPattern:regExPattern options:NSRegularExpressionCaseInsensitive error:nil];
    NSUInteger regExMatches = [regEx numberOfMatchesInString:emailString options:0 range:NSMakeRange(0, [emailString length])];
    
    NSLog(@"%lu", (unsigned long)regExMatches);
    if (regExMatches == 0) {
        return @"notproper";
    } else {
        return @"proper";
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

-(void)doLogin:(NSString*) username password:(NSString*) password
{
    NSString *loginURL = [NSString stringWithFormat:@"%@%@",BaseURL,LoginURI];
    
}
@end
