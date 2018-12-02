//
// Created by Yohom Bao on 2018-11-29.
//

#import "RoutePlanParam.h"
#import "UnifiedAMapOptions.h"


@implementation RoutePlanParam {

}

- (NSString *)description {
    NSMutableString *description = [NSMutableString stringWithFormat:@"<%@: ", NSStringFromClass([self class])];
    [description appendFormat:@"self.from=%@", self.from];
    [description appendFormat:@", self.to=%@", self.to];
    [description appendFormat:@", self.mode=%i", self.mode];
    [description appendFormat:@", self.passedByPoints=%@", self.passedByPoints];
    [description appendFormat:@", self.avoidPolygons=%@", self.avoidPolygons];
    [description appendFormat:@", self.avoidRoad=%p", self.avoidRoad];
    [description appendString:@">"];
    return description;
}

@end