//
//  NSObject+NSObject_Tools.h
//  amap_base
//
//  Created by Caijinglong on 2018/12/6.
//

#import <Foundation/Foundation.h>
#import <Flutter/Flutter.h>
#import "AMapBasePlugin.h"
#import "AMapFoundationKit.h"

@interface NSObject (NSObject_Tools) <FlutterPluginRegistrar>

- (void)setupToolsChannel;

@end
