//
//  MaScrollImageView.m
//  MoreArt
//
//  Created by Thunder on 9/15/12.
//  Copyright (c) 2012 MagicApp. All rights reserved.
//

#import "MaScrollImageView.h"

@implementation MaScrollImageView
//@synthesize pagerView = _pagerView;
@synthesize scrollView = _scrollView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        CGRect theFrame = CGRectMake(0, 0, 320, 135);
        _scrollView = [[UIScrollView alloc] initWithFrame:theFrame];
        
        int i=0;
        for (; i<5; i++) {
            CGRect frame = CGRectMake(theFrame.size.width * i,
                                      0,
                                      theFrame.size.width,
                                      theFrame.size.height);
            
            UILabel *label = [[UILabel alloc] initWithFrame:frame];
            label.textAlignment = UITextAlignmentCenter;
            label.font = [UIFont systemFontOfSize:40];
            label.text = [NSString stringWithFormat:@"%d", i];
            
            if (i%2==0) {
                label.backgroundColor = [UIColor grayColor];
                label.textColor = [UIColor whiteColor];
            }
            
            
            [_scrollView addSubview:label];
        }
        _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width * i, _scrollView.frame.size.height);
        _scrollView.backgroundColor = [UIColor orangeColor];
        _scrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview: _scrollView];
        
    }
    return self;
}

-(void)layoutSubviews
{

}

@end
