//
//  MaTableView.h
//  MoreArt
//
//  Created by Thunder on 8/23/12.
//  Copyright (c) 2012 MagicApp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MaDefine.h"
#import "MaScrollImageViewController.h"

@interface MaTableView : UITableView 
{
    MaDouViewType _douViewType;
	BOOL _reloading;
    
	MaScrollImageViewController* _scrollImageViewController;

}

@property (nonatomic) MaDouViewType   douViewType;

@property (nonatomic, retain ) MaScrollImageViewController* scrollImageViewController;

@end
