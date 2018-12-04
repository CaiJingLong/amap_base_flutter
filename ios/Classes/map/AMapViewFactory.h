//
// Created by Yohom Bao on 2018/11/25.
//

#import <Foundation/Foundation.h>
#import <Flutter/Flutter.h>
#import "MAMapKit.h"

@class UnifiedAMapOptions;

@interface AMapViewFactory : NSObject <FlutterPlatformViewFactory>
@end

@interface AMapView : NSObject <FlutterPlatformView, AMapSearchDelegate, MAMapViewDelegate, AMapSearchDelegate>
- (instancetype)initWithFrame:(CGRect)frame
                      options:(UnifiedAMapOptions *)options
               viewIdentifier:(int64_t)viewId;

- (void) setup;
@end
