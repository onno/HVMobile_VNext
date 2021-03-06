//
//  HVMethodCall.h
//  HVLib
//
//  Copyright (c) 2012 Microsoft Corporation. All rights reserved.
//
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
#import "HVAsyncTask.h"
#import "XLib.h"
#import "HVServerResponseStatus.h"
#import "HealthVaultRequest.h"
#import "HealthVaultResponse.h"
#import "HVType.h"

@class HVRecordReference;

@interface HVMethodCallTask : HVTask
{
    HVServerResponseStatus* m_status;
    HVRecordReference* m_record;
    
    NSInteger m_attempt;
    BOOL m_useMasterAppID;
}

@property (readonly, nonatomic) NSString* name;
@property (readonly, nonatomic) float version;
@property (readwrite, nonatomic, retain) HVServerResponseStatus* status;
@property (readwrite, nonatomic, retain) HVRecordReference* record;
@property (readwrite, nonatomic) BOOL useMasterAppID;

-(id) initWithCallback:(HVTaskCompletion) callback;

-(void) validateObject:(id) obj;

-(void) prepare;
-(void) serializeRequestBodyToWriter:(XWriter *) writer;
-(id) deserializeResponseBodyFromReader:(XReader *) reader;
-(id) deserializeResponseBodyFromReader:(XReader *)reader asClass:(Class) cls;

-(void) ensureRecord;

@end
