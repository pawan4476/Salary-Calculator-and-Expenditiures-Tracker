//
//  CategoryViewController.m
//  SalaryCalculatorAPP
//
//  Created by test on 1/12/17.
//  Copyright © 2017 chaitanya. All rights reserved.
//

#import "CategoryViewController.h"

@interface CategoryViewController ()
{
    NSArray *category;
}

@end

@implementation CategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    category = [[NSArray alloc]initWithObjects:@"Food", @"Health Care", @"Travels", @"Loans", @"Automobile", @"Entertainment", @"Family", @"Insurance", @"Tax", @"Household", @"Fuel", @"Funds", @"Others", nil];
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
    return category.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = [category objectAtIndex:indexPath.row];
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_delegate category:[NSString stringWithFormat:@"%@", [category objectAtIndex:indexPath.row]]];
    [self.navigationController popViewControllerAnimated:YES];
}
@end
