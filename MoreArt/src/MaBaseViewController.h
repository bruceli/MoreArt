//
//  MaBaseViewController.h
//  MoreArt
//
//  Created by Thunder on 8/23/12.
//  Copyright (c) 2012 MagicApp. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MaDataSource;

@interface MaBaseViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>
{
    id currentView;
    
    MaDataSource* _dataSourceMgr;
    
}

-(void)updateDataSourceBy:(MaDouViewType)type;


@end
