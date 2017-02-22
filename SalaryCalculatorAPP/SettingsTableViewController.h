//
//  SettingsTableViewController.h
//  SalaryCalculatorAPP
//
//  Created by Nagam Pawan on 1/20/17.
//  Copyright © 2017 chaitanya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Expense+CoreDataProperties.h"
#import <ObjectiveDropboxOfficial/ObjectiveDropboxOfficial.h>
#import <MessageUI/MessageUI.h>
@interface SettingsTableViewController : UITableViewController<NSCoding, MFMailComposeViewControllerDelegate>

@property (strong, nonatomic) Expense *expense;
@property (strong, nonatomic) NSIndexPath *path;

@property (weak, nonatomic) IBOutlet UISwitch *dropSwitchButton;

- (IBAction)dropSwitch:(id)sender;
- (IBAction)backUpButton:(id)sender;
- (IBAction)feedBack:(id)sender;
- (IBAction)shareToFriends:(id)sender;
- (IBAction)rateReview:(id)sender;

@end
