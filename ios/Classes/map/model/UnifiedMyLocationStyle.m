//
// Created by Yohom Bao on 2018/11/27.
//

#import <AMap3DMap/MAMapKit/MAUserLocationRepresentation.h>
#import "UnifiedMyLocationStyle.h"


@implementation UnifiedMyLocationStyle {

}

- (NSString *)description {
    NSMutableString *description = [NSMutableString string];
    [description appendFormat:@"self.myLocationIcon=%@", self.myLocationIcon];
    [description appendFormat:@", self.anchorU=%f", self.anchorU];
    [description appendFormat:@", self.anchorV=%f", self.anchorV];
    [description appendFormat:@", self.radiusFillColor=%@", self.radiusFillColor];
    [description appendFormat:@", self.strokeColor=%@", self.strokeColor];
    [description appendFormat:@", self.strokeWidth=%f", self.strokeWidth];
    [description appendFormat:@", self.myLocationType=%i", self.myLocationType];
    [description appendFormat:@", self.interval=%i", self.interval];
    [description appendFormat:@", self.showMyLocation=%d", self.showMyLocation];

    NSMutableString *superDescription = [[super description] mutableCopy];
    NSUInteger length = [superDescription length];

    if (length > 0 && [superDescription characterAtIndex:length - 1] == '>') {
        [superDescription insertString:@", " atIndex:length - 1];
        [superDescription insertString:description atIndex:length + 1];
        return superDescription;
    } else {
        return [NSString stringWithFormat:@"<%@: %@>", NSStringFromClass([self class]), description];
    }
}

- (MAUserLocationRepresentation *)toMAUserLocationRepresentation {
    MAUserLocationRepresentation *r = [[MAUserLocationRepresentation alloc] init];

    r.showsAccuracyRing = YES;
    r.showsHeadingIndicator = YES;
    r.fillColor = [self hexStringToColor:self.radiusFillColor];
    r.strokeColor = [self hexStringToColor:self.strokeColor];
    r.lineWidth = self.strokeWidth;
    r.enablePulseAnnimation = YES;
    r.locationDotBgColor = UIColor.whiteColor;
    r.locationDotFillColor = [UIColor grayColor]; ///定位点蓝色圆点颜色，不设置默认蓝色
//    r.image = [UIImage imageNamed:@"你的图片"]; ///定位图标, 与蓝色原点互斥
    return r;
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