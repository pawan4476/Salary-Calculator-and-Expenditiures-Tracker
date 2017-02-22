//
//  GraphViewController.h
//  SalaryCalculatorAPP
//
//  Created by test on 12/26/16.
//  Copyright © 2016 chaitanya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Expense+CoreDataProperties.h"


@class BarChart;
@interface GraphViewController : UIViewController

@property (strong, nonatomic) NSDate *currentMonth;
@property (strong, nonatomic) BarChart *barChartView;


@property (strong, nonatomic) IBOutlet UITextField *graphDateTF;

- (IBAction)tapGesture:(id)sender;
- (IBAction)nextGraphButton:(id)sender;
- (IBAction)previousGraphButton:(id)sender;

@end
