//
//  PersonalTableviewCell.h
//  SalaryCalculatorAPP
//
//  Created by Nagam Pawan on 1/23/17.
//  Copyright © 2017 chaitanya. All rights reserved.
//

#import "TableViewCell.h"

@interface PersonalTableviewCell : TableViewCell
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;

@end
