//
//  MapCentre.m
//  SnookerMate
//
//  Created by Ryan Bibby and Mark Dessain on 22/01/2012.
//

#import "MapCentre.h"

@implementation UIViewController (MapCentre)

// Find the min and max location of all the pins 
- (void)recenterMap:(MKMapView *)mapView {
    
    NSArray *coordinates = [mapView valueForKeyPath:@"annotations.coordinate"];
    
    if([coordinates count] > 0) {
        
        CLLocationCoordinate2D maxCoord = {-90.0f, -180.0f};
        CLLocationCoordinate2D minCoord = {90.0f, 180.0f};
        
        for(NSValue *value in coordinates) {
            CLLocationCoordinate2D coord = {0.0f, 0.0f};
            [value getValue:&coord];
            
            if(coord.longitude > maxCoord.longitude) {
                maxCoord.longitude = coord.longitude;
            }
            
            if(coord.latitude > maxCoord.latitude) {
                maxCoord.latitude = coord.latitude;
            }
            
            if(coord.longitude < minCoord.longitude) {
                minCoord.longitude = coord.longitude;
            }
            
            if(coord.latitude < minCoord.latitude) {
                minCoord.latitude = coord.latitude;
            }
        }
        
        MKCoordinateRegion region = {{0.0f, 0.0f}, {0.0f, 0.0f}};
        
        // Then zoom out slightly to include all
        
        region.center.longitude = (minCoord.longitude + maxCoord.longitude) / 2.0;
        region.center.latitude = (minCoord.latitude + maxCoord.latitude) / 2.0;
        region.span.longitudeDelta = maxCoord.longitude - minCoord.longitude + 2;
        region.span.latitudeDelta = maxCoord.latitude - minCoord.latitude + 2;
        [mapView setRegion:region animated:YES];  
        
    }
}
@end
