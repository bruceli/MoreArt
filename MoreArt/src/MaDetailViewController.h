//
//  MaDetailViewController.h
//  MoreArt
//
//  Created by Thunder on 9/2/12.
//  Copyright (c) 2012 MagicApp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MaScrollImageViewController.h"


@interface MaDetailViewController : UIViewController
{
    UIScrollView* _scrollView;
    UIImageView* _avatarImgView;
    
//    MCPagerView* _pagerView;
//    UIScrollView* _scrollPagerView;
    MaScrollImageViewController* _scrollImageViewController;
    UILabel* _titleLabel;
//    UILabel* _headerLabel;
    UILabel* _bodyLabel;
    UILabel* _endingLabel;
    
    NSIndexPath* _indexPath;
    
//    BOOL _needAutoScroll;
//    NSTimer* _autoScrollTimer;
    
    id _currentView;
}

@property (nonatomic, retain) NSIndexPath* indexPath;

@end
