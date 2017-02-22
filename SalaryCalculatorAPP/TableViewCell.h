//
//  TableViewCell.h
//  SalaryCalculatorAPP
//
//  Created by test on 1/12/17.
//  Copyright © 2017 chaitanya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *categoryLb;
@property (strong, nonatomic) IBOutlet UILabel *dateLb;
@property (strong, nonatomic) IBOutlet UILabel *amountLb;

@end
