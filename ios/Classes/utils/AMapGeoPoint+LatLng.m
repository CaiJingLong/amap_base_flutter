//
// Created by Yohom Bao on 2018-12-03.
//

#import "AMapGeoPoint+LatLng.h"
#import "UnifiedAMapOptions.h"


@implementation AMapGeoPoint (LatLng)

- (LatLng *)toLatLng {
    LatLng *result = [[LatLng alloc] init];
    result.latitude = self.latitude;
    result.longitude = self.longitude;
    return result;
}

@end