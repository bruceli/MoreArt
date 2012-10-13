//
//  MaScrollImageViewController.h
//  MoreArt
//
//  Created by Thunder on 9/15/12.
//  Copyright (c) 2012 MagicApp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MaScrollImageView.h"

@interface MaScrollImageViewController : UIViewController <UIScrollViewDelegate>
{
    MaScrollImageView* _scrollImageView;
    BOOL _needAutoScroll;
    
    NSInteger _currentPageIndex;
    NSTimer* _autoScrollTimer;
    NSTimer* _theScroller;
    
    NSArray* _imageArray;
}

-(void)stopScrolling;
-(void)startScrolling;
-(void)setScrollingImagesBy:(NSArray*)array;


@property (nonatomic, retain) NSArray*  imageArray;

@end
