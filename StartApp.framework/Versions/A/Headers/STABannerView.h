//
//  StartAppBannerView.h
//  StartAppAdSDK
//
//  Created by StartApp on 11/13/13.
//  Copyright (c) 2013 StartApp. All rights reserved.
//  SDK version 3.11.0

#import <UIKit/UIKit.h>
#import "STABannerSize.h"
#import "STAAdPreferences.h"

@class STABannerView;   // Forward decleration
@protocol STABannerDelegateProtocol <NSObject>
@optional
- (void) bannerAdIsReadyToDisplay:(STABannerView*)banner;
- (void) didDisplayBannerAd:(STABannerView*)banner;
- (void) failedLoadBannerAd:(STABannerView*)banner withError:(NSError *)error;
- (void) didClickBannerAd:(STABannerView*)banner;
- (void) didCloseBannerInAppStore:(STABannerView*)banner;

@end

typedef enum {
	STAAdOrigin_Top = 1,
    STAAdOrigin_Bottom = 2,
} STAAdOrigin;

@interface STABannerView : UIView <UIWebViewDelegate>

- (id)initWithSize:(STABannerSize)size origin:(CGPoint)origin withDelegate:(id<STABannerDelegateProtocol>)bannerDelegate;
- (id)initWithSize:(STABannerSize)size origin:(CGPoint)origin adPreferences:(STAAdPreferences *)adPreferences withDelegate:(id<STABannerDelegateProtocol>)bannerDelegate;
- (id)initWithSize:(STABannerSize)size autoOrigin:(STAAdOrigin)origin withDelegate:(id<STABannerDelegateProtocol>)bannerDelegate;
- (id)initWithSize:(STABannerSize)size autoOrigin:(STAAdOrigin)origin adPreferences:(STAAdPreferences *)adPreferences withDelegate:(id<STABannerDelegateProtocol>)bannerDelegate;

- (id)initWithSize:(STABannerSize)size origin:(CGPoint)origin withDelegate:(id<STABannerDelegateProtocol>)bannerDelegate withAdTag:(NSString*)adTag;
- (id)initWithSize:(STABannerSize)size origin:(CGPoint)origin adPreferences:(STAAdPreferences *)adPreferences withDelegate:(id<STABannerDelegateProtocol>)bannerDelegate withAdTag:(NSString*)adTag;
- (id)initWithSize:(STABannerSize)size autoOrigin:(STAAdOrigin)origin withDelegate:(id<STABannerDelegateProtocol>)bannerDelegate withAdTag:(NSString*)adTag;
- (id)initWithSize:(STABannerSize)size autoOrigin:(STAAdOrigin)origin adPreferences:(STAAdPreferences *)adPreferences withDelegate:(id<STABannerDelegateProtocol>)bannerDelegate withAdTag:(NSString*)adTag;


- (void)loadAd;

- (void)setSTABannerAdTag:(NSString *) adTag;

- (void)setSTABannerSize:(STABannerSize) size;
- (void)setOrigin:(CGPoint) origin;
- (void)setSTAAutoOrigin:(STAAdOrigin)origin;

- (void)setAdPreferneces:(STAAdPreferences *)adPreferences;

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation;
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator;

- (void)hideBanner;
- (void)showBanner;
- (BOOL)isVisible;

-(void)addSTABannerToCell:(UITableViewCell *)cell withIndexPath:(NSIndexPath *)indexPath atIntexPathSection:(int)section repeatEach:(int)each;
-(void)addSTABannerToCell:(UITableViewCell *)cell withIndexPath:(NSIndexPath *)indexPath atIntexPathSection:(int)section;

-(void)addSTABannerToCell:(UITableViewCell *)cell withIndexPath:(NSIndexPath *)indexPath atIntexPathRow:(int)row repeatEach:(int)each;
-(void)addSTABannerToCell:(UITableViewCell *)cell withIndexPath:(NSIndexPath *)indexPath atIntexPathRow:(int)row;

- (id) initWithSize:(STABannerSize) size origin:(CGPoint) origin withView: (UIView*) view withDelegate:(id <STABannerDelegateProtocol> ) bannerDelegate __deprecated_msg("withView param is deprecated. STABannerView's superview will be used instead");
- (id) initWithSize:(STABannerSize) size origin:(CGPoint) origin adPreferences: (STAAdPreferences *)adPreferences withView: (UIView*) view withDelegate:(id <STABannerDelegateProtocol> ) bannerDelegate __deprecated_msg("withView param is deprecated. STABannerView's superview will be used instead");
- (id) initWithSize:(STABannerSize) size autoOrigin:(STAAdOrigin) origin withView: (UIView*) view withDelegate:(id <STABannerDelegateProtocol> ) bannerDelegate __deprecated_msg("withView param is deprecated. STABannerView's superview will be used instead");
- (id) initWithSize:(STABannerSize) size autoOrigin:(STAAdOrigin) origin adPreferences: (STAAdPreferences *)adPreferences withView: (UIView*) view withDelegate:(id <STABannerDelegateProtocol> ) bannerDelegate __deprecated_msg("withView param is deprecated. STABannerView's superview will be used instead");

- (id) initWithSize:(STABannerSize) size origin:(CGPoint) origin withView: (UIView*) view withDelegate:(id <STABannerDelegateProtocol> ) bannerDelegate withAdTag:(NSString*)adTag __deprecated_msg("withView param is deprecated. STABannerView's superview will be used instead");
- (id) initWithSize:(STABannerSize) size origin:(CGPoint) origin adPreferences: (STAAdPreferences *)adPreferences withView: (UIView*) view withDelegate:(id <STABannerDelegateProtocol> ) bannerDelegate withAdTag:(NSString*)adTag __deprecated_msg("withView param is deprecated. STABannerView's superview will be used instead");
- (id) initWithSize:(STABannerSize) size autoOrigin:(STAAdOrigin) origin withView: (UIView*) view withDelegate:(id <STABannerDelegateProtocol> ) bannerDelegate withAdTag:(NSString*)adTag __deprecated_msg("withView param is deprecated. STABannerView's superview will be used instead");
- (id) initWithSize:(STABannerSize) size autoOrigin:(STAAdOrigin) origin adPreferences: (STAAdPreferences *)adPreferences withView: (UIView*) view withDelegate:(id <STABannerDelegateProtocol> ) bannerDelegate withAdTag:(NSString*)adTag __deprecated_msg("withView param is deprecated. STABannerView's superview will be used instead");


@end
