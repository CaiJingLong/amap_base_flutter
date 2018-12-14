//
// Created by Yohom Bao on 2018-12-10.
//

#import "UnifiedPolylineOptions.h"
#import "MJExtension.h"


@implementation UnifiedPolylineOptions {

}
+ (instancetype)initWithJson:(NSString *)json {
    [UnifiedPolylineOptions mj_setupObjectClassInArray:^NSDictionary *{
        return @{
                @"latLngList" : @"LatLng",
        };
    }];
    return [UnifiedPolylineOptions mj_objectWithKeyValues:json];
}

@end