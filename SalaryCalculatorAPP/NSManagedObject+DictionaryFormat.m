//
//  NSManagedObject+DictionaryFormat.m
//  SalaryCalculatorAPP
//
//  Created by Shridhar on 1/29/17.
//  Copyright © 2017 chaitanya. All rights reserved.
//

#import "NSManagedObject+DictionaryFormat.h"

@implementation NSManagedObject (DictionaryFormat)


- (NSDictionary *)getDictionaryFormat {
    NSEntityDescription *entity = [self entity];
    NSDictionary *attributes = [entity attributesByName];
    NSArray* keys = [attributes allKeys];
    NSMutableDictionary* dict = [NSMutableDictionary dictionary];
    for (NSString *attribute in keys) {
        id value = [self valueForKey: attribute];
        if (value != nil && [value isKindOfClass:[NSNull class]] == false) {
            [dict setObject:value forKey:attribute];
        }
        
    }
    
    return dict;
}

- (void)setValuesFromDictionary:(NSDictionary *)dict {
    
    NSArray* keys = [dict allKeys];
    
    for (NSString *attribute in keys) {
        id value = [dict valueForKey: attribute];
        [self setValue:value forKey:attribute];
    }
}

@end
