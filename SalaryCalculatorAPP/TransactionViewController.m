//
//  TransactionViewController.m
//  SalaryCalculatorAPP
//
//  Created by test on 1/12/17.
//  Copyright © 2017 chaitanya. All rights reserved.
//

#import "TransactionViewController.h"
#import "AppDelegate.h"
#import <CoreData/CoreData.h>
#import "TableViewCell.h"
#import "ExpensesViewController.h"
#import "HelperFunctions.h"

#define ADD_TAG 100
#define EDIT_TAG 101

typedef enum DayType
{
    Weekly,
    Monthly,
    Yearly
} DayType;


@interface TransactionViewController ()
{
    
    NSArray *repeatPickerData;
    NSIndexPath *indexpath;
    DayType type;
    NSNumberFormatter *numberFormatter;

}


@end

@implementation TransactionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    numberFormatter = [[NSNumberFormatter alloc]init];
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [numberFormatter setMaximumFractionDigits:2];
    [numberFormatter setRoundingMode:NSNumberFormatterRoundUp];
    
    type = Monthly;
    
    self.values = [[NSMutableArray alloc]init];
    
    
    self.currentMonth = getDate([NSDate date]);
    [self MonthPicker];
    [self fetchExpensesData:self.currentMonth];
    
    [self.myTableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self MonthPicker];
    [self.myTableView reloadData];
}


#pragma -mark MonthPicker
-(void)MonthPicker {
   
    [self setDateTitle];
    [self fetchExpensesData:self.currentMonth];
}


-(void)setDateTitle {
    NSString *dateString;
    if (type == Weekly) {
        dateString = getWeekName(self.currentMonth);
    } else if (type == Monthly) {
        dateString = getMonthName(self.currentMonth);
    } else if (type == Yearly) {
        dateString = getYearName(self.currentMonth);
    }
    [self.choosePickerButtonOutlet setTitle:dateString forState:UIControlStateNormal];
}


-(NSManagedObjectContext*)getContext {
    AppDelegate *appdelegate = (AppDelegate *) [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = appdelegate.persistentContainer.viewContext;
    return context;
    
}

#pragma -mark fetchExpensesData
- (void)fetchExpensesData:(NSDate*)date {
    
    if (type == Weekly) {
        self.values = [self getWeekExpensesAtDate:date].mutableCopy;
    } else if (type == Monthly) {
        self.values = [self getMonthExpensesAtDate:date].mutableCopy;
    } else if (type == Yearly) {
        self.values = [self getYearExpensesAtDate:date].mutableCopy;
    }
   
    
    float income = 0.0;
    float expense = 0.0;
    
    for (Expense *obj in self.values) {
        if (obj.isExpense == false) {
            
            income += obj.amount;
            
        } else {
            expense += obj.amount;
        }
    }
    
    if (self.values.count == 0) {
        self.backgroundLb.hidden = NO;;
        self.myTableView.hidden = YES;
    } else {
        self.backgroundLb.hidden = YES;
        self.myTableView.hidden = NO;
        [self.myTableView reloadData];
    }
    
    self.incomeLb.text = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:income]];
    self.expenseLb.text = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:expense]];
    
    
    [self.myTableView reloadData];
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

#pragma -mark TableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.values.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    Expense* obj = self.values[indexPath.row];
    cell.categoryLb.text = obj.type;
    cell.amountLb.text = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:obj.amount]];
    cell.dateLb.text = getStringFromDate(obj.date);
    if (obj.isExpense) {
        cell.amountLb.textColor = [UIColor redColor];
    } 
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        Expense* obj = [self.values objectAtIndex:indexPath.row];
        [[self getContext] deleteObject:obj];
        NSError *error = nil;
        [[self getContext] save:&error];
        [self.values removeObjectAtIndex:indexPath.row];
        [self.myTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        
    }
}

#pragma -mark prepareForSegue
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"trans"]) {
        ExpensesViewController *vc = [segue destinationViewController];
        NSIndexPath *path = [self.myTableView indexPathForSelectedRow];
        Expense* obj = self.values[path.row];
        vc.editingObjct = obj ;
    } else if ([segue.identifier isEqualToString:@"add"]) {
        ExpensesViewController* viewCntl = segue.destinationViewController;
        viewCntl.isExpense = YES;
    }
}



- (IBAction)addButton:(id)sender {
}

#pragma -mark ButtonActions
- (IBAction)editButton:(id)sender {
    [[self myTableView] setEditing:YES animated:NO];
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(DoneButton)];
    self.navigationItem.leftBarButtonItem = backButton;
}

