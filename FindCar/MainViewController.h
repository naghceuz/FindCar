//
//  MainViewController.h
//  FindCar
//
//  Created by Owen on 3/22/14.
//  Copyright (c) 2014 OwenAlex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MainViewController : UIViewController <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;


@end
