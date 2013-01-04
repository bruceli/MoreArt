//
//  MaBaseViewController.h
//  MoreArt
//
//  Created by Thunder on 8/23/12.
//  Copyright (c) 2012 MagicApp. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MaDataSource;
#import "MaPlainView.h"

@interface MaBaseViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
{
    id currentView;
    
    MaDataSource* _dataSourceMgr;
	UIScrollView* _scrollView;
	UIView *proxyView;
    
	BOOL _settingViewStatus;
}

-(void)updateDataSourceBy:(MaDouViewType)type;
-(NSInteger)supportedOrientations;
@property (nonatomic) BOOL settingViewStatus;

@end
