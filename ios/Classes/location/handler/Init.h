//
// Created by Yohom Bao on 2018-12-15.
//

#import <Foundation/Foundation.h>
#import "IMethodHandler.h"

@class AMapLocationManager;


@interface Init : NSObject <LocationMethodHandler>

+ (AMapLocationManager*) locationManager;

@end