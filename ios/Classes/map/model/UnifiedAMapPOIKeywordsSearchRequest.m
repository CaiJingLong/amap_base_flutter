//
// Created by Yohom Bao on 2018-12-03.
//

#import <AMapSearch/AMapSearchKit/AMapSearchObj.h>
#import "UnifiedAMapPOIKeywordsSearchRequest.h"
#import "UnifiedAMapOptions.h"


@implementation UnifiedAMapPOIKeywordsSearchRequest {

}
- (AMapPOIKeywordsSearchRequest *)toAMapPOIKeywordsSearchRequest {
    AMapPOIKeywordsSearchRequest* request = [[AMapPOIKeywordsSearchRequest alloc] init];
    request.types = self.category;
    if (self.distanceSort) {
        request.sortrule = 0;
    } else {
        request.sortrule = 1;
    }
    request.offset = self.pageSize;
    request.page = self.pageNum;
    request.building = self.building;
    request.requireExtension = self.requireExtension;
    request.requireSubPOIs = self.requireSubPois;
    request.keywords = self.query;
    request.city = self.city;
    request.cityLimit = self.cityLimit;
    request.location = [self.location toAMapGeoPoint];
    return request;
}

@end