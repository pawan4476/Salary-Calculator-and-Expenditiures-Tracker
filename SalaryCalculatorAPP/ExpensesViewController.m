//
//  ExpensesViewController.m
//  SalaryCalculatorAPP
//
//  Created by test on 12/12/16.
//  Copyright © 2016 chaitanya. All rights reserved.
//

#import "ExpensesViewController.h"
#import <CoreData/CoreData.h>
#import "Expense+CoreDataProperties.h"
#import "AppDelegate.h"
#import "CategoryViewController.h"
#import "TransactionViewController.h"
#import "IncomeCategoryViewController.h"
#import "HelperFunctions.h"

#define ADD_TAG 100
#define EDIT_TAG 101
@interface ExpensesViewController ()<CategoryViewControllerDelegate, IncomeCategoryViewControllerDelegate>
{
    NSIndexPath *indexpath;
    NSString *message;
    NSNumberFormatter *numberFormatter;
    
}

@end

@implementation ExpensesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    numberFormatter = [[NSNumberFormatter alloc]init];
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [numberFormatter setMaximumFractionDigits:2];
    [numberFormatter setRoundingMode:NSNumberFormatterRoundUp];
    
    if (self.editingObjct != nil) {
        self.currentDate = self.editingObjct.date;
        self.dateTF.text = getStringFromDate(self.editingObjct.date);
        self.amountTF.text = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:self.editingObjct.amount]];
        [self.categoryButtonOutlet setTitle:self.editingObjct.type forState:UIControlStateNormal];
        
        _doneButtonOutlet.tag = EDIT_TAG;
        
        if (self.editingObjct.isExpense) {
            _segment.selectedSegmentIndex = 0;
        } else {
            _segment.selectedSegmentIndex = 1;
        }
        _segment.enabled = false;
    } else {
        _doneButtonOutlet.tag = ADD_TAG;
        
        if (_isExpense) {
            _segment.selectedSegmentIndex = 0;
        } else {
            _segment.selectedSegmentIndex = 1;
        }
        _segment.enabled = true;
        
    }
            self.currentDate = getDate([NSDate date]);
            self.dateTF.text = getStringFromDate(_currentDate);

    [self fetchDayExpensesData:self.currentDate];
    
    
    self.datepicker = [[UIDatePicker alloc]init];
    self.datepicker.datePickerMode = UIDatePickerModeDate;
    [self.datepicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
    self.dateTF.inputView = self.datepicker;
    
    
}


#pragma -mark getContext
-(NSManagedObjectContext *)getContext {
    
    AppDelegate *appDelegate = (AppDelegate *) [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = appDelegate.persistentContainer.viewContext;
    return context;
    
}



#pragma -mark fetchExpensesData
- (void)fetchDayExpensesData:(NSDate*)date {
    
    NSFetchRequest * desFetctRequest = [NSFetchRequest fetchRequestWithEntityName:@"Expense"];
    NSPredicate *issuePredicate = [NSPredicate predicateWithFormat:@"date == %@", date];
    [desFetctRequest setPredicate:issuePredicate];
    NSError *error = nil;
    NSArray *results = [[self getContext] executeFetchRequest:desFetctRequest error:&error];
    
    float total = 0.0;
    for (Expense *result in results ) {
        total = total + result.amount;
    }
    self.totalExpensesLb.text = [NSString stringWithFormat:@"TotalSum:%.2f", total];
    
    [self saveData];
}

#pragma -mark dateChanged
-(void)dateChanged: (id)sender {
    
    UIDatePicker *picker = (UIDatePicker *)sender;
    self.currentDate = getDate([picker date]);
    self.dateTF.text = getStringFromDate(_currentDate);
    [self fetchDayExpensesData:self.currentDate];
    
}



-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.amountTF resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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


#pragma -mark TapGesture
- (IBAction)TapGesture:(id)sender {
    
    [self.dateTF resignFirstResponder];
    [self.amountTF resignFirstResponder];
}


#pragma -mark prepareForSegue
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"category"]) {
        CategoryViewController *vc = [segue destinationViewController];
        vc.delegate = self;
    }
    if ([segue.identifier isEqualToString:@"income"]) {
        IncomeCategoryViewController *vc = [segue destinationViewController];
        vc.delegate = self;
    }
    
}

#pragma -mark Delegate
-(void)category:(NSString *)text
{
    [self.categoryButtonOutlet setTitle:text forState:UIControlStateNormal];
}


-(void)incomeCategory:(NSString *)text
{
    [self.categoryButtonOutlet setTitle:text forState:UIControlStateNormal];
}

#pragma -mark ButtonActions
- (IBAction)DoneButton:(UIButton*)sender
{
    
    BOOL missingFields = false;
    if (self.amountTF.text.length == 0) {
        missingFields = true;
        message = @"Please enter Amount";
    } else if (self.categoryButtonOutlet.titleLabel.text == 0) {
        missingFields = true;
        message = @"Please Choose  Category";
    }
    
    if (missingFields == true){
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Required fields are empty" message:message preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *Ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:Ok];
        [self presentViewController:alert animated:YES completion:nil];
        
    } else {
        
        if (sender.tag == EDIT_TAG) {
            self.editingObjct.type = self.categoryButtonOutlet.currentTitle;
            self.editingObjct.amount = self.amountTF.text.floatValue;
            self.editingObjct.date = self.currentDate;
            
            [_doneButtonOutlet setTitle:@"Add"];
            _doneButtonOutlet.tag = ADD_TAG;
            
        } else {
            
            NSManagedObjectContext *context = [self getContext];
            Expense *object = [NSEntityDescription insertNewObjectForEntityForName:@"Expense"inManagedObjectContext:context];
            object.type = self.categoryButtonOutlet.currentTitle;
            object.amount = self.amountTF.text.floatValue;
            object.date = getDate(_currentDate);
            object.isExpense = _segment.selectedSegmentIndex == 0;
        }
        
        [self saveData];
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}


- (IBAction)CancelButton:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}




- (IBAction)categoryButton:(id)sender {
    
    switch (self.segment.selectedSegmentIndex) {
        case 0:
            [self performSegueWithIdentifier:@"category" sender:self];
            break;
        case 1:
            [self performSegueWithIdentifier:@"income" sender:self];
            break;
        default:
            break;
    }
}

- (IBAction)segmentChanged:(UISegmentedControl *)sender {
    _amountTF.text = @"";
    [_categoryButtonOutlet setTitle:@"" forState:UIControlStateNormal];
}
@end
