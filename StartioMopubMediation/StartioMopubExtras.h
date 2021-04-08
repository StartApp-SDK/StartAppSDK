//
//  StartioExtras.h
//  StartioMopubMediation
//
//  Created by tto on 31.03.2021.
//

@import Foundation;

NS_ASSUME_NONNULL_BEGIN

@class STANativeAdPreferences;

@interface StartioMopubExtras : NSObject

- (instancetype)initWithLocalParams:(nullable NSDictionary*)local remoteParams:(nullable NSDictionary*)server;

@property (nonatomic, copy, nullable) NSString* appId;
@property (nonatomic, getter=isVideo) BOOL video;
@property (nonatomic, copy) STANativeAdPreferences* prefs;

@end

NS_ASSUME_NONNULL_END
