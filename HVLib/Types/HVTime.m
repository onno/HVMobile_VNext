//
//  HVTime.m
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

#import "HVCommon.h"
#import "HVTime.h"

static const xmlChar* x_element_hour = XMLSTRINGCONST("h");
static const xmlChar* x_element_minute = XMLSTRINGCONST("m");
static const xmlChar* x_element_second = XMLSTRINGCONST("s");
static const xmlChar* x_element_millis = XMLSTRINGCONST("f");

@implementation HVTime

-(NSInteger) hour
{
    return (m_hours ? m_hours.value : -1);
}

-(void) setHour:(NSInteger) hours
{
    if (hours >= 0)
    {
        HVENSURE(m_hours, HVHour);
        m_hours.value = hours;
    }
    else
    {
        HVCLEAR(m_hours);
    }
}

-(NSInteger) minute
{
    return (m_minutes ? m_minutes.value : -1);
}

-(void) setMinute:(NSInteger)minutes
{
    if (minutes >= 0)
    {
        HVENSURE(m_minutes, HVMinute);
        m_minutes.value = minutes;        
    }
    else
    {
        HVCLEAR(m_minutes);
    }
}

-(BOOL)hasSecond
{
    return (m_seconds != nil);
}

-(NSInteger) second
{
    return (m_seconds ? m_seconds.value : -1);
}

-(void) setSecond:(NSInteger)seconds
{
    if (seconds >= 0)
    {
        HVENSURE(m_seconds, HVSecond);
        m_seconds.value = seconds;       
    }
    else
    {
        HVCLEAR(m_seconds);
    }
}

-(BOOL)hasMillisecond
{
    return (m_seconds != nil);
}

-(NSInteger) millisecond
{
    return (m_milliseconds ? m_milliseconds.value : -1);
}

-(void) setMillisecond:(NSInteger)milliseconds
{
    if (milliseconds >= 0)
    {
        HVENSURE(m_milliseconds, HVMillisecond);
        m_milliseconds.value = milliseconds;
        
    }
    else
    {
        HVCLEAR(m_milliseconds);
    }
}

+(void)initialize
{
}

-(id)initWithHour:(NSInteger)hour minute:(NSInteger)minute
{
    return [self initWithHour:hour minute:minute second:-1];
}

-(id) initWithHour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second
{
    self = [super init];
    HVCHECK_SELF;
    
    if (hour != NSUndefinedDateComponent)
    {
        m_hours = [[HVHour alloc] initWith:hour];
    }
    HVCHECK_NOTNULL(m_hours);
    
    if (minute != NSUndefinedDateComponent)
    {
        m_minutes = [[HVMinute alloc] initWith:minute];
    }
    HVCHECK_NOTNULL(m_minutes);
    
    if (second >= 0 && second != NSUndefinedDateComponent)
    {
        m_seconds = [[HVSecond alloc] initWith:second];
        HVCHECK_NOTNULL(m_seconds);
    }
        
    return self;

LError:
    HVALLOC_FAIL;
}

-(id) initwithComponents:(NSDateComponents *)components
{
    HVCHECK_NOTNULL(components);
    
    return [self initWithHour:[components hour] minute:[components minute] second:[components second]];
     
LError:
    HVALLOC_FAIL;    
}

-(id) initWithDate:(NSDate *)date
{
    HVCHECK_NOTNULL(date);
    
    return [self initwithComponents:[NSCalendar componentsFromDate:date]]; 
      
LError:
    HVALLOC_FAIL;
}

+(HVTime *)fromHour:(NSInteger)hour andMinute:(NSInteger)minute
{
    return [[[HVTime alloc] initWithHour:hour minute:minute] autorelease];
}

-(void) dealloc
{
    [m_hours release];
    [m_minutes release];
    [m_seconds release];
    [m_milliseconds release];
    [super dealloc];
}

-(NSDateComponents *) toComponents
{
    NSDateComponents *components = [[NSCalendar newComponents] autorelease];
    HVCHECK_NOTNULL(components);
 
    HVCHECK_SUCCESS([self getComponents:components]);     
    
    return components;
    
LError:
    return nil;
}

-(BOOL) getComponents:(NSDateComponents *)components
{
    HVCHECK_NOTNULL(components);
  
    if (m_hours)
    {
        [components setHour:self.hour];
    }
    if (m_minutes)
    {
        [components setMinute:self.minute];        
    }
    if (m_seconds)
    {
        [components setSecond:self.second];
    }
    
    return TRUE;
    
LError:
    return FALSE;
}

-(NSDate *) toDate
{
    NSDateComponents *components = [NSCalendar newComponents];
    HVCHECK_NOTNULL(components);
    
    HVCHECK_SUCCESS([self getComponents:components]);
    
    NSDate* newDate = [components date];
    [components release];
    
    return newDate;
    
LError:
    [components release];
    return nil;
}

-(BOOL)setWithComponents:(NSDateComponents *)components 
{
    HVCHECK_NOTNULL(components);
    
    self.hour = [components hour];
    self.minute = [components minute];
    self.second = [components second];
    
    return TRUE;

LError:
    return FALSE;
}

-(BOOL)setWithDate:(NSDate *)date
{
    HVCHECK_NOTNULL(date);
    
    return [self setWithComponents:[NSCalendar componentsFromDate:date]]; 
    
LError:
    return FALSE;
}

-(NSString *)description
{
    return [self toString];
}

-(NSString *) toString
{
    return [self toStringWithFormat:@"hh:mm aaa"];
}

-(NSString *)toStringWithFormat:(NSString *)format
{
    NSDate *date = [self toDate];
    return [date toStringWithFormat:format];
}

-(HVClientResult *) validate
{
    HVVALIDATE_BEGIN;
    
    HVVALIDATE(m_hours, HVClientError_InvalidTime);
    HVVALIDATE(m_minutes, HVClientError_InvalidTime);
    HVVALIDATE_OPTIONAL(m_seconds);
    HVVALIDATE_OPTIONAL(m_milliseconds);
    
    HVVALIDATE_SUCCESS;
    
LError:
    HVVALIDATE_FAIL;
}

-(void) serialize:(XWriter *)writer
{
    HVSERIALIZE_X(m_hours, x_element_hour);
    HVSERIALIZE_X(m_minutes, x_element_minute);
    HVSERIALIZE_X(m_seconds, x_element_second);
    HVSERIALIZE_X(m_milliseconds, x_element_millis);
}

-(void) deserialize:(XReader *)reader
{
    HVDESERIALIZE_X(m_hours, x_element_hour, HVHour);
    HVDESERIALIZE_X(m_minutes, x_element_minute, HVMinute);
    HVDESERIALIZE_X(m_seconds, x_element_second, HVSecond);
    HVDESERIALIZE_X(m_milliseconds, x_element_millis, HVMillisecond);
}

@end

@implementation HVTimeCollection

-(id)init
{
    self = [super init];
    HVCHECK_SELF;
    
    self.type = [HVTime class];
    
    return self;
    
LError:
    HVALLOC_FAIL;
}

-(HVTime *)itemAtIndex:(NSUInteger)index
{
    return (HVTime *) [self objectAtIndex:index];
}

@end
