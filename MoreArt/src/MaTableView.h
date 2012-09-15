//
//  MaTableView.h
//  MoreArt
//
//  Created by Thunder on 8/23/12.
//  Copyright (c) 2012 MagicApp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MaDefine.h"

@interface MaTableView : UITableView
{
    MaDouViewType _douViewType;
}

@property (nonatomic) MaDouViewType   douViewType;


@end
