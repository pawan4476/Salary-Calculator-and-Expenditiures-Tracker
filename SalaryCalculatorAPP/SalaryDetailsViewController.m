//
//  SalaryDetailsViewController.m
//  SalaryCalculatorAPP
//
//  Created by test on 12/13/16.
//  Copyright © 2016 chaitanya. All rights reserved.
//

#import "SalaryDetailsViewController.h"

@interface SalaryDetailsViewController ()

@end

@implementation SalaryDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.myView.layer.cornerRadius = 3.0;
    self.myView.layer.borderWidth = 2.0;
    self.myView.layer.borderColor = [[UIColor blackColor] CGColor];
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc]init];
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [numberFormatter setMaximumFractionDigits:2];
    [numberFormatter setRoundingMode:NSNumberFormatterRoundUp];
    
    if (self.basic > 0){
        
        self.basicLb.text = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:self.basic]];
        self.HRALb.text = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:self.basic*0.4]];
        self.EmployerPFLb.text = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:self.basic*0.131]];
        self.EmployeePFLb.text = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:self.basic*0.12]];
        
    }
    else{
        
        self.basicLb.text = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:self.basic2]];
        self.HRALb.text = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:self.basic2*0.4]];
        self.EmployerPFLb.text = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:self.basic2*0.131]];
        self.EmployeePFLb.text = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:self.basic2*0.12]];
        
    }
    
    if (self.gross < 15000 ) {
        self.EmployerESILb.text = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:self.gross*0.0475]];
        self.EmployeeESILb.text = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:self.gross*0.0175]];
        self.PTLb.text = @"0";
        if (self.basic > 0) {
            self.CTCLb.text = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:self.gross + self.basic*0.131 + self.gross*0.0475+0]];
            self.totalDeductionLb.text = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:0+self.gross*0.0175 + self.basic*0.12]];
            self.netSalaryLb.text = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:self.gross - (0+self.gross*0.0175 + self.basic*0.12)]];
        } else {
            self.CTCLb.text = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:self.gross + self.basic2*0.131 + self.gross*0.0475+0]];
            self.totalDeductionLb.text = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:0+self.gross*0.0175 + self.basic2*0.12]];
            self.netSalaryLb.text = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:self.gross - (0+self.gross*0.0175 + self.basic2*0.12)]];
            
        }
    } else {
        
        self.EmployerESILb.text = @"0";
        self.EmployeeESILb.text = @"0";
        self.PTLb.text = @"200";
        
        if (self.basic > 0) {
            self.CTCLb.text = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:self.gross + self.basic*0.131 + 0+200]];
            self.totalDeductionLb.text = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:200 + self.basic*0.12 + 0]];
            self.netSalaryLb.text = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:self.gross - (200 + self.basic*0.12 + 0)]];
            
            
        } else {
            self.CTCLb.text = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:self.gross + self.basic2*0.131 + 0+200]];
            self.totalDeductionLb.text = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:200 + self.basic2*0.12 + 0]];
            self.netSalaryLb.text = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:self.gross - (200 + self.basic2*0.12 + 0)]];
            
        }
        
    }
    
    if (self.basic > 0) {
        if ((self.basic + (self.basic *0.4) + 1250 + 1600) > self.gross) {
            self.medicalAllowanceLb.text = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:(9.6/21.9) * (self.gross - (self.basic + self.basic*0.4))]];
            self.conveyanceLb.text = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:(12.31/21.9) * (self.gross - (self.basic + self.basic*0.4))]];
            self.allowanceLb.text = @"0";
        } else {
            self.medicalAllowanceLb.text = @"1250";
            self.conveyanceLb.text = @"1600";
            self.allowanceLb.text = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:self.gross - (self.basic + self.basic * 0.4 + 1250 + 1600)]];
        }
    }
    else {
        
        if ((self.basic2 + (self.basic2 *0.4) + 1250 + 1600) > self.gross) {
            self.medicalAllowanceLb.text = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:(9.6/21.9) * (self.gross - (self.basic2 + self.basic2*0.4))]];
            self.conveyanceLb.text = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:(12.31/21.9) * (self.gross - (self.basic2 + self.basic2*0.4))]];
            self.allowanceLb.text = @"0";
        } else {
            self.medicalAllowanceLb.text = @"1250";
            self.conveyanceLb.text = @"1600";
            self.allowanceLb.text = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:self.gross - (self.basic2 + self.basic2 * 0.4 + 1250 + 1600)]];
        }
        
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];

}

