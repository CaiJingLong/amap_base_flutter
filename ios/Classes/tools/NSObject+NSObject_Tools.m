//
//  NSObject+NSObject_Tools.m
//  amap_base
//
//  Created by Caijinglong on 2018/12/6.
//
#import "NSObject+NSObject_Tools.h"

@implementation NSObject (NSObject_Tools)

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

static NSString *channel = @"me.yohom/tools";
static NSString *convert = @"convert";

- (void)setupToolsChannel {

    FlutterMethodChannel *methodChannel = [FlutterMethodChannel methodChannelWithName:channel binaryMessenger:[self messenger]];
    [methodChannel setMethodCallHandler:^(FlutterMethodCall *call, FlutterResult result) {
        if ([convert isEqualToString:call.method]) {
            NSDictionary *paramDic = call.arguments;
            CGFloat lat = [paramDic[@"lat"] floatValue];
            CGFloat lon = [paramDic[@"lon"] floatValue];
            int intType = [paramDic[@"type"] intValue];
            AMapCoordinateType type = [self convertTypeWithInt:intType];
            CLLocationCoordinate2D coordinate2D = AMapCoordinateConvert(CLLocationCoordinate2DMake(lat, lon), type);
            NSString *r = [NSString stringWithFormat:@"%f|%f", coordinate2D.latitude, coordinate2D.longitude];
            result(r);
        } else {
            result(FlutterMethodNotImplemented);
        }
    }];
}


@end
