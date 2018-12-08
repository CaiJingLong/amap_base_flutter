//
//  Misc.m
//  SearchV3Demo
//
//  Created by songjian on 13-8-22.
//  Copyright (c) 2013年 songjian. All rights reserved.
//

#import <Flutter/Flutter.h>
#import "Misc.h"

@implementation Misc

+ (CLLocationCoordinate2D *)coordinatesForString:(NSString *)string
                                 coordinateCount:(NSUInteger *)coordinateCount
                                      parseToken:(NSString *)token {
    if (string == nil) {
        return NULL;
    }
    if (token == nil) {
        token = @",";
    }
    NSString *str = @"";
    if (![token isEqualToString:@","]) {
        str = [string stringByReplacingOccurrencesOfString:token withString:@","];
    } else {
        str = [NSString stringWithString:string];
    }
    NSArray *components = [str componentsSeparatedByString:@","];
    NSUInteger count = [components count] / 2;
    if (coordinateCount != NULL) {
        *coordinateCount = count;
    }
    CLLocationCoordinate2D *coordinates = (CLLocationCoordinate2D *) malloc(count * sizeof(CLLocationCoordinate2D));

    for (int i = 0; i < count; i++) {
        coordinates[i].longitude = [[components objectAtIndex:2 * i] doubleValue];
        coordinates[i].latitude = [[components objectAtIndex:2 * i + 1] doubleValue];
    }

    return coordinates;
}

+ (MAPolyline *)polylineForCoordinateString:(NSString *)coordinateString {
    if (coordinateString.length == 0) {
        return nil;
    }

    NSUInteger count = 0;

    CLLocationCoordinate2D *coordinates = [self coordinatesForString:coordinateString
                                                     coordinateCount:&count
                                                          parseToken:@";"];

    MAPolyline *polyline = [MAPolyline polylineWithCoordinates:coordinates count:count];

    free(coordinates), coordinates = NULL;

    return polyline;
}

+ (MAPolyline *)polylineForBusLine:(AMapBusLine *)busLine {
    if (busLine == nil) {
        return nil;
    }

    return [self polylineForCoordinateString:busLine.polyline];
}

+ (MAMapRect)unionMapRect1:(MAMapRect)mapRect1 mapRect2:(MAMapRect)mapRect2 {
    CGRect rect1 = CGRectMake(mapRect1.origin.x, mapRect1.origin.y, mapRect1.size.width, mapRect1.size.height);
    CGRect rect2 = CGRectMake(mapRect2.origin.x, mapRect2.origin.y, mapRect2.size.width, mapRect2.size.height);

    CGRect unionRect = CGRectUnion(rect1, rect2);

    return MAMapRectMake(unionRect.origin.x, unionRect.origin.y, unionRect.size.width, unionRect.size.height);
}

+ (MAMapRect)mapRectUnion:(MAMapRect *)mapRects count:(NSUInteger)count {
    if (mapRects == NULL || count == 0) {
        NSLog(@"%s: 无效的参数.", __func__);
        return MAMapRectZero;
    }

    MAMapRect unionMapRect = mapRects[0];

    for (int i = 1; i < count; i++) {
        unionMapRect = [self unionMapRect1:unionMapRect mapRect2:mapRects[i]];
    }

    return unionMapRect;
}

+ (MAMapRect)mapRectForOverlays:(NSArray *)overlays {
    if (overlays.count == 0) {
        NSLog(@"%s: 无效的参数.", __func__);
        return MAMapRectZero;
    }

    MAMapRect mapRect;

    MAMapRect *buffer = (MAMapRect *) malloc(overlays.count * sizeof(MAMapRect));

    [overlays enumerateObjectsUsingBlock:^(id <MAOverlay> obj, NSUInteger idx, BOOL *stop) {
        buffer[idx] = [obj boundingMapRect];
    }];

    mapRect = [self mapRectUnion:buffer count:overlays.count];

    free(buffer), buffer = NULL;

    return mapRect;
}

+ (MAMapRect)minMapRectForMapPoints:(MAMapPoint *)mapPoints count:(NSUInteger)count {
    if (mapPoints == NULL || count <= 1) {
        NSLog(@"%s: 无效的参数.", __func__);
        return MAMapRectZero;
    }

    CGFloat minX = mapPoints[0].x, minY = mapPoints[0].y;
    CGFloat maxX = minX, maxY = minY;

    /* Traverse and find the min, max. */
    for (int i = 1; i < count; i++) {
        MAMapPoint point = mapPoints[i];

        if (point.x < minX) {
            minX = point.x;
        }

        if (point.x > maxX) {
            maxX = point.x;
        }

        if (point.y < minY) {
            minY = point.y;
        }

        if (point.y > maxY) {
            maxY = point.y;
        }
    }

    /* Construct outside min rectangle. */
    return MAMapRectMake(minX, minY, fabs(maxX - minX), fabs(maxY - minY));
}

