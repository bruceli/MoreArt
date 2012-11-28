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

@implementation MaPlainView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
		
		//_scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, MA_PLAIN_VIEW_FRAME_WIDE, MA_PLAIN_VIEW_FRAME_HEIGHT)];

        _leftShadowView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MA_SHADOW_VIEW_WIDE , MA_SHADOW_VIEW_HEIGHT)];
        _rightShadowView = [[UIView alloc]initWithFrame:CGRectMake(320-MA_SHADOW_VIEW_WIDE, 0, MA_SHADOW_VIEW_WIDE, MA_SHADOW_VIEW_HEIGHT)];
        

        _leftShadowView.backgroundColor = [UIColor colorWithWhite:0.1f alpha:0.5];
        _rightShadowView.backgroundColor = [UIColor colorWithWhite:0.1f alpha:0.5];
        
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
