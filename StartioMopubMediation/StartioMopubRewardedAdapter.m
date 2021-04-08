//
//  StartioMopubRewardedAdapter.m
//  StartioMopubMediation
//
//  Created by tto on 04.04.2021.
//

#import "StartioMopubRewardedAdapter.h"
#import "StartioMopubExtras.h"


@implementation StartioMopubRewardedAdapter

- (BOOL)isRewardExpected {
    return YES;
}

- (void)loadTargedAd:(StartioMopubExtras*)extras {
    [self.startioAd loadRewardedVideoAdWithDelegate:self withAdPreferences:extras.prefs];
}

@end
