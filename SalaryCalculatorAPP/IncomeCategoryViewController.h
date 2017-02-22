//
//  IncomeCategoryViewController.h
//  SalaryCalculatorAPP
//
//  Created by test on 1/13/17.
//  Copyright © 2017 chaitanya. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol IncomeCategoryViewControllerDelegate <NSObject>

-(void)incomeCategory : (NSString *)text;

@end

@interface IncomeCategoryViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *myTableview;
@property (strong, nonatomic) id<IncomeCategoryViewControllerDelegate> delegate;
@property (strong, nonatomic) NSArray *incomeCategory;

@end
