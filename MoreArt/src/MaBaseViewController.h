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

@interface MaBaseViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,MaViewPlainDelegate>
{
    id currentView;
    
    MaDataSource* _dataSourceMgr;
	UIView *proxyView;
    
}

-(void)updateDataSourceBy:(MaDouViewType)type;


@end
