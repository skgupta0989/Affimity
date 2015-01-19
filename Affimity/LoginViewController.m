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
-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES];
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

    }else if ([result isEqualToString:@"proper"]){
        [self doLogin:userName password:password];
        
    }
    
   
}

- (NSString*) validEmail:(NSString*) emailString password:(NSString*) password{
    
    if([emailString length]==0 && [password length] == 0){
        return @"bothblank";
    }else if ([emailString length] == 0){
        return @"emailblank";
    }else if ([password length] == 0){
        return @"passwordblank";
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
{[self performSegueWithIdentifier:@"MainTabBar" sender:self];
    NSString *loginURL = [NSString stringWithFormat:@"%@%@",BaseURL,LoginURI];
    NSDictionary *loginData = [NSDictionary dictionaryWithObjectsAndKeys:username,@"email",password,@"password" ,nil];
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:loginData options:kNilOptions error:nil];
    NSURL *url = [[NSURL alloc] initWithString:loginURL];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setHTTPBody:jsonData];
    
    // print json:
    NSLog(@"JSON summary: %@", [[NSString alloc] initWithData:jsonData
                                                     encoding:NSUTF8StringEncoding]);
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    //Loads the data for a URL request and executes a handler block on an
    //operation queue when the request completes or fails.
    
    [NSURLConnection sendAsynchronousRequest:request queue:queue
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data,
                                               NSError *error) {
        if ([data length] >0 && error == nil){
            //process the JSON response
            //use the main queue so that we can interact with the screen
            dispatch_async(dispatch_get_main_queue(), ^{[self parseResponse:data];});
        }
        else if ([data length] == 0 && error == nil){
            NSLog(@"Empty Response, not sure why?");
        }
        else if (error != nil){
            NSLog(@"Not again, what is the error = %@", error);
        }
    }];
    
}

- (void) parseResponse:(NSData *) data {
    
    NSString *loginResponse = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"JSON data = %@", loginResponse);
    NSError *error = nil;

    
    
    //parsing the JSON response
    id jsonObject = [NSJSONSerialization
                     JSONObjectWithData:data
                     options:NSJSONReadingAllowFragments
                     error:&error];
    NSString *successCode = [jsonObject valueForKey:@"code"];
    NSLog(@"login response = %@",successCode);
    if (![successCode isEqualToString:@"200"]) {
        [self lockAnimationForView:self.passwordTextValue];
    }else{
        [self performSegueWithIdentifier:@"MainTabBar" sender:self];
    }
    
    
}
@end
