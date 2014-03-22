//
//  MainViewController.m
//  FindCar
//
//  Created by Owen on 3/22/14.
//  Copyright (c) 2014 OwenAlex. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end


#define METERS_PER_MILE 1609.344

@implementation MainViewController



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    // 1. 找到你要zoom in 的地方
    // 这里我们选择的坐标是波士顿大学
    // 坐标数据来源: distanceform
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude =  42.3525973;
    zoomLocation.longitude= -71.1106078;
    
    // 2. 你不能只告诉经纬度, 你要具体点，
    // 这里会围绕所给的坐标选取一个范围，这里我们选取的是0.5 mile
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 0.3*METERS_PER_MILE, 0.3*METERS_PER_MILE);
    
    // 3 告诉mapView 去实现
    [_mapView setRegion:viewRegion animated:YES];
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

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
