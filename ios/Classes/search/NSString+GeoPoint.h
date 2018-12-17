//
// Created by Yohom Bao on 2018-12-12.
//

#import <Foundation/Foundation.h>
@class AMapGeoPoint;

@interface NSString (GeoPoint)

-(NSArray<AMapGeoPoint *> *)stringToAMapGeoPoint;

@end