- (IBAction)transctnShare:(id)sender {
    
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
        
        UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, NO, [UIScreen mainScreen].scale);
        
    }
    
    else{
        
        UIGraphicsBeginImageContext(self.view.bounds.size);
        
    }
    
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *screenShotImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    NSData *imageData = UIImagePNGRepresentation(screenShotImage);
    if (imageData) {
        
        [imageData writeToFile:@"screenshot.png" atomically:YES];
        
    }
    else{
        
        NSLog(@"Error while taking screen shot");
        
    }
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Share" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    alert.popoverPresentationController.sourceView = self.view;
    alert.popoverPresentationController.sourceRect = CGRectMake(self.view.bounds.size.width - 34, 20, 0, 0);

    UIAlertAction *wtsap = [UIAlertAction actionWithTitle:@"WhatsApp" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"whatsapp://app"]]) {
            
            UIImage *image = [UIImage imageWithData:imageData];
            NSString *savePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/whatsAppTmp.wai"];
            [UIImageJPEGRepresentation(image, 1.0) writeToFile:savePath atomically:YES];
            self.documentationInteractionController = [UIDocumentInteractionController interactionControllerWithURL:[NSURL fileURLWithPath:savePath]];
            self.documentationInteractionController.UTI = @"net.whatsapp.image";
            self.documentationInteractionController.delegate = self;
            [self.documentationInteractionController presentOpenInMenuFromRect:CGRectMake(0, 0, 0, 0) inView:self.view animated:YES];
            
        }
        
        else{
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"WhatsApp not installed" message:@"Your device has no WhatsApp installed" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *ok = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:ok];
            [self presentViewController:alert animated:YES completion:nil];
            
        }
        
    }];
    
    UIAlertAction *more = [UIAlertAction actionWithTitle:@"More..." style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        
        NSString *mgs = @"Pay Slip";
        NSArray *array = @[mgs, imageData];
        UIActivityViewController *activity = [[UIActivityViewController alloc]initWithActivityItems:array applicationActivities:nil];
        activity.popoverPresentationController.sourceView = self.view;
        activity.popoverPresentationController.sourceRect = CGRectMake(self.view.bounds.size.width - 34, 20, 0, 0);

        [self presentViewController:activity animated:YES completion:nil];
        
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    
    [alert addAction:cancel];
    [alert addAction:wtsap];
    [alert addAction:more];
    [self presentViewController:alert animated:YES completion:nil];
    

}

-(void)DoneButton
{
    [[self myTableView] setEditing:NO animated:NO];
    [self.myTableView reloadData];
    self.navigationItem.leftBarButtonItem = self.editButtonOutlet;
    
}



- (IBAction)ChoosePickerButton:(id)sender {
    
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
        _currentMonth = getDate([NSDate date]);
        [self MonthPicker];
        [self dismissViewControllerAnimated:YES completion:nil];
        
        

        [self dismissViewControllerAnimated:YES completion:nil];
        
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Yearly" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        type = Yearly;
        _currentMonth = getDate([NSDate date]);
        [self MonthPicker];
        [self dismissViewControllerAnimated:YES completion:nil];
        
        

        [self dismissViewControllerAnimated:YES completion:nil];
        
    }]];
    
    [self presentViewController:actionSheet animated:YES completion:nil];
    
}

-(void)sorting: (NSString *)sort {
    [self.values removeAllObjects];
    NSFetchRequest *desFetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Expense"];
    desFetchRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:sort ascending:YES]];
    self.values = [[self getContext] executeFetchRequest:desFetchRequest error:nil].mutableCopy;
    [self.myTableView reloadData];
}

- (IBAction)sortButton:(id)sender {
    
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"" message:@"Show Spending" preferredStyle:UIAlertControllerStyleActionSheet];
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Date" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self sorting:@"date"];
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }]];
    
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Amount" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self sorting:@"amount"];
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Category (A-Z)" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self sorting:@"type"];
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }]];
    
   
    
    [self presentViewController:actionSheet animated:YES completion:nil];
}

- (IBAction)PreviousMonthButton:(id)sender {
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

#pragma -mark SearchbarDelegate
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    
    [searchBar resignFirstResponder];
    
}


-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    [searchBar resignFirstResponder];
    
}

-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    
    searchBar.showsCancelButton = YES;
    return YES;
}

-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    
    searchBar.showsCancelButton = NO;
    
}


-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"Expense" inManagedObjectContext:[self getContext]];
    [fetchRequest setEntity:entity];
    
    NSError *error;
    
    NSArray* searchResults = [[self getContext] executeFetchRequest:fetchRequest error:&error];
 
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"type == %@", _values, searchText];
    [fetchRequest setPredicate:predicate];
    
        if (searchText.length == 0) {
            [_values removeAllObjects];
            [_values addObjectsFromArray:searchResults];
    
        }
    
        else {
            [_values removeAllObjects];
            for (NSString *search in searchResults) {
                NSRange r = [[search valueForKey:@"type"] rangeOfString:searchText];
                if (r.location != NSNotFound) {
                    [_values addObject:search];
                }

            }
        }
        

    [self.myTableView reloadData];
}

@end
