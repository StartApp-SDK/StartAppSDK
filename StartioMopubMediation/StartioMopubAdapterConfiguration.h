//
//  StartioAdapterConfiguration.h
//  StartioMopubMediation
//
//  Created by tto on 30.03.2021.
//

@import Foundation;
@import MoPubSDK;

NS_ASSUME_NONNULL_BEGIN

extern NSString* const kStartioNetworkId;

@interface StartioMopubAdapterConfiguration : MPBaseAdapterConfiguration

+ (void)initializeSdkIfNeeded:(NSString*)appId;

@end

NS_ASSUME_NONNULL_END
