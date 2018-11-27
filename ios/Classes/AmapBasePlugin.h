#import <Flutter/Flutter.h>
#import <AMapNaviKit/AMapNaviKit.h>
#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>

@interface AmapBasePlugin : NSObject <FlutterPlugin>

+ (NSObject <FlutterPluginRegistrar> *)registrar;

@end
