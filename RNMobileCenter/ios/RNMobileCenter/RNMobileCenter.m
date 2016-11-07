#import "RNMobileCenter.h"

@implementation RNMobileCenter

static NSString *appSecret;
static SNMWrapperSdk * wrapperSdk;

+ (void) setAppSecret: (NSString *)secret
{
  appSecret = secret;
}

+ (NSString *) getAppSecret
{
  if (appSecret == nil) {
    NSString * plistPath = [[NSBundle mainBundle] pathForResource:@"MobileCenter-Config" ofType:@"plist"];
    NSDictionary * config = [NSDictionary dictionaryWithContentsOfFile:plistPath];

    appSecret = [config objectForKey:@"AppSecret"];
    // If the AppSecret is not set, we will pass nil to SNMSonoma which will error out, as expected
  }

  return appSecret;
}

+ (void) initializeMobileCenter
{
  if (![SNMSonoma isInitialized]) {
      SNMWrapperSdk * wrapperSdk =
        [[SNMWrapperSdk alloc]
            initWithWrapperSdkVersion:@"0.1.0"
            wrapperSdkName:@"mobilecenter.react-native"
            liveUpdateReleaseLabel:nil
            liveUpdateDeploymentKey:nil
            liveUpdatePackageHash:nil];
      [self setWrapperSdk:wrapperSdk];
      [SNMSonoma start:[RNMobileCenter getAppSecret]];
  }
}

+ (void) setEnabled:(BOOL) enabled
{
  [SNMSonoma setEnabled:enabled];
}

+ (void) setLogLevel: (SNMLogLevel)logLevel
{
  [SNMSonoma setLogLevel:logLevel];
}

+ (SNMLogLevel) logLevel
{
  return [SNMSonoma logLevel];
}

+ (SNMWrapperSdk *) getWrapperSdk {
    return wrapperSdk;
}
+ (void) setWrapperSdk:(SNMWrapperSdk *)sdk {
    wrapperSdk = sdk;
    [SNMSonoma setWrapperSdk:sdk];
}

@end
