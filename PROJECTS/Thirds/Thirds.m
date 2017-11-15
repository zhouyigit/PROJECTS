//
//  Thirds.m
//  PROJECTS
//
//

#import "Thirds.h"

@implementation Thirds

+ (instancetype)shareInstance {

    static Thirds *_share = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _share = [[[self class] alloc] init];
    });
    return _share;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self dbConfig];//数据库
    [self jpushConfigWithOption:launchOptions];//极光推送
    [self umengConfig];//友盟统计
    [self buglyConfig];//腾讯bugly
    [self gaodeConfig];//高德地图
    
    return YES;
}

-(void)gaodeConfig
{
    [[AMapServices sharedServices] setEnableHTTPS:YES];//在配置高德 Key 前
    [AMapServices sharedServices].apiKey = @"af946954060afcf17d86aa8312dcaded";
}

-(void)buglyConfig {
    [Bugly startWithAppId:@"48029c3de0"];
}

-(void)umengConfig {
    
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [MobClick setAppVersion:version];
    
    UMConfigInstance.appKey = @"59b89e00e88bad5b8100000e";
    UMConfigInstance.channelId = @"App Store";
    UMConfigInstance.bCrashReportEnabled = NO;
    [MobClick startWithConfigure:UMConfigInstance];//配置以上参数后调用此方法初始化SDK！
    
//    [MobClick setLogEnabled:YES];
}

-(void)dbConfig {
    DBConfigLogic *dbConfigLogic = [[DBConfigLogic alloc] init];
    //    dbConfigLogic.allowDowngrade = YES; //是否允许数据库降级，默认不允许。
    BOOL checkResult = [dbConfigLogic checkDatabase:LOCAL_MAIN_DB_PATH newVersion:dbConfigLogic.dbVersion];
    if (!checkResult) {
        
        UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:@"数据库初始化失败，不能继续加载，请彻底关闭程序后再次尝试。"
                                                           delegate:nil
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil, nil];
        [alertview show];
        
    } else {
        NSLog(@"check db success.");
        NSLog(@"\n******** [App Path] *******\n%@\n***************************", NSHomeDirectory());
    }
}

-(void)jpushConfigWithOption:(NSDictionary *)launchOptions {
    //初始化APNs代码
    //Required
    //notice: 3.0.0及以后版本注册可以这样写，也可以继续用之前的注册方式
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 可以添加自定义categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    
    //初始化JPush代码
    // Optional
    // 获取IDFA
    // 如需使用IDFA功能请添加此代码并在初始化方法的advertisingIdentifier参数中填写对应值
    NSString *advertisingId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    
    // Required
    // init Push
    // notice: 2.1.5版本的SDK新增的注册方法，改成可上报IDFA，如果没有使用IDFA直接传nil
    // 如需继续使用pushConfig.plist文件声明appKey等配置内容，请依旧使用[JPUSHService setupWithOption:launchOptions]方式初始化。
    int isProduction = 0;
#ifndef DEBUG
    isProduction = 1;
#endif
    [JPUSHService setupWithOption:launchOptions
                           appKey:@"f24138bc65438a93ea2a5005"
                          channel:@"App Store"
                 apsForProduction:isProduction
            advertisingIdentifier:advertisingId];
    
    [JPUSHService setLogOFF];
}

- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
    
    //1.app faceground,收到通知，进入了
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler();  // 系统要求执行这个方法
    
    //1.app background,点击通知，进入了
    //2.app background,有通知但不点击，不进入
    //3.app faceground,收到通知，不进入
    //4.app faceground,收到通知并点击，进入了
    //5.app carshed,点击通知，进入了
    //6.app carshed,有通知但不点击，不进入
    //总结：点通知才进入该方法
    
}



- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    // Required, iOS 7 Support
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    // Required,For systems with less than or equal to iOS6
    [JPUSHService handleRemoteNotification:userInfo];
}
@end
