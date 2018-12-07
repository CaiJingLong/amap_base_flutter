//
// Created by Yohom Bao on 2018-12-07.
//

#import <Foundation/Foundation.h>
#import <Flutter/Flutter.h>

@class MAMapView;
@class FlutterMethodCall;

@protocol MapMethodHandler <NSObject>

@required
- (NSObject <MapMethodHandler> *)with:(MAMapView *)mapView;
@required
- (void)onMethodCall:(FlutterMethodCall *)call :(FlutterResult)result;

@end