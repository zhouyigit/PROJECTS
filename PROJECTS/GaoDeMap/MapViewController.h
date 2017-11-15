//
//  MapViewController.h
//  PROJECTS
//
//  Created by yiyahanyu on 2017/10/11.
//  Copyright © 2017年 yiyahanyu. All rights reserved.
//

#import "BaseViewController.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchKit.h>

@interface MapViewController : BaseViewController<MAMapViewDelegate, AMapSearchDelegate>
{
    MAMapView *_mapView;
    UIButton *_locationBtn;//当前位置回到屏幕中心
//    CLLocationCoordinate2D _currentLocation;//当前位置
    AMapSearchAPI *_search;
}

@end
