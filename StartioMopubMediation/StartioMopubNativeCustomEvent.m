//
//  StartioMopubNativeCustomEvent.m
//  StartioMopubMediation
//
//  Created by tto on 06.04.2021.
//

#import "StartioMopubNativeCustomEvent.h"
#import "StartioMopubAdapterConfiguration.h"
#import "StartioMopubNativeAdapter.h"
#import "StartioMopubExtras.h"

#import <StartApp/StartApp.h>


@interface StartioMopubNativeCustomEvent () <STADelegateProtocol>

@property (nonatomic, nullable) StartioMopubNativeAdapter* adapter;

@end


@implementation StartioMopubNativeCustomEvent

- (void)requestAdWithCustomEventInfo:(NSDictionary*)info adMarkup:(NSString*)adMarkup {
    StartioMopubExtras* extras = [[StartioMopubExtras alloc] initWithLocalParams:self.localExtras remoteParams:info];
    [StartioMopubAdapterConfiguration initializeSdkIfNeeded:extras.appId];
    
    self.adapter = [[StartioMopubNativeAdapter alloc] initWithCustomEvent:self];
    [self.adapter loadAdWithPreferences:extras.prefs];
    
    MPLogAdEvent([MPLogEvent adLoadAttemptForAdapter:NSStringFromClass(self.class) dspCreativeId:nil dspName:nil], kStartioNetworkId);
}

- (void)sendInvalidImageUrlError {
    NSError* error = MPNativeAdNSErrorForInvalidImageURL();
    [self.delegate nativeCustomEvent:self didFailToLoadAdWithError:error];
    MPLogAdEvent([MPLogEvent adLoadFailedForAdapter:NSStringFromClass(self.class) error:error], kStartioNetworkId);
}

#pragma mark - STADelegateProtocol

- (void)didLoadAd:(STAAbstractAd*)ad {
    STANativeAdDetails* startioAd = self.adapter.adDetails;
    NSMutableArray* imageURLs = [NSMutableArray array];
    
    if (startioAd.imageUrl.length) {
        if (![MPNativeAdUtils addURLString:startioAd.imageUrl toURLArray:imageURLs]) {
            [self sendInvalidImageUrlError];
        }
    }
    
    if (startioAd.secondaryImageUrl.length) {
        if (![MPNativeAdUtils addURLString:startioAd.secondaryImageUrl toURLArray:imageURLs]) {
            [self sendInvalidImageUrlError];
        }
    }
    
    if (startioAd.policyImageUrl.length) {
        if (![MPNativeAdUtils addURLString:startioAd.policyImageUrl toURLArray:imageURLs]) {
            [self sendInvalidImageUrlError];
        }
    }
    
    [super precacheImagesWithURLs:imageURLs completionBlock:^(NSArray* errors) {
        if (errors.count > 0) {
            [self.delegate nativeCustomEvent:self didFailToLoadAdWithError:errors.lastObject];
            MPLogAdEvent([MPLogEvent adLoadFailedForAdapter:NSStringFromClass(self.class)
                                                      error:errors.lastObject], kStartioNetworkId);
        } else {
            MPNativeAd* mopubAd = [[MPNativeAd alloc] initWithAdAdapter:self.adapter];
            [self.delegate nativeCustomEvent:self didLoadAd:mopubAd];
            
            MPLogAdEvent([MPLogEvent adLoadSuccessForAdapter:NSStringFromClass(self.class)], kStartioNetworkId);
        }
    }];
}

- (void)failedLoadAd:(STAAbstractAd*)ad withError:(NSError*)error {
    [self.delegate nativeCustomEvent:self didFailToLoadAdWithError:error];
    
    MPLogAdEvent([MPLogEvent adLoadFailedForAdapter:NSStringFromClass(self.class) error:error], kStartioNetworkId);
}

@end
