//
// Created by Yohom Bao on 2018-12-01.
//

#import "UnifiedAssets.h"
#import "AMapBasePlugin.h"

static const NSString *PACKAGE = @"packages/amap_base/";

@implementation UnifiedAssets {

}
+ (NSString *)getAssetPath:(NSString *)asset {
    NSString *key = [AMapBasePlugin.registrar lookupKeyForAsset:[NSString stringWithFormat:@"%@%@", PACKAGE, asset]];
    return [[NSBundle mainBundle] pathForResource:key ofType:nil];
}

@end