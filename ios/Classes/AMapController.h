//
// Created by Yohom Bao on 2018/11/17.
//

#import <Foundation/Foundation.h>
#import <AMapNaviKit/AMapNaviKit.h>
#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <Flutter/Flutter.h>

// Defines events to be sent to Flutter.
@protocol FLTAMapDelegate
- (void)onCameraMoveStartedOnMap:(id)mapId gesture:(BOOL)gesture;
- (void)onCameraMoveOnMap:(id)mapId cameraPosition:(AMapNaviCameraInfo*)cameraPosition;
- (void)onCameraIdleOnMap:(id)mapId;
- (void)onMarkerTappedOnMap:(id)mapId marker:(NSString*)markerId;
- (void)onInfoWindowTappedOnMap:(id)mapId marker:(NSString*)markerId;
@end

// Defines map UI options writable from Flutter.
@protocol FLTMAMapOptionsSink
- (void)setCamera:(GMSCameraPosition*)camera;
- (void)setCameraTargetBounds:(GMSCoordinateBounds*)bounds;
- (void)setCompassEnabled:(BOOL)enabled;
- (void)setMapType:(MAMapViewType)type;
- (void)setMinZoom:(float)minZoom maxZoom:(float)maxZoom;
- (void)setRotateGesturesEnabled:(BOOL)enabled;
- (void)setScrollGesturesEnabled:(BOOL)enabled;
- (void)setTiltGesturesEnabled:(BOOL)enabled;
- (void)setTrackCameraPosition:(BOOL)enabled;
- (void)setZoomGesturesEnabled:(BOOL)enabled;
@end

// Defines map overlay controllable from Flutter.
@interface FLTMAMapController
        : NSObject<MAMapViewDelegate, FLTMAMapOptionsSink, FlutterPlatformView>
@property(atomic) id<FLTAMapDelegate> delegate;
@property(atomic, readonly) id mapId;
- (instancetype)initWithFrame:(CGRect)frame
               viewIdentifier:(int64_t)viewId
                    arguments:(id _Nullable)args
                    registrar:(NSObject<FlutterPluginRegistrar>*)registrar;
- (void)addToView:(UIView*)view;
- (void)removeFromView;
- (void)showAtX:(CGFloat)x Y:(CGFloat)y;
- (void)hide;
- (void)animateWithCameraUpdate:(GMSCameraUpdate*)cameraUpdate;
- (void)moveWithCameraUpdate:(GMSCameraUpdate*)cameraUpdate;
- (GMSCameraPosition*)cameraPosition;
- (NSString*)addMarkerWithPosition:(CLLocationCoordinate2D)position;
- (FLTMAMapMarkerController*)markerWithId:(NSString*)markerId;
- (void)removeMarkerWithId:(NSString*)markerId;
@end

// Allows the engine to create new MA Map instances.
@interface FLTMAMapFactory : NSObject<FlutterPlatformViewFactory>
- (instancetype)initWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar;
@end
