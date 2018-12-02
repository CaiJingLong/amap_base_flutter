//
//  UnifiedUiSettings.m
//  amap_base
//
//  Created by Yohom Bao on 2018/11/28.
//

#import "UnifiedUiSettings.h"

@implementation UnifiedUiSettings

+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}

- (void) applyTo:(MAMapView *)map {
    // todo 设置logo的位置
    map.showsCompass = self.isCompassEnabled;
    map.showsScale = self.isScaleControlsEnabled;
    map.zoomEnabled = self.isZoomGesturesEnabled;
    map.rotateEnabled = self.isRotateGesturesEnabled;
    map.scrollEnabled = self.isScrollGesturesEnabled;
    map.rotateCameraEnabled = self.isTiltGesturesEnabled;
}

@end
