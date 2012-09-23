//
//  MaTableView.h
//  MoreArt
//
//  Created by Thunder on 8/23/12.
//  Copyright (c) 2012 MagicApp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MaDefine.h"
#import "EGORefreshTableHeaderView.h"

@interface MaTableView : UITableView <EGORefreshTableHeaderDelegate>
{
    MaDouViewType _douViewType;
    EGORefreshTableHeaderView *_refreshHeaderView;
	BOOL _reloading;

}

@property (nonatomic) MaDouViewType   douViewType;


@end
