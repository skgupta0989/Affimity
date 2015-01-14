//
//  ViewController.h
//  Affimity
//
//  Created by Sandeep on 14/01/15.
//  Copyright (c) 2015 neevtech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *usernameTextValue;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextValue;
- (IBAction)loginButtonClicked:(id)sender;
-(void)lockAnimationForView:(UIView*)view;
@end

