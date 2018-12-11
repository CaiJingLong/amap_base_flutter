//
// Created by Yohom Bao on 2018/11/27.
//

#import "MAMapView.h"
#import "MAUserLocationRepresentation.h"
#import "UnifiedMyLocationStyle.h"
#import "NSString+Color.h"


@implementation UnifiedMyLocationStyle {

}

- (NSString *)description {
    NSMutableString *description = [NSMutableString stringWithFormat:@"<%@: ", NSStringFromClass([self class])];
    [description appendFormat:@"self.radiusFillColor=%p", self.radiusFillColor];
    [description appendFormat:@", self.strokeColor=%p", self.strokeColor];
    [description appendFormat:@", self.strokeWidth=%f", self.strokeWidth];
    [description appendFormat:@", self.showsAccuracyRing=%d", self.showsAccuracyRing];
    [description appendFormat:@", self.showsHeadingIndicator=%d", self.showsHeadingIndicator];
    [description appendFormat:@", self.locationDotBgColor=%p", self.locationDotBgColor];
    [description appendFormat:@", self.locationDotFillColor=%p", self.locationDotFillColor];
    [description appendFormat:@", self.enablePulseAnnimation=%d", self.enablePulseAnnimation];
    [description appendFormat:@", self.image=%p", self.image];
    [description appendString:@">"];
    return description;
}

- (void)applyTo:(MAMapView *)mapView {
    MAUserLocationRepresentation *r = [[MAUserLocationRepresentation alloc] init];

    r.showsAccuracyRing = _showsAccuracyRing;
    r.showsHeadingIndicator = _showsHeadingIndicator;
    r.fillColor = [_radiusFillColor hexStringToColor];
    r.strokeColor = [_strokeColor hexStringToColor];
    r.lineWidth = _strokeWidth;
    r.enablePulseAnnimation = _enablePulseAnnimation;
    r.locationDotBgColor = [_locationDotBgColor hexStringToColor];
    r.locationDotFillColor = [_locationDotFillColor hexStringToColor];
//    r.image = nil;

    mapView.showsUserLocation = _showMyLocation;

    // 如果要跟踪方向, 那么就设置为userTrackingMode
    if (_showsHeadingIndicator) {
        mapView.userTrackingMode = MAUserTrackingModeFollowWithHeading;
    } else if (_showMyLocation) {
        mapView.userTrackingMode = MAUserTrackingModeFollow;
    }
    [mapView updateUserLocationRepresentation:r];
}


@end
