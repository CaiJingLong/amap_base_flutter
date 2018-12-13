//
// Created by Yohom Bao on 2018-12-01.
//

#import <Foundation/Foundation.h>
#import "MAPointAnnotation.h"

@class UnifiedMarkerOptions;

@interface MarkerAnnotation : MAPointAnnotation
@property(nonatomic) UnifiedMarkerOptions *markerOptions;
@end