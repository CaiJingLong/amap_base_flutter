//
// Created by Yohom Bao on 2018-12-08.
//

#import <Foundation/Foundation.h>

@protocol MapMethodHandler;

@interface MapFunctionRegistry : NSObject
+ (NSDictionary<NSString *, NSObject <MapMethodHandler> *> *)mapMethodHandler;
@end