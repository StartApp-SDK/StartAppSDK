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

#import "StartioMopubNativeAdapter.h"
#import "StartioMopubAdapterConfiguration.h"

#import <StartApp/StartApp.h>


@interface StartioMopubNativeAdapter () <STADelegateProtocol>

@property (nonatomic, weak) id<STADelegateProtocol> customEventDelegate;
@property (nonatomic) STAStartAppNativeAd* startioAd;
@property (nonatomic, nullable) NSDictionary* props;

@end


@implementation StartioMopubNativeAdapter

- (instancetype)initWithCustomEvent:(id<STADelegateProtocol>)eventDelegate {
    if (self = [super init]) {
        _startioAd = [[STAStartAppNativeAd alloc] init];
        _customEventDelegate = eventDelegate;
    }
    
    return self;
}

- (void)loadAdWithPreferences:(STANativeAdPreferences*)prefs {
    [self.startioAd loadAdWithDelegate:self withNativeAdPreferences:prefs];
}

- (NSDictionary*)properties {
    return self.props;
}

- (NSURL*)defaultActionURL {
    return nil;
}

- (BOOL)enableThirdPartyClickTracking {
    return YES;
}

- (void)willAttachToView:(UIView*)view withAdContentViews:(NSArray*)adContentViews {
    NSUInteger interactionEnabledSize = 0;
    for (UIView* childView in adContentViews) {
        if (!childView.isUserInteractionEnabled) {
            break;
        }
        
        ++interactionEnabledSize;
    }
    
    if (interactionEnabledSize == adContentViews.count) {
        [self.adDetails registerViewForImpression:view andViewsForClick:adContentViews];
    } else {
        [self.adDetails registerViewForImpressionAndClick:view];
    }
}

- (STANativeAdDetails*)adDetails {
    return self.startioAd.adsDetails.firstObject;
}

#pragma mark - STADelegateProtocol

- (void)didLoadAd:(STAAbstractAd*)ad {
    if (self.startioAd != ad || self.startioAd.adsDetails.count <= 0) {
        NSError* error = [NSError errorWithCode:MOPUBErrorAdapterFailedToLoadAd localizedDescription:@"no fill"];
        MPLogAdEvent([MPLogEvent adLoadFailedForAdapter:NSStringFromClass(self.class) error:error], kStartioNetworkId);
        return;
    }
    
    STANativeAdDetails* adDetails = self.adDetails;
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    
    if (adDetails.title.length) {
        dict[kAdTitleKey] = adDetails.title;
    }
    
    if (adDetails.description.length) {
        dict[kAdTextKey] = adDetails.description;
    }
    
    if (adDetails.imageUrl.length) {
        dict[kAdMainImageKey] = adDetails.imageUrl;
    }
    
    if (adDetails.secondaryImageUrl.length) {
        dict[kAdIconImageKey] = adDetails.secondaryImageUrl;
    }
    
    if (adDetails.policyImageUrl.length) {
        dict[kAdPrivacyIconImageUrlKey] = adDetails.policyImageUrl;
    }
    
    if (adDetails.callToAction.length) {
        dict[kAdCTATextKey] = adDetails.callToAction;
    }
    
    if (adDetails.rating) {
        dict[kAdStarRatingKey] = adDetails.rating;
    }
    
    if (adDetails.mediaView) {
        dict[kAdMainMediaViewKey] = adDetails.mediaView;
    }
    
    self.props = [dict copy];
    
    if ([self.customEventDelegate respondsToSelector:@selector(didLoadAd:)]) {
        [self.customEventDelegate didLoadAd:ad];
    }
}

- (void)failedLoadAd:(STAAbstractAd*)ad withError:(NSError*)error {
    if ([self.customEventDelegate respondsToSelector:@selector(failedLoadAd:withError:)]) {
        [self.customEventDelegate failedLoadAd:ad withError:error];
    }
}

- (void)didShowNativeAdDetails:(STANativeAdDetails*)nativeAdDetails {
    [self.delegate nativeAdWillLogImpression:self];
    
    MPLogAdEvent([MPLogEvent adShowSuccessForAdapter:NSStringFromClass(self.class)], kStartioNetworkId);
    MPLogAdEvent([MPLogEvent adDidAppearForAdapter:NSStringFromClass(self.class)], kStartioNetworkId);
}

- (void)didClickNativeAdDetails:(STANativeAdDetails*)nativeAdDetails {
    [self.delegate nativeAdDidClick:self];
    
    MPLogAdEvent([MPLogEvent adTappedForAdapter:NSStringFromClass(self.class)], kStartioNetworkId);
}

@end
