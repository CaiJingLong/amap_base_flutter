//
// Created by Yohom Bao on 2018/11/25.
//

#import <Foundation/Foundation.h>
#import <Flutter/Flutter.h>

@class UnifiedAMapOptions;

@interface AMapViewFactory : NSObject <FlutterPlatformViewFactory>
@end

@interface AMapView : NSObject <FlutterPlatformView>
- (instancetype)initWithFrame:(CGRect)frame
                      options:(UnifiedAMapOptions *)options
               viewIdentifier:(int64_t)viewId;

- (void) setup;
@end
