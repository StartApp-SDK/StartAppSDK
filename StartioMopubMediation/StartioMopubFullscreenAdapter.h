//
//  StartioInterstitialAdapter.h
//  StartioMopubMediation
//
//  Created by tto on 30.03.2021.
//

@import Foundation;
@import MoPubSDK;

#import <StartApp/StartApp.h>


NS_ASSUME_NONNULL_BEGIN

@interface StartioMopubFullscreenAdapter : MPFullscreenAdAdapter <MPThirdPartyFullscreenAdAdapter, STADelegateProtocol>

@property (nonatomic, nullable) STAStartAppAd* startioAd;

@end

NS_ASSUME_NONNULL_END
