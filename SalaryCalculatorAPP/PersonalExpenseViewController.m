//
//  PersonalExpenseViewController.m
//  SalaryCalculatorAPP
//
//  Created by test on 12/19/16.
//  Copyright © 2016 chaitanya. All rights reserved.
//

#import "PersonalExpenseViewController.h"
#import "AppDelegate.h"
#import "Expense+CoreDataProperties.h"
#import "GraphViewController.h"
#import "ExpensesViewController.h"
#import "HelperFunctions.h"
#import "PersonalTableviewCell.h"

typedef enum DayType
{
    Weekly,
    Monthly,
    Yearly
} DayType;

@interface PersonalExpenseViewController ()
{
    UIDatePicker *datepicker;
    NSMutableDictionary *categoryValues;
    DayType type;
    NSNumberFormatter *numberFormatter;
    
}

@end

@implementation PersonalExpenseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    numberFormatter = [[NSNumberFormatter alloc]init];
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [numberFormatter setMaximumFractionDigits:2];
    [numberFormatter setRoundingMode:NSNumberFormatterRoundUp];
    
    type = Monthly;
    
    categoryValues = [[NSMutableDictionary alloc]init];
    
    self.currentMonth = getDate([NSDate date]);
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self MonthPicker];
    [self.myTableView reloadData];
}

#pragma -mark PrepareForSegue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"expense"]) {
        ExpensesViewController* viewCntl = segue.destinationViewController;
        viewCntl.isExpense = YES;
    } else if ([segue.identifier isEqualToString:@"income"]) {
        ExpensesViewController* viewCntl = segue.destinationViewController;
        viewCntl.isExpense = NO;
    }
}

#pragma -mark MonthPicker
-(void)MonthPicker {

    [self setDateTitle];
    [self fetchExpensesData:_currentMonth];
    [self fetchDayExpensesData];
}

#pragma -mark setDateTitle
-(void)setDateTitle {
    NSString *dateString;
    if (type == Weekly) {
        dateString = getWeekName(self.currentMonth);
    } else if (type == Monthly) {
        dateString = getMonthName(self.currentMonth);
    } else if (type == Yearly) {
        dateString = getYearName(self.currentMonth);
    }
    [self.monthButtonOutlet setTitle:dateString forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma -mark getContext
-(NSManagedObjectContext *)getContext {
    AppDelegate *appDelegate = (AppDelegate *) [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = appDelegate.persistentContainer.viewContext;
    return context;
}

#pragma -mark fetchExpensesData
- (void)fetchExpensesData:(NSDate*)date {
    
    [categoryValues removeAllObjects];
    
    NSArray* ExpensesData;
   
    if (type == Weekly) {
        ExpensesData = [self getWeekExpensesAtDate:date];
    } else if (type == Monthly) {
        ExpensesData = [self getMonthExpensesAtDate:date];
    } else if (type == Yearly) {
        ExpensesData = [self getYearExpensesAtDate:date];
    }
    
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
    float houseHold = 0;
    float fuel = 0;
    float funds = 0;
    float income = 0.0;
    
    
        for (Expense *exp in ExpensesData) {
            
            if (exp.isExpense == false) {
                
                income += exp.amount;
                
            } else {
                total = total + exp.amount;
                
                if ([exp.type isEqualToString:@"Food"]) {
                    
                    foodTotal = foodTotal + exp.amount;
                    NSString *string = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:foodTotal]];
                    [categoryValues setObject:string forKey:@"Food"];
                }
                
                if ([exp.type isEqualToString:@"Health Care"]) {
                    
                    healthCare = healthCare +exp.amount;
                    NSString *string = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:healthCare]];
                    [categoryValues setObject:string forKey:@"Health Care"];
                }
                
                if ([exp.type isEqualToString:@"Family"]) {
                    
                    family = family + exp.amount;
                    NSString *string = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:family]];
                    [categoryValues setObject:string forKey:@"Family"];
                }
                
                if ([exp.type isEqualToString:@"Insurance"]) {
                    
                    insurance = insurance + exp.amount;
                    NSString *string = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:insurance]];
                    [categoryValues setObject:string forKey:@"Insurance"];
                }
                
                if ([exp.type isEqualToString:@"Loans"]) {
                    
                    loans = loans + exp.amount;
                    NSString *string = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:loans]];
                    [categoryValues setObject:string forKey:@"Loans"];
                }
                
                if ([exp.type isEqualToString:@"Entertainment"]) {
                    
                    entertainment = entertainment + exp.amount;
                    NSString *string = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:entertainment]];
                    [categoryValues setObject:string forKey:@"Entertainment"];
                }
                
                if ([exp.type isEqualToString:@"Tax"]) {
                    
                    tax = tax + exp.amount;
                    NSString *string = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:tax]];
                    [categoryValues setObject:string forKey:@"Tax"];
                }
                
                if ([exp.type isEqualToString:@"Other"]) {
                    
                    other = other + exp.amount;
                    NSString *string = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:other]];
                    [categoryValues setObject:string forKey:@"Other"];
                }
                
                if ([exp.type isEqualToString:@"Automobile"]) {
                    
                    automobile = automobile + exp.amount;
                    NSString *string = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:automobile]];
                    [categoryValues setObject:string forKey:@"Automobile"];
                }
                
                if ([exp.type isEqualToString:@"Travels"]) {
                    
                    travels = travels + exp.amount;
                    NSString *string = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:travels]];
                    [categoryValues setObject:string forKey:@"Travels"];
                }
                
                if ([exp.type isEqualToString:@"Household"]) {
                    
                    houseHold = houseHold + exp.amount;
                    NSString *string = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:houseHold]];
                    [categoryValues setObject:string forKey:@"Household"];
                }
                
                if ([exp.type isEqualToString:@"Fuel"]) {
                    
                    fuel = fuel + exp.amount;
                    NSString *string = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:fuel]];
                    [categoryValues setObject:string forKey:@"Fuel"];
                }
                
                if ([exp.type isEqualToString:@"Funds"]) {
                    
                    funds = funds + exp.amount;
                    NSString *string = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:funds]];
                    [categoryValues setObject:string forKey:@"Funds"];
                }

            }
        }
    
    if (categoryValues.count == 0) {
        
        self.backgroundLb.hidden = NO;
        self.myTableView.hidden = YES;
    }
    
    else{
        
        self.backgroundLb.hidden = YES;
        [_myTableView reloadData];
        self.myTableView.hidden = NO;

    }
    
    self.monthExpenseLb.text = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:total]];
    self.totalIncomeLb.text = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:income]];
    self.balanceLb.text = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:income-total]];
    
    [self saveData];
    
    [_myTableView reloadData];
}


