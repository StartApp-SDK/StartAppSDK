/**
 * Copyright 2021 Start.io Inc
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#import "StartioMopubAdapterConfiguration.h"
#import <StartApp/StartApp.h>

NSString* const kStartioNetworkId = @"Startio";

@interface StartioMopubAdapterConfiguration ()

@property (nonatomic, copy, readonly) NSString* adapterVersion;
@property (nonatomic, copy, readonly, nullable) NSString* biddingToken;
@property (nonatomic, copy, readonly) NSString* moPubNetworkName;
@property (nonatomic, copy, readonly) NSString* networkSdkVersion;

@end

@implementation StartioMopubAdapterConfiguration

+ (void)initializeSdkIfNeeded:(NSString*)appId {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        STAStartAppSDK* sdk = STAStartAppSDK.sharedInstance;
        sdk.appID = appId;
        sdk.returnAdEnabled = NO;
        sdk.consentDialogEnabled = NO;
        [sdk addWrapperWithName:@"MoPub" version:sdk.version];

    #ifdef DEBUG
        sdk.testAdsEnabled = YES;
    #endif
    });
}

- (NSString*)adapterVersion {
    return [STAStartAppSDK.sharedInstance.version stringByAppendingString:@".0"];
}

- (nullable NSString*)biddingToken {
    return nil;
}

- (NSString*)moPubNetworkName {
    return kStartioNetworkId;
}

- (NSString*)networkSdkVersion {
    return STAStartAppSDK.sharedInstance.version;
}

- (void)initializeNetworkWithConfiguration:(NSDictionary<NSString*, id>* _Nullable)configuration
                                  complete:(void(^ _Nullable)(NSError* _Nullable))complete
{
    complete(nil);
}

@end
