/**
 * Copyright (c) 2015-present, Facebook, Inc.
 * All rights reserved.
 *
 * This source code is licensed under the BSD-style license found in the
 * LICENSE file in the root directory of this source tree. An additional grant
 * of patent rights can be found in the PATENTS file in the same directory.
 */

#import "AppDelegate.h"
#import <AppCenterReactNative/AppCenterReactNative.h>
#import <AppCenterReactNativePush/AppCenterReactNativePush.h>
#import <AppCenterReactNativeAnalytics/AppCenterReactNativeAnalytics.h>
#import <AppCenterReactNativeCrashes/AppCenterReactNativeCrashes.h>
#import <AppCenterReactNativeShared/AppCenterReactNativeShared.h>

#import <React/RCTBundleURLProvider.h>
#import <React/RCTRootView.h>
@import AppCenter;

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  [MSAppCenter setLogLevel: MSLogLevelVerbose];
  
  NSURL *jsCodeLocation;

  id appSecret = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppSecret"];
  if ([appSecret isKindOfClass:[NSString class]]) {
    [AppCenterReactNativeShared setAppSecret:appSecret];
  }
  
  id startAutomatically = [[NSUserDefaults standardUserDefaults] objectForKey:@"StartAutomatically"];
  if ([startAutomatically isKindOfClass:[NSNumber class]]) {
    [AppCenterReactNativeShared setStartAutomatically:[startAutomatically boolValue]];
  }
  
  [AppCenterReactNativePush register];  // Initialize AppCenter push

  [AppCenterReactNativeCrashes register];  // Initialize AppCenter crashes

  [AppCenterReactNativeAnalytics registerWithInitiallyEnabled:true];  // Initialize AppCenter analytics

  [AppCenterReactNative register];  // Initialize AppCenter 

  jsCodeLocation = [[RCTBundleURLProvider sharedSettings] jsBundleURLForBundleRoot:@"index.ios" fallbackResource:nil];

  RCTRootView *rootView = [[RCTRootView alloc] initWithBundleURL:jsCodeLocation
                                                      moduleName:@"TestApp"
                                               initialProperties:nil
                                                   launchOptions:launchOptions];
  rootView.backgroundColor = [[UIColor alloc] initWithRed:1.0f green:1.0f blue:1.0f alpha:1];

  self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
  UIViewController *rootViewController = [UIViewController new];
  rootViewController.view = rootView;
  self.window.rootViewController = rootViewController;
  [self.window makeKeyAndVisible];
  return YES;
}

@end
