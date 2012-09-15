//
//  MaScrollImageView.h
//  MoreArt
//
//  Created by Thunder on 9/15/12.
//  Copyright (c) 2012 MagicApp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCPagerView.h"

@interface MaScrollImageView : UIScrollView <UIScrollViewDelegate, MCPagerViewDelegate>
{
    UIScrollView* _scrollPagerView;
    MCPagerView* _pagerView;
    BOOL _needAutoScroll;
    NSTimer* _autoScrollTimer;
    NSTimer* _theScroller;

    NSArray* _imageArray;
}
@end
