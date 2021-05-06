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

#import "StartioMopubExtras.h"
#import <StartApp/StartApp.h>

static NSString* const kAppId = @"startioAppId";
static NSString* const kInterstitialMode = @"interstitialMode";
static NSString* const kAdTag = @"adTag";
static NSString* const kMinCPM = @"minCPM";
static NSString* const kMuteVideo = @"muteVideo";
static NSString* const kNativeImageSize = @"nativeImageSize";
static NSString* const kNativeSecondaryImageSize = @"nativeSecondaryImageSize";

static STANativeAdBitmapSize stringToBitmapSize(NSString* format) {
    if ([format isEqualToString:@"SIZE72X72"]) {
        return SIZE_72X72;
    } else if ([format isEqualToString:@"SIZE100X100"]) {
        return SIZE_100X100;
    } else if ([format isEqualToString:@"SIZE150X150"]) {
        return SIZE_150X150;
    } else if ([format isEqualToString:@"SIZE340X340"]) {
        return SIZE_340X340;
    } else if ([format isEqualToString:@"SIZE1200X628"]) {
        return SIZE_1200X628;
    }
    
    return SIZE_150X150;
}


@implementation StartioMopubExtras

- (instancetype)initWithLocalParams:(nullable NSDictionary*)local remoteParams:(nullable NSDictionary*)server {
    if (self = [super init]) {
        _prefs = [[STANativeAdPreferences alloc] init];
        self.prefs.adsNumber = 1;
        self.prefs.autoBitmapDownload = NO;
        
        [self fillExtras:local];
        [self fillExtras:server];
    }
    
    return self;
}

- (void)fillExtras:(nullable NSDictionary*)params {
    if (params == nil) {
        return;
    }
    
    if (params[kAppId]) {
        self.appId = params[kAppId];
    }
    
    if (params[kInterstitialMode]) {
        self.video = [params[kInterstitialMode] isEqualToString:@"VIDEO"];
    }
    
    if (params[kAdTag]) {
        self.prefs.adTag = params[kAdTag];
    }
    
    if (params[kMinCPM]) {
        self.prefs.minCPM = [params[kMinCPM] doubleValue];
    }
    
    if (params[kMuteVideo]) {
        // TODO: needs to implement in the sdk STAAdPreferences
        // self.prefs.muteVideo = [local[kMuteVideo] boolValue];
    }
    
    if (params[kNativeImageSize]) {
        self.prefs.primaryImageSize = stringToBitmapSize(params[kNativeImageSize]);
    }
    
    if (params[kNativeSecondaryImageSize]) {
        self.prefs.secondaryImageSize = stringToBitmapSize(params[kNativeSecondaryImageSize]);
    }
}

@end
