//
//  MaPlainView.h
//  MoreArt
//
//  Created by Thunder on 10/13/12.
//  Copyright (c) 2012 MagicApp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MaDefine.h"
@class MaScrollImageViewController;


@interface MaPlainView : UIView
{
    MaDouViewType _douViewType;
    MaScrollImageViewController* _scrollImageViewController;

}
@end
