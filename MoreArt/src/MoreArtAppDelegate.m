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
@synthesize scheduleViewController = _scheduleViewController;
@synthesize artistViewController = _artistViewController;
@synthesize reviewViewController = _reviewViewController;
@synthesize welcomeViewController = _welcomeViewController;
@synthesize revealSideViewController = _revealSideViewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    _tabBarController = [[UITabBarController alloc] init];
    
    UITabBar *tabBar = [_tabBarController tabBar];
    [tabBar setBackgroundImage:[UIImage imageNamed:@"tabBarBackground"]];
    
    _scheduleViewController = [[MaScheduleViewController alloc] init];
    UINavigationController* schViewController = [[UINavigationController alloc] initWithRootViewController:_scheduleViewController];
    UINavigationBar* navBar = schViewController.navigationBar;
    [navBar setBackgroundImage:[UIImage imageNamed: @"BarBackground"] forBarMetrics:UIBarMetricsDefault];
    
    _artistViewController = [[MaArtistViewController alloc] init];
    UINavigationController* banViewController = [[UINavigationController alloc] initWithRootViewController:_artistViewController];
    navBar = banViewController.navigationBar;
    [navBar setBackgroundImage:[UIImage imageNamed: @"BarBackground"] forBarMetrics:UIBarMetricsDefault];
    
    
    _reviewViewController = [[MaCoverflowViewController alloc] init];
    UINavigationController* revViewController = [[UINavigationController alloc] initWithRootViewController:_reviewViewController];
    navBar = revViewController.navigationBar;
    [navBar setBackgroundImage:[UIImage imageNamed: @"BarBackground"] forBarMetrics:UIBarMetricsDefault];
    
    _tabBarController.viewControllers = [NSArray arrayWithObjects:schViewController, banViewController, revViewController, nil];
    
    

    _revealSideViewController = [[PPRevealSideViewController alloc] initWithRootViewController:_tabBarController ];
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
