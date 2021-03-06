//
//  HVStoredQuery.h
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
//

#import <Foundation/Foundation.h>
#import "XLib.h"
#import "HVTypes.h"

@interface HVStoredQuery : XSerializableType
{
@private
    HVItemQuery* m_query;
    HVItemQueryResult* m_result;
    NSDate* m_timestamp;
}

@property (readwrite, nonatomic, retain) HVItemQuery* query;
@property (readwrite, nonatomic, retain) HVItemQueryResult* result;
@property (readwrite, nonatomic, retain) NSDate* timestamp;

-(id) initWithQuery:(HVItemQuery *) query;
-(id) initWithQuery:(HVItemQuery *) query andResult:(HVItemQueryResult *) result;

//
// maxAgeInSeconds
//
-(BOOL) isStale:(NSTimeInterval) maxAge;

-(HVTask *) synchronizeForRecord:(HVRecordReference *) record withCallback:(HVTaskCompletion) callback;

@end
