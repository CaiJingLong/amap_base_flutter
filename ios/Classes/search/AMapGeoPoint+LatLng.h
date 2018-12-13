//
// Created by Yohom Bao on 2018-12-03.
//

#import <Foundation/Foundation.h>
#import "AMapSearchAPI.h"

@class LatLng;

@interface AMapGeoPoint (LatLng)
-(LatLng*) toLatLng;
@end
