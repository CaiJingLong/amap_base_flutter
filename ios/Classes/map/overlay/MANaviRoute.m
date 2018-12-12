//
//  MANaviRoute.m
//  OfficialDemo3D
//
//  Created by yi chen on 1/7/15.
//  Copyright (c) 2015 songjian. All rights reserved.
//

#import "MANaviRoute.h"
#import "Misc.h"
#import "UnifiedRouteOverlay.h"
#import "NSArray+Rx.h"
#import "UnifiedAMapOptions.h"
#import "MJExtension.h"

#define kMANaviRouteReplenishPolylineFilter     5

@interface MANaviRoute ()

@property(nonatomic, weak) MAMapView *mapView;

@end

@implementation MANaviRoute

#pragma mark - Format Search Result

/* polyline parsed from _search result. */

+ (MAPolyline *)polylineForStep:(UnifiedDriveStep *)step {
    if (step == nil) {
        return nil;
    }

    NSString *result = [[step.polyline map:^(LatLng *latLng) {
        return [NSString stringWithFormat:@"%f,%f", latLng.longitude, latLng.latitude];
    }] componentsJoinedByString:@";"];
    return [Misc polylineForCoordinateString:result];
}

#pragma mark - replenish

+ (void)replenishPolylinesForPathWith:(MAPolyline *)stepPolyline
                         lastPolyline:(MAPolyline *)lastPolyline
                            Polylines:(NSMutableArray *)polylines {
    CLLocationCoordinate2D startCoor;
    CLLocationCoordinate2D endCoor;

    [stepPolyline getCoordinates:&endCoor range:NSMakeRange(0, 1)];

    [lastPolyline getCoordinates:&startCoor range:NSMakeRange(lastPolyline.pointCount - 1, 1)];


    if ((endCoor.latitude != startCoor.latitude || endCoor.longitude != startCoor.longitude)) {
        LineDashPolyline *dashPolyline = [self replenishPolylineWithStart:startCoor end:endCoor];
        if (dashPolyline) {
            [polylines addObject:dashPolyline];
        }
    }
}

+ (LineDashPolyline *)replenishPolylineWithStart:(CLLocationCoordinate2D)startCoor end:(CLLocationCoordinate2D)endCoor {
    if (!CLLocationCoordinate2DIsValid(startCoor) || !CLLocationCoordinate2DIsValid(endCoor)) {
        return nil;
    }

    double distance = MAMetersBetweenMapPoints(MAMapPointForCoordinate(startCoor), MAMapPointForCoordinate(endCoor));

    LineDashPolyline *dashPolyline = nil;

    // 过滤一下，距离比较近就不加虚线了
    if (distance > kMANaviRouteReplenishPolylineFilter) {
        CLLocationCoordinate2D points[2];
        points[0] = startCoor;
        points[1] = endCoor;
        MAPolyline *polyline = [MAPolyline polylineWithCoordinates:points count:2];
        dashPolyline = [[LineDashPolyline alloc] initWithPolyline:polyline];
    }

    return dashPolyline;
}

#pragma mark - colored route

