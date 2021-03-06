//
//  DateTimeUtils.m
//  HealthVault Mobile Library for iOS
//
// Copyright 2011 Microsoft Corp.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
// 
// http://www.apache.org/licenses/LICENSE-2.0
// 
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#import "DateTimeUtils.h"
#import "HVDateExtensions.h"


@implementation DateTimeUtils

+ (NSString *)dateToUtcString: (NSDate *)date {

	NSDateFormatter *formatter = [NSDateFormatter new];
    NSLocale* locale = [NSDateFormatter newCultureNeutralLocale];
    [formatter setLocale:locale];
    
	[formatter setDateFormat: @"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
	[formatter setTimeZone: [NSTimeZone timeZoneWithAbbreviation: @"UTC"]];
	NSString *utcDateString = [formatter stringFromDate: date];
    
	[formatter release];
    [locale release];
    
	return utcDateString;
}
/*
+ (NSDate *)UtcStringToDate: (NSString *)string {
	
	NSDateFormatter *formatter = [NSDateFormatter new];
	[formatter setTimeZone: [NSTimeZone timeZoneWithAbbreviation: @"UTC"]];
	
	[formatter setDateFormat: @"yyyy-MM-dd'T'HH:mm:ss.SSS"];
	NSDate *utcDate = [formatter dateFromString: string];
	
	if (utcDate == nil) {
		
		[formatter setDateFormat: @"yyyy-MM-dd'T'HH:mm:ss"];
		utcDate = [formatter dateFromString: string];
	}
	
	[formatter release];
	
	return utcDate;
}
*/

@end
