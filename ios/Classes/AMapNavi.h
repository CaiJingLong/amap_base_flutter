//
// Created by Yohom Bao on 2018/11/25.
//

#import <Foundation/Foundation.h>
#import <Flutter/Flutter.h>
#import "AmapBasePlugin.h"


@interface NSObject (AMapNavi) <FlutterPluginRegistrar>

/**
 * 设置导航channel
 */
- (void) setupNaviChannel;

@end