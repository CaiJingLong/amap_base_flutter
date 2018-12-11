//
// Created by Yohom Bao on 2018-12-11.
//

#import <Foundation/Foundation.h>
#import "Flutter/Flutter.h"

@protocol SearchMethodHandler <NSObject>
@required
- (void)onMethodCall:(FlutterMethodCall *)call :(FlutterResult)result;
@end