//
//  StartioMopubNativeAdapter.h
//  StartioMopubMediation
//
//  Created by tto on 04.04.2021.
//

@import Foundation;
@import MoPubSDK;

#import <StartApp/StartApp.h>

NS_ASSUME_NONNULL_BEGIN

@interface StartioMopubNativeAdapter : NSObject <MPNativeAdAdapter, STADelegateProtocol>

- (instancetype)initWithCustomEvent:(id<STADelegateProtocol>)eventDelegate;

- (void)loadAdWithPreferences:(STANativeAdPreferences*)prefs;


@property (nonatomic, weak) id<MPNativeAdAdapterDelegate> delegate;
@property (nonatomic, readonly, nullable) STANativeAdDetails* adDetails;

@end

NS_ASSUME_NONNULL_END
