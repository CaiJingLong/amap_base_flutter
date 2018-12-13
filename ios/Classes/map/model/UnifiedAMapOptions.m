//
// Created by Yohom Bao on 2018/11/26.
//

#import "UnifiedAMapOptions.h"

@implementation UnifiedAMapOptions {
}

- (NSString *)description {
    NSMutableString *description = [NSMutableString string];
    [description appendFormat:@"self.logoPosition=%i", self.logoPosition];
    [description appendFormat:@", self.zOrderOnTop=%d", self.zOrderOnTop];
    [description appendFormat:@", self.mapType=%i", self.mapType];
    [description appendFormat:@", self.camera=%@", self.camera];
    [description appendFormat:@", self.scaleControlsEnabled=%d", self.scaleControlsEnabled];
    [description appendFormat:@", self.zoomControlsEnabled=%d", self.zoomControlsEnabled];
    [description appendFormat:@", self.compassEnabled=%d", self.compassEnabled];
    [description appendFormat:@", self.scrollGesturesEnabled=%d", self.scrollGesturesEnabled];
    [description appendFormat:@", self.zoomGesturesEnabled=%d", self.zoomGesturesEnabled];
    [description appendFormat:@", self.tiltGesturesEnabled=%d", self.tiltGesturesEnabled];
    [description appendFormat:@", self.rotateGesturesEnabled=%d", self.rotateGesturesEnabled];

    NSMutableString *superDescription = [[super description] mutableCopy];
    NSUInteger length = [superDescription length];

    if (length > 0 && [superDescription characterAtIndex:length - 1] == '>') {
        [superDescription insertString:@", " atIndex:length - 1];
        [superDescription insertString:description atIndex:length + 1];
        return superDescription;
    } else {
        return [NSString stringWithFormat:@"<%@: %@>", NSStringFromClass([self class]), description];
    }
}

@end

@implementation CameraPosition {
}

- (NSString *)description {
    NSMutableString *description = [NSMutableString string];
    [description appendFormat:@"self.target=%@", self.target];
    [description appendFormat:@", self.zoom=%f", self.zoom];
    [description appendFormat:@", self.tilt=%f", self.tilt];
    [description appendFormat:@", self.bearing=%f", self.bearing];

    NSMutableString *superDescription = [[super description] mutableCopy];
    NSUInteger length = [superDescription length];

    if (length > 0 && [superDescription characterAtIndex:length - 1] == '>') {
        [superDescription insertString:@", " atIndex:length - 1];
        [superDescription insertString:description atIndex:length + 1];
        return superDescription;
    } else {
        return [NSString stringWithFormat:@"<%@: %@>", NSStringFromClass([self class]), description];
    }
}

@end

@implementation LatLng {
}

- (CLLocationCoordinate2D)toCLLocationCoordinate2D {
    return CLLocationCoordinate2DMake(self.latitude, self.longitude);
}

- (NSString *)description {
    NSMutableString *description = [NSMutableString string];
    [description appendFormat:@"self.latitude=%f", self.latitude];
    [description appendFormat:@", self.longitude=%f", self.longitude];

    NSMutableString *superDescription = [[super description] mutableCopy];
    NSUInteger length = [superDescription length];

    if (length > 0 && [superDescription characterAtIndex:length - 1] == '>') {
        [superDescription insertString:@", " atIndex:length - 1];
        [superDescription insertString:description atIndex:length + 1];
        return superDescription;
    } else {
        return [NSString stringWithFormat:@"<%@: %@>", NSStringFromClass([self class]), description];
    }
}

@end
