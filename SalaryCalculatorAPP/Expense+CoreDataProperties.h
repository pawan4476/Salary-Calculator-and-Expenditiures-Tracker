//
//  Expense+CoreDataProperties.h
//  SalaryCalculatorAPP
//
//  Created by test on 1/19/17.
//  Copyright © 2017 chaitanya. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "Expense+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Expense (CoreDataProperties)

+ (NSFetchRequest<Expense *> *)fetchRequest;

@property (nonatomic) float amount;
@property (nullable, nonatomic, copy) NSDate *date;
@property (nonatomic) BOOL isExpense;
@property (nullable, nonatomic, copy) NSString *notes;
@property (nullable, nonatomic, copy) NSString *type;

@end

NS_ASSUME_NONNULL_END
