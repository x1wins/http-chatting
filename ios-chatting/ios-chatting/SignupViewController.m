//
//  SignupViewController.m
//  ios-chatting
//
//  Created by Rhee Chang-Woo on 13. 1. 10..
//  Copyright (c) 2013년 Chang woo Rhee. All rights reserved.
//

#import "SignupViewController.h"

@interface SignupViewController ()

@end

@implementation SignupViewController

@synthesize mainTableView = _mainTableView;
@synthesize idTextField = _idTextField;
@synthesize nameTextField = _nameTextField;
@synthesize pwTextField = _pwTextField;
@synthesize confirmPwTextField = _confirmPwTextField;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    _idTextField = [[UITextField alloc]initWithFrame:CGRectMake(160, 15, 150, 40)];
    _nameTextField = [[UITextField alloc]initWithFrame:CGRectMake(160, 15, 150, 40)];
    _pwTextField = [[UITextField alloc]initWithFrame:CGRectMake(160, 15, 150, 40)];
    _confirmPwTextField = [[UITextField alloc]initWithFrame:CGRectMake(160, 15, 150, 40)];
    _idTextField.backgroundColor = [UIColor clearColor];
    _nameTextField.backgroundColor = [UIColor clearColor];
    _pwTextField.backgroundColor = [UIColor clearColor];
    _confirmPwTextField.backgroundColor = [UIColor clearColor];
    _pwTextField.secureTextEntry = YES;
    _confirmPwTextField.secureTextEntry = YES;
    _idTextField.placeholder = @"Required";
    _nameTextField.placeholder = @"Required";    
    _pwTextField.placeholder = @"Required";
    _confirmPwTextField.placeholder = @"Required";
    
    [_idTextField becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - table delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    int cell_count = 2;
    
    switch (section) {
        case 0:
            cell_count = 4;
            break;
        case 1:
        default:
            cell_count = 2;
            break;
    }
    
    return cell_count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
    
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    cell.selectionStyle = NO;
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    switch(indexPath.section)
    {
        case 0:
            switch (indexPath.row) {
                case 0:
                    cell.textLabel.text = @"아이디";
                    [cell addSubview:_idTextField];
                    break;
                case 1:
                    cell.textLabel.text = @"이름";
                    [cell addSubview:_nameTextField];
                    break;
                case 2:
                    cell.textLabel.text = @"비밀번호";
                    [cell addSubview:_pwTextField];
                    break;
                case 3:
                    cell.textLabel.text = @"비밀번호";
                    [cell addSubview:_confirmPwTextField];
                    break;
            }
            break;
        case 1:
            switch (indexPath.row) {
                case 0:
                    cell.textLabel.text = @"완료";
                    cell.selectionStyle = YES;
                    break;
                case 1:
                    cell.textLabel.text = @"취소";
                    cell.selectionStyle = YES;
                    break;
            }
            break;
    }
    
    
    return cell;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *) indexPath{
    
    int height = 50;
    return height;
}


//cell click event
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch(indexPath.section){
        case 1:
            switch (indexPath.row) {
                case 0:
                    break;
                case 1:
                    [self dismissViewControllerAnimated:YES completion:nil];
                    break;
            }
            break;
    }
    
    
}


@end
