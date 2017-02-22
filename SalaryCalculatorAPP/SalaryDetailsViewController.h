//
//  SalaryDetailsViewController.h
//  SalaryCalculatorAPP
//
//  Created by test on 12/13/16.
//  Copyright © 2016 chaitanya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SalaryDetailsViewController : UIViewController<UIDocumentInteractionControllerDelegate>
@property (strong, nonatomic) IBOutlet UILabel *basicLb;
@property (strong, nonatomic) IBOutlet UILabel *HRALb;
@property (strong, nonatomic) IBOutlet UILabel *medicalAllowanceLb;
@property (strong, nonatomic) IBOutlet UILabel *conveyanceLb;
@property (strong, nonatomic) IBOutlet UILabel *allowanceLb;
@property (strong, nonatomic) IBOutlet UILabel *EmployerPFLb;
@property (strong, nonatomic) IBOutlet UILabel *EmployerESILb;
@property (strong, nonatomic) IBOutlet UILabel *EmployeePFLb;
@property (strong, nonatomic) IBOutlet UILabel *EmployeeESILb;
@property (strong, nonatomic) IBOutlet UILabel *PTLb;
@property (strong, nonatomic) IBOutlet UILabel *CTCLb;
@property (strong, nonatomic) IBOutlet UILabel *totalDeductionLb;
@property (strong, nonatomic) IBOutlet UILabel *netSalaryLb;
@property (weak, nonatomic) IBOutlet UIView *myView;

@property (assign, nonatomic) float basic;
@property (assign, nonatomic) float basic2;
@property (assign, nonatomic) float gross;
@property (assign, nonatomic) float medical;
@property (assign, nonatomic) float conveyance;
@property (assign, nonatomic) float allowance;
@property (strong, nonatomic) NSData *imageData;
@property (strong, nonatomic) UIImage *screenShotImage;
@property (retain) UIDocumentInteractionController *documentationInteractionController;


- (IBAction)shareScreenShot:(id)sender;
- (IBAction)basicHelp:(id)sender;
- (IBAction)hraHelp:(id)sender;
- (IBAction)medAlwncHelp:(id)sender;
- (IBAction)conveyanceHelp:(id)sender;
- (IBAction)allowanceHelp:(id)sender;
- (IBAction)employerPFHelp:(id)sender;
- (IBAction)employerESIHelp:(id)sender;
- (IBAction)employeePFHelp:(id)sender;
- (IBAction)employeeESIHelp:(id)sender;
- (IBAction)PTHelp:(id)sender;
- (IBAction)CTCHelp:(id)sender;
- (IBAction)DeductionHelp:(id)sender;
- (IBAction)takeHomeHelp:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *basicButton;
@property (weak, nonatomic) IBOutlet UIButton *hraButton;
@property (weak, nonatomic) IBOutlet UIButton *mdclAlwncButton;
@property (weak, nonatomic) IBOutlet UIButton *conveyanceButton;
@property (weak, nonatomic) IBOutlet UIButton *allowanceButton;
@property (weak, nonatomic) IBOutlet UIButton *employerPFButton;
@property (weak, nonatomic) IBOutlet UIButton *employerEAIButton;
@property (weak, nonatomic) IBOutlet UIButton *employeeButton;
@property (weak, nonatomic) IBOutlet UIButton *employeeESIButton;
@property (weak, nonatomic) IBOutlet UIButton *PTButton;
@property (weak, nonatomic) IBOutlet UIButton *CTCButton;
@property (weak, nonatomic) IBOutlet UIButton *totalDeductionButton;
@property (weak, nonatomic) IBOutlet UIButton *takeHomeButton;


@end
