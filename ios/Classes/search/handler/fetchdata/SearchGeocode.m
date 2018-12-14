//
// Created by Yohom Bao on 2018-12-14.
//

#import "SearchGeocode.h"
#import "Misc.h"
#import "UnifiedGeocodeResult.h"
#import "MJExtension.h"


@implementation SearchGeocode {
    AMapSearchAPI *_search;
    FlutterResult _result;
}

- (instancetype)init {
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

    NSString *name = (NSString *) paramDic[@"name"];
    NSString *city = (NSString *) paramDic[@"city"];

    NSLog(@"search#searchGeocode ios端参数: name -> %@, city -> %@", name, city);

    AMapGeocodeSearchRequest *request = [[AMapGeocodeSearchRequest alloc] init];
    request.address = name;
    request.city = city;

    [_search AMapGeocodeSearch:request];
}

- (void)onGeocodeSearchDone:(AMapGeocodeSearchRequest *)request response:(AMapGeocodeSearchResponse *)response {
    if (response.geocodes.count == 0) {
        _result([FlutterError errorWithCode:@"搜索不到结果"
                                    message:@"搜索不到结果"
                                    details:nil]);
        return;
    }

    _result([[[UnifiedGeocodeResult alloc] initWithAMapGeocodeSearchResponse:response] mj_JSONString]);
}

/// 搜索失败回调
- (void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error {
    NSLog(@"搜索失败回调");
    _result([FlutterError errorWithCode:[NSString stringWithFormat:@"%d", error.code]
                                message:[Misc toAMapErrorDesc:error.code]
                                details:nil]);
}

@end