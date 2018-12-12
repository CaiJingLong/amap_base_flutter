//
// Created by Yohom Bao on 2018-12-12.
//

#import <Foundation/Foundation.h>
#import <Flutter/Flutter.h>

@class MAMapView;
@class FlutterMethodCall;

@protocol MapMethodHandler <NSObject>

@required
- (NSObject <MapMethodHandler> *)initWith:(MAMapView *)mapView;
@required
- (void)onMethodCall:(FlutterMethodCall *)call :(FlutterResult)result;

@end

@protocol SearchMethodHandler <NSObject>
@required
- (void)onMethodCall:(FlutterMethodCall *)call :(FlutterResult)result;
@end