+ (MAPolyline *)multiColoredPolylineWithDrivePath:(UnifiedDrivePath *)path polylineColors:(NSArray **)polylineColors {
    if (path == nil) {
        return nil;
    }

    NSMutableArray *mutablePolylineColors = [NSMutableArray array];

    NSMutableArray *coordinates = [NSMutableArray array];
    NSMutableArray *indexes = [NSMutableArray array];

    NSMutableArray<UnifiedTMC *> *tmcs = [NSMutableArray array];
    NSMutableArray *coorArray = [NSMutableArray array];

    [path.steps enumerateObjectsUsingBlock:^(UnifiedDriveStep *_Nonnull step, NSUInteger idx, BOOL *_Nonnull stop) {
        [coorArray addObjectsFromArray:step.polyline];
        [tmcs addObjectsFromArray:step.TMCs];
    }];

    NSMutableArray *mergedTmcs = [NSMutableArray array];
    NSString *prevStatus = [UnifiedTMC mj_objectWithKeyValues:tmcs.firstObject].status;
    double sumDistance = 0;
    for (UnifiedTMC *tmc in tmcs) {
        if ([prevStatus isEqualToString:tmc.status]) {
            sumDistance += tmc.distance;
        } else {
            AMapTMC *temp = [[AMapTMC alloc] init];
            temp.status = prevStatus;
            temp.distance = sumDistance;
            [mergedTmcs addObject:temp];

            sumDistance = tmc.distance;
            prevStatus = tmc.status;
        }
    }
    AMapTMC *temp = [[AMapTMC alloc] init];
    temp.status = prevStatus;
    temp.distance = sumDistance;
    [mergedTmcs addObject:temp];

    tmcs = mergedTmcs;


    int i = 1;

    NSInteger sumLength = 0;
    NSInteger statusesIndex = 0;
    NSInteger curTrafficLength = tmcs.firstObject.distance;
    [mutablePolylineColors addObject:[self colorWithTrafficStatus:tmcs.firstObject.status]];
    [indexes addObject:@(0)];
//    [coordinates addObject:coorArray[0]];
    for (; i < coorArray.count; ++i) {
        double oneDis = [self calcDistanceBetweenCoor:[self coordinateWithString:coorArray[i - 1]] andCoor:[self coordinateWithString:coorArray[i]]];
        if (sumLength + oneDis >= curTrafficLength) {
            if (sumLength + oneDis == curTrafficLength) {
                [coordinates addObject:coorArray[i]];
                [indexes addObject:@([coordinates count] - 1)];
            } else // 需要插入一个点
            {
                double rate = (oneDis == 0 ? 0 : ((curTrafficLength - sumLength) / oneDis));
                NSString *extrnPoint = [self calcPointWithStartPoint:coorArray[i - 1] endPoint:coorArray[i] rate:MAX(MIN(rate, 1.0), 0)];
                if (extrnPoint) {
                    [coordinates addObject:extrnPoint];
                    [indexes addObject:@([coordinates count] - 1)];
                    [coordinates addObject:coorArray[i]];
                } else {
                    [coordinates addObject:coorArray[i]];
                    [indexes addObject:@([coordinates count] - 1)];
                }

            }

            sumLength = (NSInteger) (sumLength + oneDis - curTrafficLength);

            if (++statusesIndex >= [tmcs count]) {
                break;
            }
            curTrafficLength = tmcs[(NSUInteger) statusesIndex].distance;
            [mutablePolylineColors addObject:[self colorWithTrafficStatus:tmcs[statusesIndex].status]];
        } else {
            [coordinates addObject:coorArray[i]];
            sumLength += oneDis;
        }
    } // end for

    //将最后一个点对齐到路径终点
    if (i < [coorArray count]) {
        while (i < [coorArray count]) {
            [coordinates addObject:coorArray[i]];
            i++;
        }

        [indexes removeLastObject];
        [indexes addObject:@([coordinates count] - 1)];
    }

    NSArray *array2 = indexes;
    // 添加overlay

    NSInteger count = coordinates.count;
    CLLocationCoordinate2D *runningCoords = (CLLocationCoordinate2D *) malloc(count * sizeof(CLLocationCoordinate2D));

    for (int j = 0; j < count; ++j) {
        NSString *oneCoor = coordinates[j];
        CLLocationCoordinate2D coor = [self coordinateWithString:oneCoor];
        runningCoords[j] = coor;
    }

    MAMultiPolyline *polyline = [MAMultiPolyline polylineWithCoordinates:runningCoords count:count drawStyleIndexes:array2];

    free(runningCoords);

    if (polylineColors) {
        *polylineColors = [mutablePolylineColors copy];
    }
    return polyline;
}

+ (UIColor *)colorWithTrafficStatus:(NSString *)status {
    if (status == nil) {
        status = @"未知";
    }

    static NSDictionary *colorMapping = nil;
    if (colorMapping == nil) {
        colorMapping = @{@"未知": [UIColor greenColor],
                @"畅通": [UIColor greenColor],
                @"缓行": [UIColor yellowColor],
                @"拥堵": [UIColor redColor]};
    }

    return colorMapping[status] ?: [UIColor greenColor];
}

