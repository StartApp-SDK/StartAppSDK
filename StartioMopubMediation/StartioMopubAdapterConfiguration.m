//
//  StartioAdapterConfiguration.m
//  StartioMopubMediation
//
//  Created by tto on 30.03.2021.
//

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
    return @"1.0.0.0";
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
