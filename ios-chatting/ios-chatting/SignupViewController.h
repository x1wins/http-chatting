//
//  SignupViewController.h
//  ios-chatting
//
//  Created by Rhee Chang-Woo on 13. 1. 10..
//  Copyright (c) 2013년 Chang woo Rhee. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SignupViewDelegate;

@interface SignupViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, assign) id<SignupViewDelegate> delegate;


@property (strong, nonatomic) IBOutlet UITableView *mainTableView;
@property (strong, nonatomic) UITextField *idTextField;
@property (strong, nonatomic) UITextField *nameTextField;
@property (strong, nonatomic) UITextField *pwTextField;
@property (strong, nonatomic) UITextField *confirmPwTextField;

@end

@protocol SignupViewDelegate <NSObject>
-(void) signUpSuccess:(SignupViewController*)signupViewController;
@end
