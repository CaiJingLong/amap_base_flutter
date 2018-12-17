//
// Created by Yohom Bao on 2018-12-12.
//

#import "NSString+GeoPoint.h"
#import "AMapSearchKit.h"


@implementation NSString (GeoPoint)

- (NSArray<AMapGeoPoint *> *)stringToAMapGeoPoint {
    // 格式 116.473648,39.99369;116.474335,39.993225;116.474594,39.993172;116.474678,39.993111
    NSMutableArray <AMapGeoPoint *> * result = [[NSMutableArray alloc] init];

    NSArray <NSString *> *pointStringArray = [self componentsSeparatedByString:@";"];
    for (NSUInteger i = 0; i < pointStringArray.count; ++i) {
        NSArray <NSString *> *point = [pointStringArray[i] componentsSeparatedByString:@","];
        AMapGeoPoint *geoPoint = [[AMapGeoPoint alloc] init];
        geoPoint.longitude = [point[0] floatValue];
        geoPoint.latitude = [point[1] floatValue];
        [result addObject:geoPoint];
    }
    return result;
}

@end