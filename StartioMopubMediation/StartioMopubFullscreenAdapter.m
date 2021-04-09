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

#import "StartioMopubFullscreenAdapter.h"
#import "StartioMopubAdapterConfiguration.h"
#import "StartioMopubExtras.h"

#import <StartApp/StartApp.h>


@interface StartioMopubFullscreenAdapter () <STADelegateProtocol>

@end


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

