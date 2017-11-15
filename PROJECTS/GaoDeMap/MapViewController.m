//
//  MapViewController.m
//  PROJECTS
//
//  Created by yiyahanyu on 2017/10/11.
//  Copyright © 2017年 yiyahanyu. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //初始化地图
    _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT-49)];
    _mapView.showsIndoorMap = YES;
    _mapView.delegate = self;
    _mapView.zoomLevel = 16;
    //把地图添加至view
    [self.view addSubview:_mapView];
    
    //进入地图就显示定位小蓝点
    _mapView.showsUserLocation = YES;
    _mapView.userTrackingMode = MAUserTrackingModeFollow;
    
    MAUserLocationRepresentation *r = [[MAUserLocationRepresentation alloc] init];
    [_mapView updateUserLocationRepresentation:r];
    
    //回到我的当前位置
    _locationBtn = [[UIButton alloc] init];
    [_locationBtn setTitle:@"当前位置" forState:UIControlStateNormal];
    [_locationBtn setBackgroundImage:[UIImage imageWithHexColor:0xfff000] forState:UIControlStateNormal];
    [self.view addSubview:_locationBtn];
    [_locationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.offset(40);
        make.left.offset(5);
        make.bottom.offset(-20-49);
    }];
    [_locationBtn addTarget:self action:@selector(locationBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    //POI搜索
    _search = [[AMapSearchAPI alloc] init];
    _search.delegate = self;
    
    AMapPOIKeywordsSearchRequest *request = [[AMapPOIKeywordsSearchRequest alloc] init];
    
//    request.keywords            = @"北京大学";
    request.city                = @"北京";
//    request.types               = @"高等院校";
    request.keywords = @"新华科技大厦";
    request.requireExtension    = YES;
    
    /*  搜索SDK 3.2.0 中新增加的功能，只搜索本城市的POI。*/
    request.cityLimit           = YES;
    request.requireSubPOIs      = YES;
    
    [_search AMapPOIKeywordsSearch:request];
}

/* POI 搜索回调. */
- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response
{
    if (response.pois.count == 0)
    {
        return;
    }
    
    //解析response获取POI信息，具体解析见 Demo
    [response.pois enumerateObjectsUsingBlock:^(AMapPOI *obj, NSUInteger idx, BOOL *stop) {
        
        NSLog(@"%@", [obj mj_JSONString]);
        
        MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
        pointAnnotation.coordinate = CLLocationCoordinate2DMake(obj.location.latitude, obj.location.longitude);
        pointAnnotation.title = obj.name;
        pointAnnotation.subtitle = [NSString stringWithFormat:@"(%f, %f)", obj.location.latitude, obj.location.longitude];
        [_mapView addAnnotation:pointAnnotation];
    }];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
//    MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
//    pointAnnotation.coordinate = CLLocationCoordinate2DMake(39.963000, 116.502800);
//    pointAnnotation.title = @"新华科技大厦";
//    pointAnnotation.subtitle = @"驼房营南路";
//    [_mapView addAnnotation:pointAnnotation];
}

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation
{
    BOOL isCurrent = NO;
    if (mapView.userLocation.coordinate.latitude == annotation.coordinate.latitude && mapView.userLocation.coordinate.latitude == annotation.coordinate.longitude) {
        isCurrent = YES;
    }
    if (!isCurrent && [annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *pointReuseIndentifier = @"pointReuseIndentifier";
        MAPinAnnotationView*annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndentifier];
        if (annotationView == nil)
        {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndentifier];
        }
        annotationView.canShowCallout= YES;       //设置气泡可以弹出，默认为NO
        annotationView.animatesDrop = YES;        //设置标注动画显示，默认为NO
        annotationView.draggable = YES;        //设置标注可以拖动，默认为NO
        annotationView.pinColor = MAPinAnnotationColorPurple;
        return annotationView;
    }
    return nil;
}

-(void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view
{
    NSLog(@"didSelectAnnotationView");
}

-(void)mapView:(MAMapView *)mapView didDeselectAnnotationView:(MAAnnotationView *)view
{
    NSLog(@"didDeselectAnnotationView");
}

-(void)locationBtnAction
{
//    _mapView.region.center
    NSLog(@"%@", [NSString stringWithFormat:@"当前位置(%f, %f)", _mapView.userLocation.coordinate.latitude, _mapView.userLocation.coordinate.longitude]);
    [_mapView setCenterCoordinate:_mapView.userLocation.coordinate animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
