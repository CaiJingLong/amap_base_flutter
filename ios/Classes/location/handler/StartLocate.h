//
// Created by Yohom Bao on 2018-12-15.
//

#import <Foundation/Foundation.h>
#import "IMethodHandler.h"
#import "AMapLocationKit.h"


@interface StartLocate : NSObject <LocationMethodHandler, AMapLocationManagerDelegate, FlutterStreamHandler>
@end