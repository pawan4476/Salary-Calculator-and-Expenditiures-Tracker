//
//  SalaryViewController.h
//  SalaryCalculatorAPP
//
//  Created by test on 12/13/16.
//  Copyright © 2016 chaitanya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SalaryViewController : UIViewController<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *grossTF;
@property (strong, nonatomic) IBOutlet UITextField *basicinPercentageTF;
@property (strong, nonatomic) IBOutlet UITextField *basicinValueTF;
@property (strong, nonatomic) IBOutlet UITextField *payDaysTF;
@property (strong, nonatomic) IBOutlet UITextField *attendedTF;

@property (strong, nonatomic) NSString *message;
@property (strong, nonatomic) NSString *titleString;
@property (assign, nonatomic) float HRA;
@property (assign, nonatomic) float value;

- (IBAction)tapGesture:(id)sender;
- (IBAction)Calculate:(id)sender;

@end
