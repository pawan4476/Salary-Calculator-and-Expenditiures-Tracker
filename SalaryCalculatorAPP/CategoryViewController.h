//
//  CategoryViewController.h
//  SalaryCalculatorAPP
//
//  Created by test on 1/12/17.
//  Copyright © 2017 chaitanya. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CategoryViewControllerDelegate <NSObject>

-(void)category: (NSString *)text;

@end

@interface CategoryViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *myTableView;
@property (strong, nonatomic) id<CategoryViewControllerDelegate> delegate;

@end
