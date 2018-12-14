//
//  UnifiedUiSettings.h
//  amap_base
//
//  Created by Yohom Bao on 2018/11/28.
//

#import <Foundation/Foundation.h>
#import <MAMapKit/MAMapKit.h>

@interface UnifiedUiSettings: NSObject

/// 设置缩放按钮的位置
@property(nonatomic) NSInteger zoomPosition;

/// 指南针
@property(nonatomic) BOOL isCompassEnabled;

/// 比例尺控件
@property(nonatomic) BOOL isScaleControlsEnabled;

/// 地图Logo
@property(nonatomic) NSInteger logoPosition;

/// 缩放手势
@property(nonatomic) BOOL isZoomGesturesEnabled;

/// 滑动手势
@property(nonatomic) BOOL isScrollGesturesEnabled;

/// 旋转手势
@property(nonatomic) BOOL isRotateGesturesEnabled;

/// 倾斜手势
@property(nonatomic) BOOL isTiltGesturesEnabled;

- (void)applyTo:(MAMapView *)map;

@end
