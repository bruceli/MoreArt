//
//  MaScrollImageView.h
//  MoreArt
//
//  Created by Thunder on 9/15/12.
//  Copyright (c) 2012 MagicApp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MaScrollImageView : UIScrollView
{
    UIScrollView* _scrollView;
}
@property (nonatomic, retain) UIScrollView*   scrollView;


@end
