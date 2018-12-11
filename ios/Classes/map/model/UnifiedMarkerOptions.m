//
// Created by Yohom Bao on 2018-12-01.
//

#import "UnifiedMarkerOptions.h"
#import "UnifiedAMapOptions.h"

@implementation UnifiedMarkerOptions {

}
- (NSString *)description {
    NSMutableString *description = [NSMutableString stringWithFormat:@"<%@: ", NSStringFromClass([self class])];
    [description appendFormat:@"self.icon=%p", self.icon];
    [description appendFormat:@", self.anchorU=%f", self.anchorU];
    [description appendFormat:@", self.anchorV=%f", self.anchorV];
    [description appendFormat:@", self.draggable=%d", self.draggable];
    [description appendFormat:@", self.infoWindowEnable=%d", self.infoWindowEnable];
    [description appendFormat:@", self.position=%@", self.position];
    [description appendFormat:@", self.infoWindowOffsetX=%i", self.infoWindowOffsetX];
    [description appendFormat:@", self.infoWindowOffsetY=%i", self.infoWindowOffsetY];
    [description appendFormat:@", self.snippet=%p", self.snippet];
    [description appendFormat:@", self.title=%p", self.title];
    [description appendFormat:@", self.zIndex=%f", self.zIndex];
    [description appendFormat:@", self.lockedToScreen=%d", self.lockedToScreen];
    [description appendFormat:@", self.lockedScreenPoint=%@", self.lockedScreenPoint];
    [description appendFormat:@", self.customCalloutView=%@", self.customCalloutView];
    [description appendFormat:@", self.enabled=%d", self.enabled];
    [description appendFormat:@", self.highlighted=%d", self.highlighted];
    [description appendFormat:@", self.selected=%d", self.selected];
    [description appendFormat:@", self.leftCalloutAccessoryView=%@", self.leftCalloutAccessoryView];
    [description appendFormat:@", self.rightCalloutAccessoryView=%@", self.rightCalloutAccessoryView];
    [description appendString:@">"];
    return description;
}

@end
