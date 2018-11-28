//
//  UnifiedUiSettings.h
//  amap_base
//
//  Created by Yohom Bao on 2018/11/28.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
#import <MAMapKit/MAMapKit.h>

@interface UnifiedUiSettings : JSONModel

/// 是否允许显示缩放按钮
@property(nonatomic) NSString *isZoomControlsEnabled;
/// 设置缩放按钮的位置
@property(nonatomic) NSInteger zoomPosition;
/// 指南针
@property(nonatomic) BOOL isCompassEnabled;
/// 定位按钮
@property(nonatomic) BOOL isMyLocationButtonEnabled;
/// 比例尺控件
@property(nonatomic) BOOL isScaleControlsEnabled;
/// 地图Logo
@property(nonatomic) NSInteger logoPosition;

- (void) applyTo: (MAMapView*) map;

@end
