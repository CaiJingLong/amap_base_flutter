//
// Created by Yohom Bao on 2018-12-10.
//

#import <AMap3DMap/MAMapKit/MAOfflineMapViewController.h>
#import "OpenOfflineManager.h"

@implementation OpenOfflineManager {

}
- (NSObject <MapMethodHandler> *)initWith:(MAMapView *)mapView {
    return self;
}

- (void)onMethodCall:(FlutterMethodCall *)call :(FlutterResult)result {
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:[MAOfflineMapViewController sharedInstance]
                                                                                 animated:YES
                                                                               completion:nil];
}

@end
