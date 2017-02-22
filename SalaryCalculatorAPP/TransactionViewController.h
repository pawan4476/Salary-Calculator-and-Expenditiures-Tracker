//
//  TransactionViewController.h
//  SalaryCalculatorAPP
//
//  Created by test on 1/12/17.
//  Copyright © 2017 chaitanya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Expense+CoreDataProperties.h"



@interface TransactionViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UITextFieldDelegate, UIDocumentInteractionControllerDelegate>

@property (strong, nonatomic) IBOutlet UITableView *myTableView;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *editButtonOutlet;
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) IBOutlet UITextField *allCategoriesTF;
@property (strong, nonatomic) IBOutlet UILabel *incomeLb;
@property (strong, nonatomic) IBOutlet UILabel *expenseLb;
@property (strong, nonatomic) IBOutlet UIButton *choosePickerButtonOutlet;
@property (strong, nonatomic) IBOutlet UILabel *backgroundLb;

- (IBAction)ChoosePickerButton:(id)sender;
- (IBAction)sortButton:(id)sender;
- (IBAction)PreviousMonthButton:(id)sender;
- (IBAction)nextMonthButton:(id)sender;
- (IBAction)addButton:(id)sender;
- (IBAction)editButton:(id)sender;
- (IBAction)transctnShare:(id)sender;


@property (strong, nonatomic) NSDate *currentMonth;
@property (strong, nonatomic) NSArray *category;
@property (strong, nonatomic) UIPickerView *picker;
@property (strong, nonatomic) NSMutableArray *values;
@property (strong, nonatomic) Expense *editingObjct;
@property (retain) UIDocumentInteractionController *documentationInteractionController;


@end