#pragma -mark ShareScreenShot
- (IBAction)shareScreenShot:(id)sender {
    
    self.basicButton.hidden = YES;
    self.hraButton.hidden = YES;
    self.mdclAlwncButton.hidden = YES;
    self.conveyanceButton.hidden = YES;
    self.allowanceButton.hidden = YES;
    self.employerPFButton.hidden = YES;
    self.employerEAIButton.hidden = YES;
    self.employeeButton.hidden = YES;
    self.employeeESIButton.hidden = YES;
    self.PTButton.hidden = YES;
    self.CTCButton.hidden = YES;
    self.totalDeductionButton.hidden = YES;
    self.takeHomeButton.hidden = YES;
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
        
        UIGraphicsBeginImageContextWithOptions(self.myView.bounds.size, NO, [UIScreen mainScreen].scale);
        
    }
    
    else{
        
        UIGraphicsBeginImageContext(self.myView.bounds.size);
        
    }
    
    [self.myView.layer renderInContext:UIGraphicsGetCurrentContext()];
    self.screenShotImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.imageData = UIImagePNGRepresentation(self.screenShotImage);
    if (self.imageData) {
        
        [self.imageData writeToFile:@"screenshot.png" atomically:YES];
        
    }
    else{
        
        NSLog(@"Error while taking screen shot");
        
    }
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Share" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    alert.popoverPresentationController.sourceView = self.view;
    alert.popoverPresentationController.sourceRect = CGRectMake(self.view.bounds.size.width - 34, 20, 0, 0);

    UIAlertAction *wtsap = [UIAlertAction actionWithTitle:@"WhatsApp" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        
        self.basicButton.hidden = NO;
        self.hraButton.hidden = NO;
        self.mdclAlwncButton.hidden = NO;
        self.conveyanceButton.hidden = NO;
        self.allowanceButton.hidden = NO;
        self.employerPFButton.hidden = NO;
        self.employerEAIButton.hidden = NO;
        self.employeeButton.hidden = NO;
        self.employeeESIButton.hidden = NO;
        self.PTButton.hidden = NO;
        self.CTCButton.hidden = NO;
        self.totalDeductionButton.hidden = NO;
        self.takeHomeButton.hidden = NO;
        
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"whatsapp://app"]]) {
            
            UIImage *image = [UIImage imageWithData:self.imageData];
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
    
    UIAlertAction *more = [UIAlertAction actionWithTitle:@"More" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        
        NSString *mgs = @"Pay Slip";
        NSArray *array = @[mgs, self.imageData];
        UIActivityViewController *activity = [[UIActivityViewController alloc]initWithActivityItems:array applicationActivities:nil];
        activity.popoverPresentationController.sourceView = self.view;
        activity.popoverPresentationController.sourceRect = CGRectMake(self.view.bounds.size.width - 34, 20, 0, 0);

        [self presentViewController:activity animated:YES completion:nil];
        self.basicButton.hidden = NO;
        self.hraButton.hidden = NO;
        self.mdclAlwncButton.hidden = NO;
        self.conveyanceButton.hidden = NO;
        self.allowanceButton.hidden = NO;
        self.employerPFButton.hidden = NO;
        self.employerEAIButton.hidden = NO;
        self.employeeButton.hidden = NO;
        self.employeeESIButton.hidden = NO;
        self.PTButton.hidden = NO;
        self.CTCButton.hidden = NO;
        self.totalDeductionButton.hidden = NO;
        self.takeHomeButton.hidden = NO;
        
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        self.basicButton.hidden = NO;
        self.hraButton.hidden = NO;
        self.mdclAlwncButton.hidden = NO;
        self.conveyanceButton.hidden = NO;
        self.allowanceButton.hidden = NO;
        self.employerPFButton.hidden = NO;
        self.employerEAIButton.hidden = NO;
        self.employeeButton.hidden = NO;
        self.employeeESIButton.hidden = NO;
        self.PTButton.hidden = NO;
        self.CTCButton.hidden = NO;
        self.totalDeductionButton.hidden = NO;
        self.takeHomeButton.hidden = NO;
        
    }];
    
    [alert addAction:cancel];
    [alert addAction:wtsap];
    [alert addAction:more];
    [self presentViewController:alert animated:YES completion:nil];
    
}

