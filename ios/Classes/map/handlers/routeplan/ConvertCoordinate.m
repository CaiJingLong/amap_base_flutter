//
// Created by Yohom Bao on 2018-12-07.
//

#import <CoreLocation/CoreLocation.h>
#import "ConvertCoordinate.h"
#import "AMapFoundationKit.h"


@implementation ConvertCoordinate {
    MAMapView *_mapView;
}

- (NSObject <MapMethodHandler> *)with:(MAMapView *)mapView {
    _mapView = mapView;
    return self;
}

- (void)onMethodCall:(FlutterMethodCall *)call :(FlutterResult)result {
    NSDictionary *paramDic = call.arguments;
    CGFloat lat = [paramDic[@"lat"] floatValue];
    CGFloat lon = [paramDic[@"lon"] floatValue];
    int intType = [paramDic[@"type"] intValue];
    AMapCoordinateType type = [self convertTypeWithInt:intType];
    CLLocationCoordinate2D coordinate2D = AMapCoordinateConvert(CLLocationCoordinate2DMake(lat, lon), type);
    NSString *r = [NSString stringWithFormat:@"{\"latitude\":%f,\"longitude\":%f}", coordinate2D.latitude, coordinate2D.longitude];
    result(r);
}

- (AMapCoordinateType)convertTypeWithInt:(int)type {
    switch (type) {
        case 0:
            return AMapCoordinateTypeGPS;
        case 1:
            return AMapCoordinateTypeBaidu;
        case 2:
            return AMapCoordinateTypeMapBar;
        case 3:
            return AMapCoordinateTypeMapABC;
        case 4:
            return AMapCoordinateTypeSoSoMap;
        case 5:
            return AMapCoordinateTypeAliYun;
        case 6:
            return AMapCoordinateTypeGoogle;
        default:
            return AMapCoordinateTypeGPS;
    }
}

@end