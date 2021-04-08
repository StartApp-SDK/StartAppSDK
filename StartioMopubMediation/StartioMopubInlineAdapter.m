//
//  StartioInlineAdapter.m
//  StartioMopubMediation
//
//  Created by tto on 01.04.2021.
//

#import "StartioMopubInlineAdapter.h"
#import "StartioMopubAdapterConfiguration.h"
#import "StartioMopubExtras.h"

#import <StartApp/StartApp.h>

@interface StartioMopubInlineAdapter () <STABannerDelegateProtocol>

@property (nonatomic, nullable) UIView* inlineAdView;
@property (nonatomic, nullable) UIView* fakeView;

@end


@implementation StartioMopubInlineAdapter

- (void)requestAdWithSize:(CGSize)size adapterInfo:(NSDictionary*)info adMarkup:(nullable NSString*)adMarkup {
    StartioMopubExtras* extras = [[StartioMopubExtras alloc] initWithLocalParams:self.localExtras remoteParams:info];
    [StartioMopubAdapterConfiguration initializeSdkIfNeeded:extras.appId];
    
    const NSInteger width = trunc(size.width);
    const NSInteger height = trunc(size.height);
    
    STABannerSize bannerSize = STA_AutoAdSize;
    if (height == 250) {
        bannerSize = STA_MRecAdSize_300x250;
    } else if (height == 628 || height == 627) {
        bannerSize = STA_CoverAdSize;
    } else if (UIDevice.currentDevice.userInterfaceIdiom == UIUserInterfaceIdiomPhone && width >= 320) {
        bannerSize = width < 480
            ? STA_PortraitAdSize_320x50
            : (width < 586
               ? STA_LandscapeAdSize_480x50
               : STA_LandscapeAdSize_568x50);
    } else if (UIDevice.currentDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad && width >= 768) {
        bannerSize = width < 1024 ? STA_PortraitAdSize_768x90 : STA_LandscapeAdSize_1024x90;
    }
    
    self.inlineAdView = [[STABannerView alloc] initWithSize:bannerSize
                                                 autoOrigin:STAAdOrigin_Bottom
                                              adPreferences:extras.prefs
                                               withDelegate:self];
    
    // fakeView is used to activate loading process
    self.fakeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    [self.fakeView addSubview:self.inlineAdView];
    
    MPLogAdEvent([MPLogEvent adLoadAttemptForAdapter:NSStringFromClass(self.class) dspCreativeId:nil dspName:nil], kStartioNetworkId);
}

- (BOOL)enableAutomaticImpressionAndClickTracking {
    return NO;
}

#pragma mark - STABannerDelegateProtocol

- (void)bannerAdIsReadyToDisplay:(STABannerView*)banner {
    MPLogAdEvent([MPLogEvent adWillAppearForAdapter:NSStringFromClass(self.class)], kStartioNetworkId);
}

- (void)didDisplayBannerAd:(STABannerView*)banner {
    [self.delegate inlineAdAdapter:self didLoadAdWithAdView:self.inlineAdView];
    [self.delegate inlineAdAdapterDidTrackImpression:self];
    
    MPLogAdEvent([MPLogEvent adShowSuccessForAdapter:NSStringFromClass(self.class)], kStartioNetworkId);
    MPLogAdEvent([MPLogEvent adDidAppearForAdapter:NSStringFromClass(self.class)], kStartioNetworkId);
}

- (void)failedLoadBannerAd:(STABannerView*)banner withError:(NSError*)error {
    [self.delegate inlineAdAdapter:self didFailToLoadAdWithError:error];
    
    MPLogAdEvent([MPLogEvent adLoadFailedForAdapter:NSStringFromClass(self.class) error:error], kStartioNetworkId);
}

- (void)didClickBannerAd:(STABannerView*)banner {
    [self.delegate inlineAdAdapterDidTrackClick:self];
    
    MPLogAdEvent([MPLogEvent adTappedForAdapter:NSStringFromClass(self.class)], kStartioNetworkId);
}

@end
