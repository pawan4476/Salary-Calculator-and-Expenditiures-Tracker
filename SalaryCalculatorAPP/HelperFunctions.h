//
//  Header.h
//  SalaryCalculatorAPP
//
//  Created by Shridhar on 1/17/17.
//  Copyright © 2017 chaitanya. All rights reserved.
//

#ifndef Header_h
#define Header_h

#import<Foundation/Foundation.h>

static NSDate* getDate(NSDate* date) {
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    //create a date with these components
    components.hour = 0;
    components.minute = 0;
    components.second = 0;
    return [calendar dateFromComponents:components];
}

static NSDate* setInitialDayForTheDate(NSDate* date) {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    //create a date with these components
    components.day = 1;
    NSDate *newDate = [calendar dateFromComponents:components];
    return newDate;
}

static NSDate* addDays(NSDate* date, int numberOfDays) {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    //create a date with these components
    NSDate *newDate = [calendar dateFromComponents:components];
    
    components.day = numberOfDays;
    components.year = 0;
    components.month = 0;
    
    newDate = [calendar dateByAddingComponents:components toDate:newDate options:0];
    return newDate;
}

static NSDate* addMonths(NSDate* date, int numberOfMoths) {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    //create a date with these components
    NSDate *newDate = [calendar dateFromComponents:components];
    
    components.day = 0;
    components.month = numberOfMoths;
    components.year = 0;
    
    newDate = [calendar dateByAddingComponents:components toDate:newDate options:0];
    return newDate;
}

static NSDate* addYear(NSDate* date, int numberOfYears) {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    //create a date with these components
    NSDate *newDate = [calendar dateFromComponents:components];
    
    components.day = 0;
    components.month = 0;
    components.year = numberOfYears;
    
    newDate = [calendar dateByAddingComponents:components toDate:newDate options:0];
    return newDate;
}

static NSString* getStringFromDate(NSDate* date) {
    NSDateFormatter *formatter  = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"dd-MM-YYYY"];
    return [formatter stringFromDate:date];
    
}

static NSString* getMonthName(NSDate* date) {
    NSDateFormatter *formatter  = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"MMMM"];
    NSString* dateStr = [formatter stringFromDate:date];
    return dateStr;
}

static NSString* getWeekName(NSDate* date) {
    NSDateFormatter *formatter  = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"dd-MMM"];
    NSString* startDateStr = [formatter stringFromDate:date];
    
    NSDate* endDate = addDays(date, 7);
    NSString* endDateStr = [formatter stringFromDate:endDate];
    
    NSString* name = [NSString stringWithFormat:@"%@ - %@", startDateStr, endDateStr];
    return name;
}

static NSString* getYearName(NSDate* date) {
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY"];
    NSString* dateStr = [formatter stringFromDate:date];
    return dateStr;
}

#endif /* Header_h */
