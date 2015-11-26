//
//  HVDate.h
//  HVLib
//
//  Copyright (c) 2012 Microsoft Corporation. All rights reserved.
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

#import <Foundation/Foundation.h>
#import "HVType.h"
#import "HVDay.h"
#import "HVMonth.h"
#import "HVYear.h"

@interface HVDate : HVType
{
@protected
    HVYear  *m_year;
    HVMonth *m_month;
    HVDay   *m_day;
}

//-------------------------
//
// Data
//
//-------------------------
@property (readwrite, nonatomic) NSInteger year;
@property (readwrite, nonatomic) NSInteger month;
@property (readwrite, nonatomic) NSInteger day;

//-------------------------
//
// Initializers
//
//-------------------------
-(id) initWithYear:(NSInteger) year month:(NSInteger) monthValue day:(NSInteger) dayValue;
-(id) initNow;
-(id) initWithDate:(NSDate *) date;
-(id) initWithComponents:(NSDateComponents *) components;

+(HVDate *) fromYear:(NSInteger) year month:(NSInteger) month day:(NSInteger) day;
+(HVDate *) fromDate:(NSDate *) date;
+(HVDate *) now;

//-------------------------
//
// Methods
//
//-------------------------
-(NSDateComponents *) toComponents;
-(NSDateComponents *) toComponentsForCalendar:(NSCalendar *) calendar;
-(BOOL) getComponents:(NSDateComponents *) components;
-(NSDate *) toDate;
-(NSDate *) toDateForCalendar:(NSCalendar *) calendar;

-(BOOL) setWithDate:(NSDate *) date;
-(BOOL) setWithComponents:(NSDateComponents *) components;

//-------------------------
//
// Text
//
//-------------------------
-(NSString *) toString;
-(NSString *) toStringWithFormat:(NSString *) format;

@end
