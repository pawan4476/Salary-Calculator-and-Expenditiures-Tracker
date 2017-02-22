//
//  GraphViewController.m
//  SalaryCalculatorAPP
//
//  Created by test on 12/26/16.
//  Copyright © 2016 chaitanya. All rights reserved.
//

#import "GraphViewController.h"
#import "AppDelegate.h"
#import "Expense+CoreDataProperties.h"
#import "DrGraphs.h"
#import "ExpensesViewController.h"
#import "HelperFunctions.h"

@interface GraphViewController ()<BarChartDataSource, BarChartDelegate>
{
    UIDatePicker *datepicker;
    NSMutableDictionary* values;
    
}


@end

@implementation GraphViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.currentMonth = getDate([NSDate date]);
    [self MonthPicker];
    
    [self createBarChart];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    _barChartView.frame = CGRectMake(0, BOTTOM(_graphDateTF), WIDTH(self.view), HEIGHT(self.view) - BOTTOM(_graphDateTF));
    
    [_barChartView reloadBarGraph];
    [self fetchData];
}

- (IBAction)closeButtonClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)shouldAutorotate {
    return NO;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationLandscapeLeft;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma -mark MonthPicker
-(void)MonthPicker {
    self.graphDateTF.text = getMonthName(self.currentMonth);
    
    datepicker = [[UIDatePicker alloc]init];
    datepicker.datePickerMode = UIDatePickerModeDate;
    [datepicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
    self.graphDateTF.inputView = datepicker;
    
    [self fetchData];
}

-(void)dateChanged: (id)sender {
    
    UIDatePicker *picker = (UIDatePicker *)sender;
    self.currentMonth = [picker date];
    self.graphDateTF.text = getStringFromDate(_currentMonth);
    
    [self fetchData];
}

#pragma -mark fetchExpensesData
-(NSManagedObjectContext *)getContext {
    AppDelegate *appDelegate = (AppDelegate *) [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = appDelegate.persistentContainer.viewContext;
    return context;
}

- (void) fetchData {
    NSCalendar* cal = [NSCalendar currentCalendar];
    
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    
    NSDate* date = [cal dateByAddingComponents:dateComponents toDate:_currentMonth options:0];
    [self fetchMonthExpensesData:date];
  
    [_barChartView reloadBarGraph];
}

- (NSArray *)fetchMonthExpensesData:(NSDate*)date {
    NSArray* monthExpensesData = [self getMonthExpensesAtDate:date];
    NSMutableArray *typesArray = [[NSMutableArray alloc]init];
    values = [[NSMutableDictionary alloc]init];
    
    float total = 0;
    float foodTotal = 0;
    float healthCare = 0;
    float automobile = 0;
    float family = 0;
    float insurance = 0;
    float entertainment = 0;
    float loans = 0;
    float travels = 0;
    float tax = 0;
    float other = 0;
    float income = 0;
    float fuel = 0;
    float houseHold = 0;
    float funds = 0;
    
    for (Expense *exp in monthExpensesData) {
        
        if (exp.isExpense == false) {
            
            income += exp.amount;
            
        } else {
            total = total + exp.amount;
            
            if ([exp.type isEqualToString:@"Food"]) {
                foodTotal = foodTotal + exp.amount;
                
                [values setObject:@(foodTotal) forKey:@"Food"];
            }
            
            if ([exp.type isEqualToString:@"Health Care"]) {
                healthCare = healthCare +exp.amount;
                [values setObject:@(healthCare) forKey:@"Health Care"];
            }
            
            if ([exp.type isEqualToString:@"Family"]) {
                family = family + exp.amount;
                [values setObject:@(family) forKey:@"Family"];
            }
            
            if ([exp.type isEqualToString:@"Insurance"]) {
                insurance = insurance + exp.amount;
                [values setObject:@(insurance) forKey:@"Insurance"];

            }
            
            if ([exp.type isEqualToString:@"Loans"]) {
                loans = loans + exp.amount;
                [values setObject:@(loans) forKey:@"Loans"];
            }
            
            if ([exp.type isEqualToString:@"Entertainment"]) {
                entertainment = entertainment + exp.amount;
                [values setObject:@(entertainment) forKey:@"Entertainment"];

            }
            
            if ([exp.type isEqualToString:@"Tax"]) {
                tax = tax + exp.amount;
                [values setObject:@(tax) forKey:@"Tax"];
            }
            
            if ([exp.type isEqualToString:@"Other"]) {
                other = other + exp.amount;
                [values setObject:@(other) forKey:@"Other"];
            }
            
            if ([exp.type isEqualToString:@"Automobile"]) {
                automobile = automobile + exp.amount;
                [values setObject:@(automobile) forKey:@"Automobile"];
            }
            
            if ([exp.type isEqualToString:@"Travels"]) {
                travels = travels + exp.amount;
                [values setObject:@(travels) forKey:@"Travels"];
            }
            
            if ([exp.type isEqualToString:@"Household"]) {
                houseHold = houseHold + exp.amount;
                [values setObject:@(houseHold) forKey:@"Household"];
            }
            
            if ([exp.type isEqualToString:@"Fuel"]) {
                fuel = fuel + exp.amount;
                [values setObject:@(fuel) forKey:@"Fuel"];
            }
            
            if ([exp.type isEqualToString:@"Funds"]) {
                funds = funds + exp.amount;
                [values setObject:@(funds) forKey:@"Funds"];
            }
        }
    }
    
    [self saveData];
    return typesArray;
}

- (NSArray*)getMonthExpensesAtDate:(NSDate*)date {
    NSFetchRequest * desFetctRequest = [NSFetchRequest fetchRequestWithEntityName:@"Expense"];
    
    NSDate* startDate = setInitialDayForTheDate(date);
    NSDate* endDate = addMonths(startDate, 1);
    NSPredicate *issuePredicate = [NSPredicate predicateWithFormat:@"(date >= %@) AND (date < %@)", startDate, endDate];
    [desFetctRequest setPredicate:issuePredicate];
    NSError *error = nil;
    NSArray* results = [[self getContext] executeFetchRequest:desFetctRequest error:&error];
    return results;
}

#pragma -mark SaveData
-(void)saveData {
    
    NSError *error = nil;
    if (![[self getContext] save:&error]) {
        NSLog(@"Data not saved");
    }
    else{
        NSLog(@"data is saved");
    }
    
}

- (IBAction)tapGesture:(id)sender {
    [self.graphDateTF resignFirstResponder];
}

#pragma Mark CreateHorizontalChart
- (void)createBarChart{
    _barChartView = [[BarChart alloc] initWithFrame:CGRectMake(0, BOTTOM(_graphDateTF), WIDTH(self.view), HEIGHT(self.view) - BOTTOM(_graphDateTF))];
    [_barChartView setDataSource:self];
    [_barChartView setDelegate:self];
    [_barChartView setLegendViewType:LegendTypeHorizontal];
    [_barChartView setShowCustomMarkerView:TRUE];
    
    [self.view addSubview:_barChartView];
}


#pragma mark BarChartDataSource
- (NSMutableArray *)xDataForBarChart{
    
    return  values.allKeys.mutableCopy;
}

- (NSInteger)numberOfBarsToBePlotted{
    return 1;
}

- (UIColor *)colorForTheBarWithBarNumber:(NSInteger)barNumber{
    
 //   NSString* category = [values.allKeys objectAtIndex:barNumber];
    
    return [UIColor blueColor];

}

- (CGFloat)widthForTheBarWithBarNumber:(NSInteger)barNumber{
    
    return 40;
}

- (NSString *)nameForTheBarWithBarNumber:(NSInteger)barNumber{
    
    NSCalendar* cal = [NSCalendar currentCalendar];
    
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    NSDate* date = [cal dateByAddingComponents:offsetComponents toDate:_currentMonth options:0];
    NSString* dateStr = getMonthName(date);
    
    return dateStr;
}

- (NSMutableArray *)yDataForBarWithBarNumber:(NSInteger)barNumber{
    
    NSArray* keys = values.allValues;
    
    NSMutableArray* array = [NSMutableArray array];
    for (NSObject* object in keys) {
        [array addObject:object];
    }
    return array;
}

- (UIView *)customViewForBarChartTouchWithValue:(NSNumber *)value{
    UIView *view = [[UIView alloc] init];
    [view setBackgroundColor:[UIColor whiteColor]];
    [view.layer setCornerRadius:4.0F];
    [view.layer setBorderWidth:1.0F];
    [view.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [view.layer setShadowColor:[[UIColor blackColor] CGColor]];
    [view.layer setShadowRadius:2.0F];
    [view.layer setShadowOpacity:0.3F];
    
    UILabel *label = [[UILabel alloc] init];
    [label setFont:[UIFont systemFontOfSize:12]];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setText:[NSString stringWithFormat:@"Bar Data: %@", value]];
    [label setFrame:CGRectMake(0, 0, 100, 30)];
    [view addSubview:label];
    
    [view setFrame:label.frame];
    return view;
}

#pragma mark BarChartDelegate
- (void)didTapOnBarChartWithValue:(NSString *)value{
    NSLog(@"Bar Chart: %@",value);
}

- (IBAction)nextGraphButton:(id)sender {
    
    NSCalendar* cal = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setMonth:1];
    self.currentMonth = [cal dateByAddingComponents:dateComponents toDate:self.currentMonth options:0];
    
    self.graphDateTF.text = getMonthName(self.currentMonth);;
    
    [self fetchMonthExpensesData:self.currentMonth];

}
- (IBAction)previousGraphButton:(id)sender {
    
    NSCalendar* cal = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setMonth:-1];
    self.currentMonth = [cal dateByAddingComponents:dateComponents toDate:self.currentMonth options:0];
    
    self.graphDateTF.text = getMonthName(self.currentMonth);
    
    [self fetchMonthExpensesData:self.currentMonth];
    
}
@end
