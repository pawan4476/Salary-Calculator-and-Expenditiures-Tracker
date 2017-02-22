//
//  ExpensesViewController.h
//  SalaryCalculatorAPP
//
//  Created by test on 12/12/16.
//  Copyright © 2016 chaitanya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Expense+CoreDataProperties.h"

#define Categories [[NSArray alloc]initWithObjects:@"Food", @"Health Care", @"Travels", @"Loans", @"Automobile", @"Entertainment", @"Family", @"Insurance", @"Tax", @"Other", @"Household", nil]
@interface ExpensesViewController : UIViewController<UITextFieldDelegate>

@property (strong, nonatomic) UIDatePicker *datepicker;
@property (strong, nonatomic) UIPickerView *picker;
@property (strong, nonatomic)  Expense *editingObjct;
@property (strong, nonatomic) NSDate *currentDate;
@property (strong, nonatomic) NSArray *types;
@property (strong, nonatomic) NSString *amountString;
@property (strong, nonatomic) NSString *dateString;
@property (strong, nonatomic) NSString *categoryString;
@property (assign, nonatomic) BOOL isExpense;

@property (strong, nonatomic) IBOutlet UISegmentedControl *segment;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *doneButtonOutlet;
@property (strong, nonatomic) IBOutlet UILabel *totalExpensesLb;
@property (strong, nonatomic) IBOutlet UITextField *dateTF;
@property (strong, nonatomic) IBOutlet UIView *myView;
@property (strong, nonatomic) IBOutlet UIScrollView *myScrollView;
@property (strong, nonatomic) IBOutlet UIButton *categoryButtonOutlet;
@property (strong, nonatomic) IBOutlet UITextField *amountTF;

- (IBAction)DoneButton:(id)sender;
- (IBAction)CancelButton:(id)sender;
- (IBAction)categoryButton:(id)sender;
- (IBAction)TapGesture:(id)sender;

@end
