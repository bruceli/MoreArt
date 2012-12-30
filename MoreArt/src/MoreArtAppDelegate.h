//
//  MoreArtAppDelegate.h
//  MoreMusic
//
//  Created by Accthun He on 5/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MaDouWoView.h"
#import "MaDouSpaceView.h"
#import "MaArt029View.h"
#import "MaDouPeKingBaseView.h"
#import "MaMoLangPhotoView.h"
#import "MaBaseViewController.h"
#import "MaAboutView.h"
#import "MaCoverFlowView.h"

#import "MaCrossFadeView.h"

#import "MaDataSource.h"

#import "PPRevealSideViewController.h"
#import "MaSettingViewController.h"


//#import "MaBandViewController.h"
//#import "MaMoreViewController.h"
//#import "MaWelcomeViewController.h"
//#import "MaArtistViewController.h"
//#import "MaCoverflowViewController.h"

@interface MoreArtAppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate,PPRevealSideViewControllerDelegate>
{
    MaDouWoView* _douWoView;
    MaDouSpaceView*   _douSpaceView;
    MaArt029View* _art029View;
    MaDouPeKingBaseView* _douPeikingView;
    MaMoLangPhotoView* _moLangPhotoView;
    MaAboutView* _aboutView;
    MaCoverFlowView* _coverFlowView;
    
    MaCrossFadeView* _crossFadeView;
    
    MaDataSource* _dataSourceMgr;
    
    MaBaseViewController* _baseViewController;
    PPRevealSideViewController* _revealSideViewController;
}
-(void)startAnimationCounting;

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) MaDouWoView* douWoView;
@property (nonatomic, retain) MaDouSpaceView*   douSpaceView;
@property (nonatomic, retain) MaArt029View*   art029View;
@property (nonatomic, retain) MaDouPeKingBaseView*   douPeikingView;
@property (nonatomic, retain) MaMoLangPhotoView*   moLangPhotoView;
@property (nonatomic, retain) MaAboutView*   aboutView;
@property (nonatomic, retain) MaCoverFlowView*   coverFlowView;
@property (nonatomic, retain) MaCrossFadeView*   crossFadeView;

@property (nonatomic, retain) MaDataSource*   dataSourceMgr;

@property (nonatomic, retain) MaBaseViewController*   baseViewController;
@property (nonatomic, retain) PPRevealSideViewController* revealSideViewController;

//@property (nonatomic, retain) UITabBarController* tabBarController;
//@property (nonatomic, retain) MaWeiboStreamViewController* weiboStreamViewController;
//@property (nonatomic, retain) MaMoreViewController* moreViewController;
//@property (nonatomic, retain) MaCoverflowViewController* reviewViewController;
//@property (nonatomic, retain) MaWelcomeViewController* welcomeViewController;


@end
