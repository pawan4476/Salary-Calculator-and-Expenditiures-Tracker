//
//  IncomeCategoryViewController.m
//  SalaryCalculatorAPP
//
//  Created by test on 1/13/17.
//  Copyright © 2017 chaitanya. All rights reserved.
//

#import "IncomeCategoryViewController.h"

@interface IncomeCategoryViewController ()

@end

@implementation IncomeCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.incomeCategory = [[NSArray alloc]initWithObjects:@"Salary", @"Equities", @"Personal Savings", @"Rents and royalities", @"Home equlity", @"Part-time work", @"Pensions", @"Annuities", @"Social Security", @"Others", nil];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma -mark TableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.incomeCategory.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = self.incomeCategory[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.delegate incomeCategory:[NSString stringWithFormat:@"%@", [_incomeCategory objectAtIndex:indexPath.row]]];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
