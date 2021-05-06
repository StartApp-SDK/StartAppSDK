# ios-mopub-mediation
## Enables you to serve Start.io (formerly StartApp) Ads in your iOS application using MoPub mediation network

### 1. Getting Started

The following instructions assume you are already familiar with the MoPub mediation network and have already integrated the MoPub iOS SDK into your application. Otherwise, please start by visiting MoPub site and reading the instructions on how to add MoPub mediation code into your app.
  * [MoPub site](https://developers.mopub.com/publishers/mediation/mopub-network-mediation/mopub.com/resources/supported-mediation-partners)
  * [MoPub instructions](https://developers.mopub.com/docs/ios)
  
### 2. Adding Your Application to Your Start.io Developer's Account
1. Login into your [Start.io developer's account](https://portal.start.io/#/signin)
1. Add your application and get its App ID

### 3. Integrating the Start.io <-> MoPub Mediation Adapter
The easiest way is to use CocoaPods, just add to your Podfile the dependency
```
pod 'startio-mopub-mediation', '~> 1.0'
```
But you might as well use [this source code](https://github.com/StartApp-SDK/ios-mopub-mediation) from Github and add it to your project

### 4. Adding a Custom Event
1. Login into your [MoPub account](https://app.mopub.com/login?next=/dashboard/)
1. On the top menu select "Orders"
1. Create new one pressing "Create Order" unless you already have prepared one
1. Select your order from the list
1. Press "New line item" button
1. Name it as you prefear and in "Type & priority" select "Network line item"
1. In the field "Network" select "Custom SDK network"
1. Fill in the appeared fields "Custom event class" and "Custom event data" regarding to your ad type:

Ad Type | Custom event class | Custom event data | Options
------- | ------------------ | ----------------- | -------
Interstitial | StartioMopubFullscreenAdapter | {"startioAppId":"your_id_from_portal", "adTag":"any_your_tag", "interstitialMode":"OVERLAY", "minCPM":0.02} | interstitialMode can be OVERLAY or VIDEO
Banner/Medium Rectangle | StartioMopubInlineAdapter | {"startioAppId":"your_id_from_portal", "adTag":"any_your_tag", "minCPM":0.02} | 
Rewarded | StartioMopubRewardedAdapter | {"startioAppId":"your_id_from_portal", "adTag":"any_your_tag", "minCPM":0.02} |
Native | StartioMopubNativeCustomEvent | {"startioAppId":"your_id_from_portal", "adTag":"any_your_tag", "minCPM":0.02, "nativeImageSize":"SIZE150X150", "nativeSecondaryImageSize":"SIZE100X100"} | nativeImageSize and nativeSecondaryImageSize can be any of SIZE72X72, SIZE100X100, SIZE150X150, SIZE340X340, SIZE1200X628(for main image only) and don't forget to add StartioMopubNativeCustomEvent string to your renderer settings in the field ".supportedCustomEvents" | 

All parameters in the "custom event data" field are optional except the "startioAppId" which you must provide in any case.
You can also pass these parameters from your code using mopub's "localExtras" field. But be aware that every parameter from "custom event data" will override same parameter which is set locally

Example:
```
self.interstitial.localExtras = @{
    @"adTag": @"myCustomTag",
    @"minCPM": @0.01,
};
    
[self.interstitial loadAd];
```

#### If you need additional assistance you can take a look on our app example which works with this mediation adapter [here](https://github.com/StartApp-SDK/ios-mopub-mediation-sample)
