//
//  MobilePlatform.m
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


#import "MobilePlatform.h"
#import <CommonCrypto/CommonHMAC.h>
#import "Base64.h"


@implementation MobilePlatform


+ (NSString *)platformAbbreviationAndVersion {

	return @"HV-iOS/2.2";
}

+ (NSString *)deviceName {

	return @"iOS Device";
}

+ (NSString *)computeSha256Hash: (NSString *)data {

	const char *chars = [data cStringUsingEncoding: NSUTF8StringEncoding];
	NSData *keyData = [NSData dataWithBytes: chars length: strlen(chars)];

	uint8_t digest[CC_SHA256_DIGEST_LENGTH] = {0};
	CC_SHA256(keyData.bytes, (CC_LONG)keyData.length, digest);

	NSString *base64String = [Base64 encodeBase64WithData: [NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH]];

	return base64String;
}

+ (NSString *)computeSha256Hmac: (NSData *)key data:(NSString *)data {

	NSUInteger len = [key length];
	char *cKey = (char *)[key bytes];

	const char *cData = [data cStringUsingEncoding: NSUTF8StringEncoding];

	unsigned char cHMAC[CC_SHA256_DIGEST_LENGTH];

	CCHmac(kCCHmacAlgSHA256, cKey, len, cData, strlen(cData), cHMAC);

	NSData *hmac = [[NSData alloc] initWithBytes: cHMAC length: sizeof(cHMAC)];

	NSString *base64String = [Base64 encodeBase64WithData: hmac];

	[hmac release];
	return base64String;
}

@end
