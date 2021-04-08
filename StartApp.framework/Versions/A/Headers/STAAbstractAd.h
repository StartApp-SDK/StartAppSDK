//
//  STAAbstractAd.h
//  StartAppAdSDK
//
//  Copyright (c) 2013 StartApp. All rights reserved.
//  SDK version 4.6.3

#import <Foundation/Foundation.h>

@class STAAbstractAd;
@class STANativeAdDetails;

@protocol STADelegateProtocol <NSObject>

@optional
- (void)didLoadAd:(STAAbstractAd *)ad;
- (void)failedLoadAd:(STAAbstractAd *)ad withError:(NSError *)error;
- (void)didShowAd:(STAAbstractAd *)ad;
- (void)failedShowAd:(STAAbstractAd *)ad withError:(NSError *)error;
- (void)didCloseAd:(STAAbstractAd *)ad;
- (void)didClickAd:(STAAbstractAd *)ad;
- (void)didCloseInAppStore:(STAAbstractAd *)ad;
- (void)didCompleteVideo:(STAAbstractAd *)ad;

- (void)didShowNativeAdDetails:(STANativeAdDetails *)nativeAdDetails;
- (void)didClickNativeAdDetails:(STANativeAdDetails *)nativeAdDetails;

@end

@interface STAAbstractAd : NSObject

- (BOOL) isReady;

@end
