//
//  AboutViewController.m
//  SalaryCalculatorAPP
//
//  Created by Nagam Pawan on 1/28/17.
//  Copyright © 2017 chaitanya. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"Salary Calculator and Expenditures.html" ofType:nil]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.myWebView loadRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [UIApplication sharedApplication] .networkActivityIndicatorVisible = YES;
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [UIApplication sharedApplication] .networkActivityIndicatorVisible = NO;
}

@end
