

//
//  SalaryViewController.m
//  SalaryCalculatorAPP
//
//  Created by test on 12/13/16.
//  Copyright © 2016 chaitanya. All rights reserved.
//

#import "SalaryViewController.h"
#import "SalaryDetailsViewController.h"

@interface SalaryViewController ()

@end

@implementation SalaryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    
    self.basicinPercentageTF.text = @"30";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma -mark TapGesture
- (IBAction)tapGesture:(id)sender {
    
    [self.grossTF resignFirstResponder];
    [self.basicinPercentageTF resignFirstResponder];
    [self.basicinValueTF resignFirstResponder];
    [self.payDaysTF resignFirstResponder];
    [self.attendedTF resignFirstResponder];
    
}

#pragma -mark Calculate
- (IBAction)Calculate:(id)sender {
    
    BOOL missingFields = false;

    if (self.grossTF.text.length == 0) {
        missingFields = true;
        self.titleString = @"Required Fields are empty";
        self.message = @"Please enter the gross value";
    } else if (self.basicinPercentageTF.text.length == 0 && self.basicinValueTF.text.length == 0) {
        missingFields = true;
        self.titleString = @"Requored fields are empty";
        self.message = @"Please enter the basic value";
    } else if (self.basicinPercentageTF.text.length > 0 && self.basicinValueTF.text.length > 0) {
        missingFields = true;
        self.titleString = @"Entered both basic values";
        self.message = @"Please enter basic pay in Percentage (or) in value";
    } else if (self.payDaysTF.text.length == 0) {
        missingFields = true;
        self.titleString = @"Required fields are empty";
        self.message = @"Please enter the paydays value";
    } else if (self.attendedTF.text.length == 0) {
        missingFields = true;
        self.titleString = @"Required fields are empty";
        self.message = @"Please enter the attended value";
        
    }

    if (missingFields == true){
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:self.titleString message:self.message preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *Ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:Ok];
        [self presentViewController:alert animated:YES completion:nil];
        
    }
    else {
        self.value = [self.grossTF.text floatValue] * ([self.basicinPercentageTF.text floatValue]/100);
        self.HRA = [self.basicinValueTF.text floatValue] * 0.4;
        if ((self.value  + (self.value * 0.4)) > [self.grossTF.text floatValue]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Please enter the Basic value less than  Gross value" message:@"Basic value must be <= 70% of Gross value" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *Ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:Ok];
            [self presentViewController:alert animated:YES completion:nil];
        }
        
        
        if (([self.basicinValueTF.text floatValue]  + self.HRA) > [self.grossTF.text floatValue]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Please enter the Basic value less than  Gross value" message:@"Basic value must be <= 70% of Gross value" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *Ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:Ok];
            [self presentViewController:alert animated:YES completion:nil];
        }
        
        if (self.attendedTF.text.floatValue > self.payDaysTF.text.floatValue) {
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Please enter the Attended days less than Pay days" message:@"Attended days must be <= Pay days" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *ok = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:ok];
            [self presentViewController:alert animated:YES completion:nil];
            
        }
    }


}

#pragma -mark PrepareForSegue
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"send"]) {
        SalaryDetailsViewController *vc = [segue destinationViewController];
        
        vc.basic = (((self.grossTF.text.floatValue * self.basicinPercentageTF.text.floatValue/100)/ self.payDaysTF.text.floatValue) * self.attendedTF.text.floatValue);
        
        
        vc.basic2 = (([self.basicinValueTF.text floatValue])/ [self.payDaysTF.text floatValue]) *[self.attendedTF.text floatValue];
        vc.gross = (self.grossTF.text.floatValue / self.payDaysTF.text.floatValue) * self.attendedTF.text.floatValue;
        
    }
}

@end
