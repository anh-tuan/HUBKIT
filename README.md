HUBKit is an iOS SDK that encapsulates the data layer and web services used to interact with the HUB API.

This codebase is written in a Functional Reactive Programming (FRP) style, and as such, you interact with the library by composing sequences of values. Nearly all public methods will return an `RACSignal`. Refer to  [Reactive Cocoa](https://github.com/ReactiveCocoa/ReactiveCocoa) for more information.

This library is a work in progress, and breaking changes may be introduced at any time until a stable release. The releases page contains each point release (tagged).

##Installation
Using [Cocoapods](http://cocoapods.org/) to install HUBKit is easy. Just add this line to your `Podfile`

```
pod 'HUBKit', :git => 'git@github.com:anh-tuan/HUBKit.git'
```
Then run `pod install`

**Note:** HUBKit is using a private GitHub repository. You need correct authorization to fetch the source

##Development

####Requirements:
Xcode 7.0+  

####Target Platforms:
iOS 8+  
Standard Architectures (armv7 armv7s arm64)  

####Dependencies:

Dependencies are managed via CocoaPods. See the Podfile for semantic versioning restrictions.

* [ReactiveCocoa](https://github.com/ReactiveCocoa/ReactiveCocoa)
* [Mantle](https://github.com/Mantle/Mantle)
* [AFNetworking 2.0](https://github.com/AFNetworking/AFNetworking)


[Specta](https://github.com/specta/specta), [Expecta](https://github.com/specta/expecta) and [OCMockito](https://github.com/jonreid/OCMockito) for unit tests.

The dependencies are **NOT** included in the final build artefact. Customers integrating HUBKit need to manage the dependencies for their own project.


####Environment setup:

Install CocoaPods: http://cocoapods.org/

**Cocoapods is required**  

```
$ sudo gem install cocoapods
```

Don't open the .xcodeproj just yet, we'll be installing the pod dependencies first.

```
$ git clone git@github.com:AuthenticEntertainment/HUB-iOS-SDK.git HUBKit
$ pod install
# use --verbose if you want to see exactly what's going on
$ open HUBKit.xcworkspace
```
Cocoapods sets up the Workspace, use that from now on.

We strongly recommend restarting your workspace after installing the dependencies.

####Sample Application:

There is a folder named `SampleApp` inside the HUBKit library. This is a simple storyboard application to test integration of the library. It's not particularly pretty, but it does provide some useful patterns for creating Reactive sequences.

**Usage**

* Make sure you under the `SampleApplication` folder and run `pod install`.
* Open `SampleApplication.xcworkspace`
* Build and Run in simulator or device.

**Note:** `SampleApp` is using local HUBKit directory as the pod source. Please check `SampleApp/Podfile` to find more detail

##Example code usage
#####Create an API Client instance:
```objc
HKTClient* myClient = [HKTClient clientWithAPIKey:@"myAPIKey"];
```
####Fetch a product by ID then set it's title on a label:
```objc
RAC(self.myMovieTitleLabel, text) =  
 [[myClient fetchProductWithID:@"myID"]
   map:^NSString*(HKTProduct* product) {
       return product.title;
  }];
```
####Search for a movie based on a search query and valid API parameters
```objc
NSArray* exampleSearchParams =  
@[[HKTRequestParameter parameterWithContentTypeOptions: HKTContentTypeMovie|HKTContentTypeTrailer],
[HKTRequestParameter parameterWithMinYear:@2010]];

[myClient searchForProductsMatchingQuery:@"Batman" withParameters: exampleSearchParameters];
```

##Issues or Questions

Please use the GitHub issues for any problems or questions, selecting the appropriate label and including as much context in your description as possible.

##Contributing:

Fork and create a branch with your changes. The branch should be all lowercase and hyphen separated:  

```
git checkout -b short-feature-name
```


Copyright 2015 Movideo
