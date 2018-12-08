//
// Created by Yohom Bao on 2018-12-03.
//

#import <Foundation/Foundation.h>
#import <AMapSearch/AMapSearchKit/AMapCommonObj.h>

@class LatLng;

@interface AMapGeoPoint (LatLng)
-(LatLng*) toLatLng;
@end