+ (MAMapRect)minMapRectForAnnotations:(NSArray *)annotations {
    if (annotations.count <= 1) {
        NSLog(@"%s: 无效的参数.", __func__);
        return MAMapRectZero;
    }

    MAMapPoint *mapPoints = (MAMapPoint *) malloc(annotations.count * sizeof(MAMapPoint));

    [annotations enumerateObjectsUsingBlock:^(id <MAAnnotation> obj, NSUInteger idx, BOOL *stop) {
        mapPoints[idx] = MAMapPointForCoordinate([obj coordinate]);
    }];

    MAMapRect minMapRect = [self minMapRectForMapPoints:mapPoints count:annotations.count];

    free(mapPoints), mapPoints = NULL;

    return minMapRect;
}

+ (NSString *)getApplicationName {
    NSDictionary *bundleInfo = [[NSBundle mainBundle] infoDictionary];
    return [bundleInfo valueForKey:@"CFBundleDisplayName"] ?: [bundleInfo valueForKey:@"CFBundleName"];
}

+ (NSString *)getApplicationScheme {
    NSDictionary *bundleInfo = [[NSBundle mainBundle] infoDictionary];
    NSString *bundleIdentifier = [[NSBundle mainBundle] bundleIdentifier];
    NSArray *URLTypes = [bundleInfo valueForKey:@"CFBundleURLTypes"];

    NSString *scheme;
    for (NSDictionary *dic in URLTypes) {
        NSString *URLName = [dic valueForKey:@"CFBundleURLName"];
        if ([URLName isEqualToString:bundleIdentifier]) {
            scheme = [[dic valueForKey:@"CFBundleURLSchemes"] objectAtIndex:0];
            break;
        }
    }

    return scheme;
}

+ (double)distanceToPoint:(MAMapPoint)p fromLineSegmentBetween:(MAMapPoint)l1 and:(MAMapPoint)l2 {
    double A = p.x - l1.x;
    double B = p.y - l1.y;
    double C = l2.x - l1.x;
    double D = l2.y - l1.y;

    double dot = A * C + B * D;
    double len_sq = C * C + D * D;
    double param = dot / len_sq;

    double xx, yy;

    if (param < 0 || (l1.x == l2.x && l1.y == l2.y)) {
        xx = l1.x;
        yy = l1.y;
    } else if (param > 1) {
        xx = l2.x;
        yy = l2.y;
    } else {
        xx = l1.x + param * C;
        yy = l1.y + param * D;
    }

    return MAMetersBetweenMapPoints(p, MAMapPointMake(xx, yy));
}

+ (NSString *)toAMapErrorDesc:(NSInteger)errorCode {
    switch (errorCode) {
        case 1000 :
            return @"请求正常";
        case 1001 :
            return @"开发者签名未通过";
        case 1002 :
            return @"用户Key不正确或过期";
        case 1003 :
            return @"没有权限使用相应的接口";
        case 1008 :
            return @"MD5安全码未通过验证";
        case 1009 :
            return @"请求Key与绑定平台不符";
        case 1012 :
            return @"权限不足，服务请求被拒绝";
        case 1013 :
            return @"该Key被删除";
        case 1100 :
            return @"引擎服务响应错误";
        case 1101 :
            return @"引擎返回数据异常";
        case 1102 :
            return @"高德服务端请求链接超时";
        case 1103 :
            return @"读取服务结果返回超时";
        case 1200 :
            return @"请求参数非法";
        case 1201 :
            return @"请求条件中，缺少必填参数";
        case 1202 :
            return @"服务请求协议非法";
        case 1203 :
            return @"服务端未知错误";
        case 1800 :
            return @"服务端新增错误";
        case 1801 :
            return @"协议解析错误";
        case 1802 :
            return @"socket 连接超时 - SocketTimeoutException";
        case 1803 :
            return @"url异常 - MalformedURLException";
        case 1804 :
            return @"未知主机 - UnKnowHostException";
        case 1806 :
            return @"http或socket连接失败 - ConnectionException";
        case 1900 :
            return @"未知错误";
        case 1901 :
            return @"参数无效";
        case 1902 :
            return @"IO 操作异常 - IOException";
        case 1903 :
            return @"空指针异常 - NullPointException";
        case 2000 :
            return @"Tableid格式不正确";
        case 2001 :
            return @"数据ID不存在";
        case 2002 :
            return @"云检索服务器维护中";
        case 2003 :
            return @"Key对应的tableID不存在";
        case 2100 :
            return @"找不到对应的userid信息";
        case 2101 :
            return @"App Key未开通“附近”功能";
        case 2200 :
            return @"在开启自动上传功能的同时对表进行清除或者开启单点上传的功能";
        case 2201 :
            return @"USERID非法";
        case 2202 :
            return @"NearbyInfo对象为空";
        case 2203 :
            return @"两次单次上传的间隔低于7秒";
        case 2204 :
            return @"Point为空，或与前次上传的相同";
        case 3000 :
            return @"规划点（包括起点、终点、途经点）不在中国陆地范围内";
        case 3001 :
            return @"规划点（包括起点、终点、途经点）附近搜不到路";
        case 3002 :
            return @"路线计算失败，通常是由于道路连通关系导致";
        case 3003 :
            return @"步行算路起点、终点距离过长导致算路失败。";
        case 4000 :
            return @"短串分享认证失败";
        case 4001 :
            return @"短串请求失败";
        default:
            return @"无法识别的代码";
    }
}


@end
