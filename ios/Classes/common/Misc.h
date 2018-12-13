//
//  Misc.h
//  SearchV3Demo
//
//  Created by songjian on 13-8-22.
//  Copyright (c) 2013年 songjian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchAPI.h>
#import "Flutter/Flutter.h"

@class JSONModelError;

@interface Misc : NSObject


+(NSString* ) toAMapErrorDesc:(NSInteger) errorCode;

@end
