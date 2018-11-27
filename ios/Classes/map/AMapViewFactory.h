//
// Created by Yohom Bao on 2018/11/25.
//

#import <Foundation/Foundation.h>
#import <Flutter/Flutter.h>

@class AMapOptions;

@interface AMapViewFactory : NSObject <FlutterPlatformViewFactory>
@end

@interface AMapView : NSObject <FlutterPlatformView>
- (instancetype)initWithFrame:(CGRect)frame
                      options:(AMapOptions *)options
               viewIdentifier:(int64_t)viewId;

- (void) setup;
@end
