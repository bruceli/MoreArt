//
//  MaAppDelegate.m
//  MoreMusic
//
//  Created by Accthun He on 5/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MoreArtAppDelegate.h"
#import "MaRootViewController.h"
#import "MaDefine.h"
 
@implementation MoreArtAppDelegate

@synthesize window = _window;
@synthesize douWoView = _douWoView;
@synthesize douSpaceView = _douSpaceView;
@synthesize art029View = _art029View;
@synthesize douPeikingView = _douPeikingView;
@synthesize moLangPhotoView = _moLangPhotoView;
@synthesize aboutView = _aboutView;
@synthesize coverFlowView = _coverFlowView;
@synthesize dataSourceMgr = _dataSourceMgr;

@synthesize crossFadeView = _crossFadeView;

@synthesize baseViewController = _baseViewController;
@synthesize revealSideViewController = _revealSideViewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
     
    _dataSourceMgr = [[MaDataSource alloc] init];

    _baseViewController = [[MaBaseViewController alloc] init];
    UINavigationController* theController = [[UINavigationController alloc] initWithRootViewController:_baseViewController];
    UINavigationBar* navBar = theController.navigationBar;
    [navBar setBackgroundImage:[UIImage imageNamed: @"BarBackground"] forBarMetrics:UIBarMetricsDefault];

    CGRect frame = _baseViewController.view.frame;
    _douWoView = [[MaDouWoView alloc] initWithFrame:frame];
    _douSpaceView = [[MaDouSpaceView alloc] initWithFrame:frame];
    _art029View = [[MaArt029View alloc] initWithFrame:frame];
    _douPeikingView =  [[MaDouPeKingBaseView alloc] initWithFrame:frame];
    _moLangPhotoView =  [[MaMoLangPhotoView alloc] initWithFrame:frame];
    _aboutView =  [[MaAboutView alloc] initWithFrame:frame];
    _coverFlowView = [[MaCoverFlowView alloc] initWithFrame:frame];
    _crossFadeView = [[MaCrossFadeView alloc] initWithFrame:frame];

    _baseViewController.view = _douWoView;
    
    _douWoView.delegate = _baseViewController;
//    _douSpaceView.delegate = _baseViewController;
    _art029View.delegate = _baseViewController ;
    _douPeikingView.delegate = _baseViewController ;
    _moLangPhotoView.delegate = _baseViewController;
    _douWoView.dataSource = _baseViewController;
//    _douSpaceView.dataSource = _baseViewController;
    _art029View.dataSource = _baseViewController ;
    _douPeikingView.dataSource = _baseViewController ;
    _moLangPhotoView.dataSource = _baseViewController;
    
 //   [_coverFlowView loadCoverflowView];
    

    _revealSideViewController = [[PPRevealSideViewController alloc] initWithRootViewController:theController ];
    _revealSideViewController.delegate = self;

    
    MaSettingViewController *slideView= [[MaSettingViewController alloc] init];
    [_revealSideViewController preloadViewController:slideView
                                                 forSide:PPRevealSideDirectionLeft
                                              withOffset:SETTINGVIEW_OFFSET];

    self.window.rootViewController = _revealSideViewController;
    
//    MoreArtAppDelegate* app = (MoreArtAppDelegate *)[[UIApplication sharedApplication] delegate];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque animated:YES];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
}
*/

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
{
}
*/

@end
