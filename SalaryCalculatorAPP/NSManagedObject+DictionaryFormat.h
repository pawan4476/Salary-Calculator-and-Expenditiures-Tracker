//
//  NSManagedObject+DictionaryFormat.h
//  SalaryCalculatorAPP
//
//  Created by Shridhar on 1/29/17.
//  Copyright © 2017 chaitanya. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSManagedObject (DictionaryFormat)

- (NSDictionary *)getDictionaryFormat;
- (void)setValuesFromDictionary:(NSDictionary *)dict;

@end
