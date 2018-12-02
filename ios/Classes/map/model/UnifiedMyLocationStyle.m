//
// Created by Yohom Bao on 2018/11/27.
//

#import <AMap3DMap/MAMapKit/MAUserLocationRepresentation.h>
#import <AMap3DMap/MAMapKit/MAMapView.h>
#import "UnifiedMyLocationStyle.h"


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

- (void)applyTo: (MAMapView *) mapView {
    MAUserLocationRepresentation *r = [[MAUserLocationRepresentation alloc] init];

    r.showsAccuracyRing = self.showsAccuracyRing;
    r.showsHeadingIndicator = self.showsHeadingIndicator;
    r.fillColor = [self hexStringToColor:self.radiusFillColor];
    r.strokeColor = [self hexStringToColor:self.strokeColor];
    r.lineWidth = self.strokeWidth;
    r.enablePulseAnnimation = self.enablePulseAnnimation;
    r.locationDotBgColor = [self hexStringToColor:self.locationDotBgColor];
    r.locationDotFillColor = [self hexStringToColor:self.locationDotFillColor];
    r.image = nil;

    mapView.showsUserLocation = self.showMyLocation;
    if (mapView.showsUserLocation) {
        mapView.userTrackingMode = MAUserTrackingModeFollow;
    }
    [mapView updateUserLocationRepresentation:r];
}

- (UIColor *)hexStringToColor:(NSString *)source {
    NSString *cString = [[source stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];

    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }

    // 从六位数值中找到RGB对应的位数并转换
    NSRange range;
    range.location = 0;
    range.length = 2;

    //A, R,G, B
    NSString *aString = [cString substringWithRange:range];

    range.location = 2;
    NSString *rString = [cString substringWithRange:range];

    range.location = 4;
    NSString *gString = [cString substringWithRange:range];

    range.location = 6;
    NSString *bString = [cString substringWithRange:range];

    // Scan values
    unsigned int a, r, g, b;
    [[NSScanner scannerWithString:aString] scanHexInt:&a];
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];

    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:((float) a / 255.0f)];
}

@end
