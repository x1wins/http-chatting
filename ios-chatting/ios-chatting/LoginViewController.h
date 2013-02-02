//
//  LoginViewController.h
//  FlowerPaper
//
//  Created by Rhee Chang-Woo on 13. 1. 6..
//  Copyright (c) 2013년 Rhee Chang-Woo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SignupViewController.h"

@interface LoginViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    
}

@property (strong, nonatomic) IBOutlet UITableView *mainTableView;
@property (strong, nonatomic) UITextField *idTextField;
@property (strong, nonatomic) UITextField *pwTextField;
@property (strong, nonatomic) UISwitch *loginSwitch;
@property (strong, nonatomic) UIActivityIndicatorView * indicate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil;
- (void) switchAction;
- (void) focusUp;

@end
