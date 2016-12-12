//
//  GetDirection.m
//  IM-HERE
//
//  Created by i mac meridian on 12/10/16.
//  Copyright © 2016 dhruv patel. All rights reserved.
//

#import "GetDirection.h"
#import <GoogleMaps/GoogleMaps.h>
#import "MDDirectionService.h"
@interface GetDirection ()<GMSMapViewDelegate>{
    GMSMapView *mapView_;
    NSMutableArray *waypoints_;
    NSMutableArray *waypointStrings_;
}


@end

@implementation GetDirection

- (void)viewDidLoad {
    [super viewDidLoad];
     [GMSServices provideAPIKey:@"AIzaSyAtWwoW85HqgagmSXDh3H3SRB3ZByXXSbo"];
    waypoints_ = [[NSMutableArray alloc]init];
    waypointStrings_ = [[NSMutableArray alloc]init];
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:19.770053
                                                            longitude:79.832880
                                                                 zoom:4];
    mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView_.delegate = self;
    self.view = mapView_;
    CLLocationCoordinate2D Ahmedabad = CLLocationCoordinate2DMake(23.0225713, 72.571322);
    CLLocationCoordinate2D Surat = CLLocationCoordinate2DMake(21.1702535, 72.83118469999999);
    
    
    GMSMarker *marker2 = [GMSMarker markerWithPosition:Surat];
    
    GMSMarker *marker1 = [GMSMarker markerWithPosition:Ahmedabad];
     marker1.title = @"Abad";
    marker2.title = @"Surat";
    marker1.map = mapView_;
    [waypoints_ addObject:marker1];
    marker2.map = mapView_;
    [waypoints_ addObject:marker2];
    NSString *sensor = @"false";
    
    NSString *positionString1 = [[NSString alloc] initWithFormat:@"%f,%f",
                                23.0225713,72.571322];
    NSString *positionString2 = [[NSString alloc] initWithFormat:@"%f,%f",
                                 21.1702535,72.83118469999999];
    
    [waypointStrings_ addObject:positionString1];
    [waypointStrings_ addObject:positionString2];
    
    NSArray *parameters = [NSArray arrayWithObjects:sensor, waypointStrings_,
                           nil];
    NSArray *keys = [NSArray arrayWithObjects:@"sensor", @"waypoints", nil];
    NSDictionary *query = [NSDictionary dictionaryWithObjects:parameters
                                                      forKeys:keys];
    MDDirectionService *mds=[[MDDirectionService alloc] init];
    SEL selector = @selector(addDirections:);
    [mds setDirectionsQuery:query
               withSelector:selector
               withDelegate:self];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void)mapView:(GMSMapView *)mapView didTapAtCoordinate:
//(CLLocationCoordinate2D)coordinate {
//    
//    CLLocationCoordinate2D position = CLLocationCoordinate2DMake(
//                                                                 coordinate.latitude,
//                                                                 coordinate.longitude);
//    GMSMarker *marker = [GMSMarker markerWithPosition:position];
//    marker.map = mapView_;
//    [waypoints_ addObject:marker];
//    NSString *positionString = [[NSString alloc] initWithFormat:@"%f,%f",
//                                coordinate.latitude,coordinate.longitude];
//    [waypointStrings_ addObject:positionString];
//    if([waypoints_ count]>1){
//        NSString *sensor = @"false";
//        NSArray *parameters = [NSArray arrayWithObjects:sensor, waypointStrings_,
//                               nil];
//        NSArray *keys = [NSArray arrayWithObjects:@"sensor", @"waypoints", nil];
//        NSDictionary *query = [NSDictionary dictionaryWithObjects:parameters
//                                                          forKeys:keys];
//        MDDirectionService *mds=[[MDDirectionService alloc] init];
//        SEL selector = @selector(addDirections:);
//        [mds setDirectionsQuery:query
//                   withSelector:selector
//                   withDelegate:self];
//    }
//}
- (void)addDirections:(NSDictionary *)json {
    
    NSDictionary *routes = [json objectForKey:@"routes"][0];
    
    NSDictionary *route = [routes objectForKey:@"overview_polyline"];
    NSString *overview_route = [route objectForKey:@"points"];
    GMSPath *path = [GMSPath pathFromEncodedPath:overview_route];
    GMSPolyline *polyline = [GMSPolyline polylineWithPath:path];
    polyline.map = mapView_;
}

@end
