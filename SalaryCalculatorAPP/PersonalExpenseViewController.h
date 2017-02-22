//
//  PersonalExpenseViewController.h
//  SalaryCalculatorAPP
//
//  Created by test on 12/19/16.
//  Copyright © 2016 chaitanya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Expense+CoreDataProperties.h"

@interface PersonalExpenseViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>


@property (strong, nonatomic) NSDate *currentMonth;
@property (strong, nonatomic) Expense *expenseData;

@property (strong, nonatomic) IBOutlet UILabel *totalIncomeLb;
@property (strong, nonatomic) IBOutlet UITableView *myTableView;
@property (strong, nonatomic) IBOutlet UILabel *balanceLb;
@property (strong, nonatomic) IBOutlet UIButton *monthButtonOutlet;
@property (strong, nonatomic) IBOutlet UILabel *todayExpenseLb;
@property (strong, nonatomic) IBOutlet UILabel *monthExpenseLb;
@property (strong, nonatomic) IBOutlet UILabel *backgroundLb;

- (IBAction)nextMonthButton:(id)sender;
- (IBAction)previousMonthButton:(id)sender;
- (IBAction)ChoosePicker:(id)sender;
- (IBAction)ChartButton:(id)sender;
- (IBAction)TapGestrure:(id)sender;



@end
