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

@interface MoreArtAppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate,PPRevealSideViewControllerDelegate>
{
    MaScheduleViewController* _scheduleViewController;
    MaBandViewController*   _bandViewController;
    MaReviewViewController* _reviewViewController;
    MaWelcomeViewController* _welcomeViewController;
    PPRevealSideViewController* _revealSideViewController;
    UITabBarController *_tabBarController;

}
@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) MaScheduleViewController* scheduleViewController;
@property (nonatomic, retain) MaBandViewController*   bandViewController;
@property (nonatomic, retain) MaReviewViewController* reviewViewController;
@property (nonatomic, retain) MaWelcomeViewController* welcomeViewController;
@property (nonatomic, retain) PPRevealSideViewController* revealSideViewController;

//@property (nonatomic, retain) UITabBarController* tabBarController;
//@property (nonatomic, retain) MaWeiboStreamViewController* weiboStreamViewController;
//@property (nonatomic, retain) MaMoreViewController* moreViewController;


@end
