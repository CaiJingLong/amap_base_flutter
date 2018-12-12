//
//  MANaviRoute.h
//  OfficialDemo3D
//
//  Created by yi chen on 1/7/15.
//  Copyright (c) 2015 songjian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchAPI.h>
#import "MANaviAnnotation.h"
#import "MANaviPolyline.h"
#import "LineDashPolyline.h"

@class UnifiedDrivePath;

@interface MANaviRoute : NSObject

@property(nonatomic, strong) NSArray *routePolylines;
@property(nonatomic, strong) NSArray *naviAnnotations;

/// 普通路线颜色
@property(nonatomic, strong) UIColor *routeColor;
/// 步行路线颜色
@property(nonatomic, strong) UIColor *walkingColor;
/// 铁路路线颜色
@property(nonatomic, strong) UIColor *railwayColor;
/// 多彩线颜色
@property(nonatomic, strong) NSArray<UIColor *> *multiPolylineColors;

- (void)addToMapView:(MAMapView *)mapView;

+ (instancetype)naviRouteForPath:(UnifiedDrivePath *)path withNaviType:(MANaviAnnotationType)type showTraffic:(BOOL)showTraffic startPoint:(AMapGeoPoint *)start endPoint:(AMapGeoPoint *)end;

- (instancetype)initWithPath:(UnifiedDrivePath *)path withNaviType:(MANaviAnnotationType)type showTraffic:(BOOL)showTraffic startPoint:(AMapGeoPoint *)start endPoint:(AMapGeoPoint *)end;

@end
