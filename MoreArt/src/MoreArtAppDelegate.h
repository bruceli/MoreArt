//
//  MoreArtAppDelegate.h
//  MoreMusic
//
//  Created by Accthun He on 5/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MaScheduleViewController.h"
#import "MaBandViewController.h"
#import "MaReviewViewController.h"
#import "MaMoreViewController.h"
#import "MaWelcomeViewController.h"
#import "PPRevealSideViewController.h"
#import "MaSettingViewController.h"
#import "MaArtistViewController.h"
#import "MaCoverflowViewController.h"

@interface MoreArtAppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate,PPRevealSideViewControllerDelegate>
{
    MaScheduleViewController* _scheduleViewController;
    MaArtistViewController*   _artistViewController;
    MaCoverflowViewController* _reviewViewController;
    MaWelcomeViewController* _welcomeViewController;
    PPRevealSideViewController* _revealSideViewController;
    UITabBarController *_tabBarController;

}

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) MaScheduleViewController* scheduleViewController;
@property (nonatomic, retain) MaArtistViewController*   artistViewController;
@property (nonatomic, retain) MaCoverflowViewController* reviewViewController;
@property (nonatomic, retain) MaWelcomeViewController* welcomeViewController;
@property (nonatomic, retain) PPRevealSideViewController* revealSideViewController;

//@property (nonatomic, retain) UITabBarController* tabBarController;
//@property (nonatomic, retain) MaWeiboStreamViewController* weiboStreamViewController;
//@property (nonatomic, retain) MaMoreViewController* moreViewController;


@end