- (NSArray*)getMonthExpensesAtDate:(NSDate*)date {
    NSFetchRequest * desFetctRequest = [NSFetchRequest fetchRequestWithEntityName:@"Expense"];
    
    NSDate* startDate = setInitialDayForTheDate(date);
    NSDate* endDate = addMonths(startDate, 1);
    NSPredicate *issuePredicate = [NSPredicate predicateWithFormat:@"(date >= %@) AND (date < %@)", startDate, endDate];
    [desFetctRequest setPredicate:issuePredicate];
    NSError* error = nil;
    NSArray* results = [[self getContext] executeFetchRequest:desFetctRequest error:&error];
    return results;
}

-(NSArray*)getWeekExpensesAtDate:(NSDate*)date {
    NSFetchRequest* desFetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Expense"];
    NSDate* startDate = getDate(date);
    NSDate* endDate = addDays(startDate, 7);
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(date >= %@) AND (date < %@)", startDate, endDate];
    [desFetchRequest setPredicate:predicate];
    NSError* error = nil;
    NSArray* results = [[self getContext] executeFetchRequest:desFetchRequest error:&error];
    return results;
}

- (NSArray*)getYearExpensesAtDate:(NSDate*)date {
    NSFetchRequest * desFetctRequest = [NSFetchRequest fetchRequestWithEntityName:@"Expense"];
    
    NSDate* startDate = setInitialDayForTheDate(date);
    NSDate* endDate = addYear(startDate, 1);
    NSPredicate *issuePredicate = [NSPredicate predicateWithFormat:@"(date >= %@) AND (date < %@)", startDate, endDate];
    [desFetctRequest setPredicate:issuePredicate];
    NSError* error = nil;
    NSArray* results = [[self getContext] executeFetchRequest:desFetctRequest error:&error];
    return results;
}

- (void)fetchDayExpensesData {
    
    NSDate* date = getDate([NSDate date]);
    
    NSFetchRequest * desFetctRequest = [NSFetchRequest fetchRequestWithEntityName:@"Expense"];
    NSPredicate *issuePredicate = [NSPredicate predicateWithFormat:@"date == %@", date];
    [desFetctRequest setPredicate:issuePredicate];
    NSError *error = nil;
    NSArray *results = [[self getContext] executeFetchRequest:desFetctRequest error:&error];
    
    float total = 0;
    for (Expense *expense in results ) {
        if (expense.isExpense) {
            total = total + expense.amount;
        }
    }
    self.todayExpenseLb.text = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:total]];
    
    [self saveData];
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

#pragma -mark TableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return categoryValues.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PersonalTableviewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    NSArray *typeArray = [categoryValues allKeys];
    NSArray *totalArray = [categoryValues allValues];
    cell.typeLabel.text = [typeArray objectAtIndex:indexPath.row];
    cell.amountLabel.text = [totalArray objectAtIndex:indexPath.row];
    
    return cell;
}


#pragma -mark nextMonthButton
- (IBAction)nextMonthButton:(id)sender {
    
    if (type == Weekly) {
        self.currentMonth = addDays(self.currentMonth, 7);
    } else if (type == Monthly) {
        self.currentMonth = addMonths(self.currentMonth, 1);
    } else if (type == Yearly) {
        self.currentMonth = addYear(self.currentMonth, 1);
    }
    
    [self setDateTitle];
    [self fetchExpensesData:self.currentMonth];

    
    
}

#pragma -mark previousMonthButton
- (IBAction)previousMonthButton:(id)sender {
    if (type == Weekly) {
        self.currentMonth = addDays(self.currentMonth, -7);
    } else if (type == Monthly) {
        self.currentMonth = addMonths(self.currentMonth, -1);
    } else if (type == Yearly) {
        self.currentMonth = addYear(self.currentMonth, -1);
    }
    
    [self setDateTitle];
    [self fetchExpensesData:self.currentMonth];

}

#pragma -mark ChoosePicker
- (IBAction)ChoosePicker:(id)sender {
    
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"" message:@"Show Spending" preferredStyle:UIAlertControllerStyleActionSheet];
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Weekly" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        type = Weekly;
        _currentMonth = getDate([NSDate date]);
        [self MonthPicker];
        [self dismissViewControllerAnimated:YES completion:nil];
        
     

        
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }]];
    
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Monthly" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
       
        type = Monthly;
        self.currentMonth = getDate([NSDate date]);
        [self MonthPicker];
        

        [self dismissViewControllerAnimated:YES completion:nil];
        
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Yearly" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

        type = Yearly;
        self.currentMonth = getDate([NSDate date]);
        [self MonthPicker];
       
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }]];
    
    [self presentViewController:actionSheet animated:YES completion:nil];
}

- (IBAction)ChartButton:(id)sender {
    
}

- (IBAction)TapGestrure:(id)sender {
    
}

@end
