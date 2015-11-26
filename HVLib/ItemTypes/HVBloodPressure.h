//
//  HVBloodPressure.h
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
#import "HVTypes.h"

@interface HVBloodPressure : HVItemDataTyped
{
@private
    HVDateTime* m_when;
    HVNonNegativeInt* m_systolic;
    HVNonNegativeInt* m_diastolic;
    HVNonNegativeInt* m_pulse;
    HVBool* m_heartbeat;
}

//-------------------------
//
// Data
//
//-------------------------
//
// (Required) When the blood pressure was taken
//
@property (readwrite, nonatomic, retain) HVDateTime* when;
//
// (Required) Systolic value. 
//  You can also use the convenience systolicValue property 
//
@property (readwrite, nonatomic, retain) HVNonNegativeInt* systolic;
//
// (Required) Diastolic value
// You can also use the convenience diastolicValue property
//
@property (readwrite, nonatomic, retain) HVNonNegativeInt* diastolic;
//
// (Optional) Pulse
// You can also use the convenience pulseValue property
// 
@property (readwrite, nonatomic, retain) HVNonNegativeInt* pulse;
//
// (Optional) True if irregular heartbeat
//
@property (readwrite, nonatomic, retain) HVBool *irregularHeartbeat;


//
// Convenience properties
//
@property (readwrite, nonatomic) NSInteger systolicValue;
@property (readwrite, nonatomic) NSInteger diastolicValue;
@property (readwrite, nonatomic) NSInteger pulseValue;


//-------------------------
//
// Initializers
//
//-------------------------

-(id) initWithSystolic:(NSInteger) sVal diastolic:(NSInteger) dVal;
-(id) initWithSystolic:(NSInteger) sVal diastolic:(NSInteger) dVal andDate:(NSDate*) date;
-(id) initWithSystolic:(NSInteger) sVal diastolic:(NSInteger) dVal pulse:(NSInteger) pVal;
+(HVItem *) newItem;


//-------------------------
//
// Text
//
//-------------------------
//
// Generates string for systolic OVER diastolic
//
-(NSString *) toString;
//
// Takes a format string with %@ in it, surrounded with other decorative text of your choice
//
-(NSString *) toStringWithFormat:(NSString *) format;

//-------------------------
//
// Type information
//
//-------------------------
+(NSString *) typeID;
+(NSString *) XRootElement;

@end