#pragma -mark Help
- (IBAction)basicHelp:(id)sender {
    
    [self createAlert:@"Basic Pay" :@"This is the most important part of a salary slip as many of the other components are structured around it. It is 100% taxable"];
    
}

- (IBAction)hraHelp:(id)sender {
    
    [self createAlert:@"House Rent Allowance" :@"It is an allowance to pay your house rent. Normally, HRA is 40-50% of the basic, based on your location"];
    
}

- (IBAction)medAlwncHelp:(id)sender {
    
    [self createAlert:@"Medical Allowance" :@"Employer can give any amount as medical allowance (not more then Basic), but out of it only Rs 1250/- per month or Rs 15000/- per annum is tax free"];
    
}

- (IBAction)conveyanceHelp:(id)sender {
    
    [self createAlert:@"Conveyance/Transport Allowance" :@"This allowance is meant to support the expenses employee incurred in travelling to and fro from office. There is no limit on payment but only Rs 1600/- per month is tax free."];
    
}

- (IBAction)allowanceHelp:(id)sender {
    
    [self createAlert:@"Allowance" :@"Whatever the balance is left to be paid to employee after the above allowances, gets paid under this allowance. It is 100% taxable"];
}

- (IBAction)employerPFHelp:(id)sender {
    
    [self createAlert:@"Employer Provident Fund" :@"It is a retirement benifit scheme. This fund is maintained and overseen by the Employees Provident Fund Organisation of India(EPFO). Employee and Employer both contribute 12% of your basic salary into your EPF account. If your basic pay is above Rs 6500/- per month, employer can contribute 8.33% of 6,500(i.e.Rs.541) and employee contribute remaining 3.67% of basic pay"];
    
}

- (IBAction)employerESIHelp:(id)sender {
    
    [self createAlert:@"Employer State Insurance Fund" :@"It is maintained by ESIC, is applicable to employees earning Rs 15,000 or less per month to provide the cash and medical benefits to them and their families. This is contributory fund in which both the employer and employee contribute 4.75% and 1.75% respectively to make it total of 6.5%."];
}

- (IBAction)employeePFHelp:(id)sender {
    
    [self createAlert:@"Employee Provident Fund" :@"It is a retirement benifit scheme. This fund is maintained and overseen by the Employees Provident Fund Organisation of India(EPFO). Employee and Employer both contribute 12% of your basic salary into your EPF account. If your basic pay is above Rs 6500/- per month, employer can contribute 8.33% of 6,500(i.e.Rs.541) and employee contribute remaining 3.67% of basic pay"];
    
}

- (IBAction)employeeESIHelp:(id)sender {
    
    [self createAlert:@"Employee State Insurance Fund" :@"It is maintained by ESIC, is applicable to employees earning Rs 15,000 or less per month to provide the cash and medical benefits to them and their families. This is contributory fund in which both the employer and employee contribute 4.75% and 1.75% respectively to make it total of 6.5%."];
    
}

- (IBAction)PTHelp:(id)sender {
    
    [self createAlert:@"Professional Tax" :@"This tax is levied at the state level. If your gross is above Rs 15000/- per month the PT is Rs 200/- per month. The maximum tax payed by the employee is Rs 2,400/- per annum"];
    
}

- (IBAction)CTCHelp:(id)sender {
    
    [self createAlert:@"Cost To Company" :@"It is the cost a company incurs when hiring an employee. CTC involves a number of other elements and is cumulative Employer PF, Employer ESI which are added to the Gross salary"];
    
}

- (IBAction)DeductionHelp:(id)sender {
    
    [self createAlert:@"Deductions" :@"It is the total deductions of employee salary. It sum of Employee PF,Employee ESI and Professional Tax"];
    
}

- (IBAction)takeHomeHelp:(id)sender {
    
    [self createAlert:@"Take Home" :@"It is the take home salary which is the Gross salary minus total deductions"];
    
}

#pragma -mark CreateAlert
-(void)createAlert :(NSString *)title :(NSString *)message{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];

}
@end
