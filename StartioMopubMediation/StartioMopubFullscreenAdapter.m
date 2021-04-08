//
//  StartioInterstitialAdapter.m
//  StartioMopubMediation
//
//  Created by tto on 30.03.2021.
//

#import "StartioMopubFullscreenAdapter.h"
#import "StartioMopubAdapterConfiguration.h"
#import "StartioMopubExtras.h"



@implementation StartioMopubFullscreenAdapter

#pragma mark - MoPub stuff

- (void)requestAdWithAdapterInfo:(NSDictionary*)info adMarkup:(nullable NSString*)adMarkup {
    MPLogAdEvent([MPLogEvent adLoadAttemptForAdapter:NSStringFromClass(self.class) dspCreativeId:nil dspName:nil], kStartioNetworkId);
    
    StartioMopubExtras* extras = [[StartioMopubExtras alloc] initWithLocalParams:self.localExtras remoteParams:info];
    [StartioMopubAdapterConfiguration initializeSdkIfNeeded:extras.appId];
    
    self.startioAd = [[STAStartAppAd alloc] init];
    [self loadTargedAd:extras];
}

- (void)presentAdFromViewController:(UIViewController*)viewController {
    MPLogAdEvent([MPLogEvent adShowAttemptForAdapter:NSStringFromClass(self.class)], kStartioNetworkId);
    
    [self.startioAd showAd];
}

- (BOOL)isRewardExpected {
    return NO;
}

- (BOOL)hasAdAvailable {
    return [self.startioAd isReady];
}

- (BOOL)enableAutomaticImpressionAndClickTracking {
    return NO;
}

#pragma mark - Overriden in a subclass

- (void)loadTargedAd:(StartioMopubExtras*)extras {
    if (extras.isVideo) {
        [self.startioAd loadVideoAdWithDelegate:self withAdPreferences:extras.prefs];
    } else {
        [self.startioAd loadAdWithDelegate:self withAdPreferences:extras.prefs];
    }
}

#pragma mark - STADelegateProtocol

- (void)didLoadAd:(STAAbstractAd*)ad {
    [self.delegate fullscreenAdAdapterDidLoadAd:self];
    
    MPLogAdEvent([MPLogEvent adLoadSuccessForAdapter:NSStringFromClass(self.class)], kStartioNetworkId);
}

- (void)failedLoadAd:(STAAbstractAd*)ad withError:(NSError*)error {
    [self.delegate fullscreenAdAdapter:self didFailToLoadAdWithError:error];
    
    MPLogAdEvent([MPLogEvent adLoadFailedForAdapter:NSStringFromClass(self.class) error:error], kStartioNetworkId);
}

- (void)didShowAd:(STAAbstractAd*)ad {
    [self.delegate fullscreenAdAdapterAdDidAppear:self];
    [self.delegate fullscreenAdAdapterDidTrackImpression:self];
    
    MPLogAdEvent([MPLogEvent adShowSuccessForAdapter:NSStringFromClass(self.class)], kStartioNetworkId);
    MPLogAdEvent([MPLogEvent adDidAppearForAdapter:NSStringFromClass(self.class)], kStartioNetworkId);
}

- (void)failedShowAd:(STAAbstractAd*)ad withError:(NSError*)error {
    [self.delegate fullscreenAdAdapter:self didFailToShowAdWithError:error];
    
    MPLogAdEvent([MPLogEvent adShowFailedForAdapter:NSStringFromClass(self.class) error:error], kStartioNetworkId);
}

- (void)didCloseAd:(STAAbstractAd*)ad {
    [self.delegate fullscreenAdAdapterAdDidDisappear:self];
    [self.delegate fullscreenAdAdapterAdDidDismiss:self];
    
    MPLogAdEvent([MPLogEvent adDidDisappearForAdapter:NSStringFromClass(self.class)], kStartioNetworkId);
}

- (void)didClickAd:(STAAbstractAd*)ad {
    [self.delegate fullscreenAdAdapterDidReceiveTap:self];
    [self.delegate fullscreenAdAdapterDidTrackClick:self];
    
    MPLogAdEvent([MPLogEvent adTappedForAdapter:NSStringFromClass(self.class)], kStartioNetworkId);
}

- (void)didCompleteVideo:(STAAbstractAd*)ad {
    [self.delegate fullscreenAdAdapter:self willRewardUser:[[MPReward alloc] init]];
}

@end