+ (NSString *)calcPointWithStartPoint:(NSString *)start endPoint:(NSString *)end rate:(double)rate {
    if (rate > 1.0 || rate < 0) {
        return nil;
    }

    MAMapPoint from = MAMapPointForCoordinate([self coordinateWithString:start]);
    MAMapPoint to = MAMapPointForCoordinate([self coordinateWithString:end]);

    double latitudeDelta = (to.y - from.y) * rate;
    double longitudeDelta = (to.x - from.x) * rate;

    MAMapPoint newPoint = MAMapPointMake(from.x + longitudeDelta, from.y + latitudeDelta);

    CLLocationCoordinate2D coordinate = MACoordinateForMapPoint(newPoint);
    return [NSString stringWithFormat:@"%.6f,%.6f", coordinate.longitude, coordinate.latitude];
}


+ (double)calcDistanceBetweenCoor:(CLLocationCoordinate2D)coor1 andCoor:(CLLocationCoordinate2D)coor2 {
    MAMapPoint mapPointA = MAMapPointForCoordinate(coor1);
    MAMapPoint mapPointB = MAMapPointForCoordinate(coor2);

    return MAMetersBetweenMapPoints(mapPointA, mapPointB);
}

+ (CLLocationCoordinate2D)coordinateWithString:(NSString *)string {
    NSArray *coorArray = [string componentsSeparatedByString:@","];
    if (coorArray.count != 2) {
        return kCLLocationCoordinate2DInvalid;
    }
    return CLLocationCoordinate2DMake([coorArray[1] doubleValue], [coorArray[0] doubleValue]);
}

#pragma mark - Life Cycle

+ (instancetype)naviRouteForPath:(UnifiedDrivePath *)path withNaviType:(MANaviAnnotationType)type showTraffic:(BOOL)showTraffic startPoint:(AMapGeoPoint *)start endPoint:(AMapGeoPoint *)end {
    return [[self alloc] initWithPath:path withNaviType:type showTraffic:showTraffic startPoint:start endPoint:end];
}

- (instancetype)initWithPath:(UnifiedDrivePath *)path withNaviType:(MANaviAnnotationType)type showTraffic:(BOOL)showTraffic startPoint:(AMapGeoPoint *)start endPoint:(AMapGeoPoint *)end {
    self = [self init];

    if (self == nil) {
        return nil;
    }

    if (path == nil || path.steps.count == 0) {
        return self;
    }

    NSMutableArray *polylines = [NSMutableArray array];
    NSMutableArray *naviAnnotations = [NSMutableArray array];

    // 为drive类型且需要显示路况
    if (showTraffic && (type == MANaviAnnotationTypeDrive || type == MANaviAnnotationTypeTruck)) {
        NSArray *polylineColors = nil;
        MAPolyline *polyline = [MANaviRoute multiColoredPolylineWithDrivePath:path polylineColors:&polylineColors];
        if (polyline) {
            [polylines addObject:polyline];
            self.multiPolylineColors = polylineColors;
        }
    } else {
        [path.steps enumerateObjectsUsingBlock:^(UnifiedDriveStep *step, NSUInteger idx, BOOL *stop) {

            MAPolyline *stepPolyline = [MANaviRoute polylineForStep:step];

            if (stepPolyline != nil) {
                MANaviPolyline *naviPolyline = [[MANaviPolyline alloc] initWithPolyline:stepPolyline];
                naviPolyline.type = type;

                [polylines addObject:naviPolyline];

                if (idx > 0) {
                    MANaviAnnotation *annotation = [[MANaviAnnotation alloc] init];
                    annotation.coordinate = MACoordinateForMapPoint(stepPolyline.points[0]);
                    annotation.type = type;
                    annotation.title = step.instruction;
                    [naviAnnotations addObject:annotation];
                }

                if (idx > 0) {
                    // 填充step和step之间的空隙
                    [MANaviRoute replenishPolylinesForPathWith:stepPolyline
                                                  lastPolyline:[MANaviRoute polylineForStep:path.steps[idx - 1]]
                                                     Polylines:polylines];
                }
            }
        }];
    }

    self.routePolylines = polylines;
    self.naviAnnotations = naviAnnotations;

    return self;
}

- (id)init {
    self = [super init];
    if (self) {
        self.routeColor = [UIColor blueColor];
        self.walkingColor = [UIColor cyanColor];
        self.railwayColor = [UIColor greenColor];

        @[[UIColor greenColor], [UIColor greenColor], [UIColor yellowColor], [UIColor redColor]];
    }
    return self;
}

@end
