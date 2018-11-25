//
// Created by Yohom Bao on 2018/11/25.
//

#import "AMapViewFactory.h"
#import "MAMapView.h"


@implementation AMapViewFactory {
}

- (NSObject <FlutterPlatformView> *)createWithFrame:(CGRect)frame
                                     viewIdentifier:(int64_t)viewId
                                          arguments:(id _Nullable)args {
    return [[AMapView alloc] init];
}

@end

@implementation AMapView {
}

- (UIView *)view {
    return [[MAMapView alloc] init];
}

@end