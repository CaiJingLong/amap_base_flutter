//
// Created by Yohom Bao on 2018/11/25.
//

#import <Foundation/Foundation.h>
#import <Flutter/Flutter.h>

@class AMapOptionsLike;

@interface AMapViewFactory : NSObject <FlutterPlatformViewFactory>
@end

@interface AMapView : NSObject <FlutterPlatformView>

- (instancetype)initWithOptions:(AMapOptionsLike *)option;

@end
