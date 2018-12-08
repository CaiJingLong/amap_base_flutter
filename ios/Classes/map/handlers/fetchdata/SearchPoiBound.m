//
// Created by Yohom Bao on 2018-12-07.
//

#import "SearchPoiBound.h"
#import "JSONModelError.h"
#import "UnifiedPoiSearchQuery.h"
#import "UnifiedPoiResult.h"
#import "Misc.h"


@implementation SearchPoiBound {
    AMapSearchAPI *_search;
    FlutterResult _result;
}
- (NSObject <MapMethodHandler> *)initWith:(MAMapView *)mapView {
    self = [super init];
    if (self) {
        // 搜索api回调设置
        _search = [[AMapSearchAPI alloc] init];
        _search.delegate = self;
    }

    return self;
}

- (void)onMethodCall:(FlutterMethodCall *)call :(FlutterResult)result {
    _result = result;

    NSDictionary *paramDic = call.arguments;

    NSString *query = (NSString *) paramDic[@"query"];

    NSLog(@"方法map#searchPoiBound ios端参数: query -> %@", query);

    JSONModelError *error;
    UnifiedPoiSearchQuery *request = [[UnifiedPoiSearchQuery alloc] initWithString:query error:&error];
    [Misc handlerArgumentError:error result:result];

    [_search AMapPOIAroundSearch:[request toAMapPOIAroundSearchRequest]];
}

/// poi搜索回调
- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response {
    NSLog(@"poi搜索回调");
    _result([[[UnifiedPoiResult alloc] initWithPoiResult:response] toJSONString]);
}

/// 搜索失败回调
- (void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error {
    NSLog(@"搜索失败回调");
    _result([FlutterError errorWithCode:[NSString stringWithFormat:@"%d", error.code]
                                message:error.domain
                                details:nil]);}
@end