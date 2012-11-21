//
//  MaPlainView.m
//  MoreArt
//
//  Created by Thunder on 10/13/12.
//  Copyright (c) 2012 MagicApp. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "MaPlainView.h"
#import "AsyncImageView.h"

#define MA_SHADOW_VIEW_WIDE 20
#define MA_SHADOW_VIEW_HEIGHT 440

#define MA_PLAIN_VIEW_MINIMUM_FRAME_COUNT 5
#define MA_PLAIN_VIEW_FRAME_WIDE 320
#define MA_PLAIN_VIEW_FRAME_HEIGHT 700


@implementation MaPlainView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, MA_PLAIN_VIEW_FRAME_WIDE, MA_PLAIN_VIEW_FRAME_HEIGHT)];

        _leftShadowView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MA_SHADOW_VIEW_WIDE , MA_SHADOW_VIEW_HEIGHT)];
        _rightShadowView = [[UIView alloc]initWithFrame:CGRectMake(320-MA_SHADOW_VIEW_WIDE, 0, MA_SHADOW_VIEW_WIDE, MA_SHADOW_VIEW_HEIGHT)];
        _scrollView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"setting_bkg.png"]];
        
        for (int i = 0 ; i < MA_PLAIN_VIEW_MINIMUM_FRAME_COUNT; i ++)
        {
            CGRect frame = CGRectMake(MA_PLAIN_VIEW_FRAME_WIDE * i ,
                                      0,
                                      MA_PLAIN_VIEW_FRAME_WIDE,
                                      MA_PLAIN_VIEW_FRAME_HEIGHT);
            
            AsyncImageView* imgView = [[AsyncImageView alloc] initWithFrame:frame];
            [imgView.layer setBorderColor: [[UIColor whiteColor] CGColor]];
            [imgView.layer setBorderWidth: 1.0];
            
            imgView.backgroundColor = [UIColor colorWithRed:(random()%100)/(float)100 green:(random()%100)/(float)100 blue:(random()%100)/(float)100 alpha:1];
          //  [_imageViewArray addObject:imgView];
            [_scrollView addSubview:imgView];
        }
        _scrollView.contentSize = CGSizeMake(MA_PLAIN_VIEW_FRAME_WIDE * MA_PLAIN_VIEW_MINIMUM_FRAME_COUNT , MA_PLAIN_VIEW_FRAME_HEIGHT);

        _leftShadowView.backgroundColor = [UIColor colorWithWhite:0.1f alpha:0.5];
        _rightShadowView.backgroundColor = [UIColor colorWithWhite:0.1f alpha:0.5];
        
        [self addSubview:_scrollView];
        [self addSubview:_leftShadowView];
        [self addSubview:_rightShadowView];

        
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
