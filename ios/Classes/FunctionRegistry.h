//
// Created by Yohom Bao on 2018-12-12.
//

#import <Foundation/Foundation.h>

@protocol MapMethodHandler;

@interface MapFunctionRegistry : NSObject
+ (NSDictionary<NSString *, NSObject <MapMethodHandler> *> *)mapMethodHandler;
@end


@protocol SearchMethodHandler;

@interface SearchFunctionRegistry : NSObject
+ (NSDictionary<NSString *, NSObject <SearchMethodHandler> *> *)searchMethodHandler;
@end