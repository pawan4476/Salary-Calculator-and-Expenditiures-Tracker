//
//  Expense+CoreDataProperties.m
//  SalaryCalculatorAPP
//
//  Created by test on 1/19/17.
//  Copyright © 2017 chaitanya. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "Expense+CoreDataProperties.h"

@implementation Expense (CoreDataProperties)

+ (NSFetchRequest<Expense *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Expense"];
}

@dynamic amount;
@dynamic date;
@dynamic isExpense;
@dynamic notes;
@dynamic type;

@end
