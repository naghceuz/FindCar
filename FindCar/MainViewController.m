//
//  MainViewController.m
//  FindCar
//
//  Created by Owen on 3/22/14.
//  Copyright (c) 2014 OwenAlex. All rights reserved.
//

#import "MainViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface MainViewController () <CLLocationManagerDelegate, MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic, strong) CLLocationManager *locationManager;

@end


//#define METERS_PER_MILE 1609.344

@implementation MainViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    //用了这个function , 小蓝点就会显示
    [self.mapView setShowsUserLocation:YES];
    
    // Do any additional setup after loading the view.
    // 建立locationManger variable, 并且initial 它
    [self setLocationManager:[[CLLocationManager alloc] init]];
    
    // locationManager 一定要指向一个delegate. 这里因为它作用于 MainViewConrtoller， 所以call itself
	[_locationManager setDelegate:self];
    
    // 这里我选择用最优化的accuracy
    // 其实可以选 ： kCLLocationAccuracyBest   或者  kCLLocationAccuracyNearestTenMeters
    // 当然越精准会越耗电，所以要慎重.
	[_locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
   
    //这个function可能有用，逻辑还没想太清楚
    //[_locationManager setDistanceFilter:kCLDistanceFilterNone];
    
    // 开始启动这个location manager
	[_locationManager startUpdatingLocation];
}


// 这个非常重要，是版本0.1实现的关键，它是： a delegate method to get the current location
//
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
	// Every time the LocationManager updates the location, it sends this message to its delegate, giving it the updated locations. The locations array contains all locations in chronological order, so the newest location is the last object in the array. That’s what you need and what the first line is taking from the array.
	CLLocation *lastLocation = [locations lastObject];

    
    
	// This line gets the horizontal accuracy and logs it to the console. This value is a radius around the current location. If you have a value of 50, it means that the real location can be in a circle with a radius of 50 meters around the position stored in lastLocation.

	CLLocationAccuracy accuracy = [lastLocation horizontalAccuracy];
	NSLog(@"Received location %@ with accuracy %f", lastLocation, accuracy);
    
	// The if statement checks if the accuracy is high enough for your purposes. I chose a value of 100 meters. It is good enough for this example and you don’t have to wait too long to achieve this accuracy. In a real app, you would probably want an accuracy of 10 meters or less, but in this case it could take a few minutes to achieve that accuracy (GPS tracking takes time).
	if(accuracy < 100.0) {
		//The first three lines zoom the MapView to the location.
        //After that, you stop updating the location to save battery life.
		MKCoordinateSpan span = MKCoordinateSpanMake(0.14, 0.14);
		MKCoordinateRegion region = MKCoordinateRegionMake([lastLocation coordinate], span);
        
		[_mapView setRegion:region animated:YES];
        
		// More code here
        
		[manager stopUpdatingLocation];
	}
}


//- (void)viewWillAppear:(BOOL)animated {
//    // 1. 找到你要zoom in 的地方
//    // 这里我们选择的坐标是波士顿大学
//    // 坐标数据来源: distanceform
//    CLLocationCoordinate2D zoomLocation;
//    zoomLocation.latitude =  42.3525973;
//    zoomLocation.longitude= -71.1106078;
//
//    // 2. 你不能只告诉经纬度, 你要具体点，
//    // 这里会围绕所给的坐标选取一个范围，这里我们选取的是0.5 mile
//    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 0.3*METERS_PER_MILE, 0.3*METERS_PER_MILE);
//
//    // 3 告诉mapView 去实现
//    [_mapView setRegion:viewRegion animated:YES];
//}







- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
