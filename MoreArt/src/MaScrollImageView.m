//
//  MaScrollImageView.m
//  MoreArt
//
//  Created by Thunder on 9/15/12.
//  Copyright (c) 2012 MagicApp. All rights reserved.
//

#import "MaScrollImageView.h"

@implementation MaScrollImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _theScroller = [NSTimer scheduledTimerWithTimeInterval: 3
                                                            target: self
                                                          selector: @selector(pagerViewScroller)
                                                          userInfo: nil
                                                           repeats: YES];
        _needAutoScroll = YES;

    }
    return self;
}

-(void)layoutSubviews
{

    CGRect theFrame = CGRectMake(0, 0, 320, 135);
    _scrollPagerView = [[UIScrollView alloc] initWithFrame:theFrame];
    
    int i=0;
    for (; i<6; i++) {
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
        
        
        [_scrollPagerView addSubview:label];
    }
    _scrollPagerView.contentSize = CGSizeMake(_scrollPagerView.frame.size.width * i, _scrollPagerView.frame.size.height);
    _scrollPagerView.backgroundColor = [UIColor orangeColor];
    _scrollPagerView.delegate = self;
    _scrollPagerView.showsHorizontalScrollIndicator = NO;
    [self addSubview: _scrollPagerView];
    
    
    _pagerView = [[MCPagerView alloc] initWithFrame:CGRectMake(30, 100, 260, 32)];
    _pagerView.delegate = self;
    [self addSubview: _pagerView];
    
    [_pagerView setImage:[UIImage imageNamed:@"dot"]
        highlightedImage:[UIImage imageNamed:@"dot_Selected"]
                  forKey:@"a"];
    [_pagerView setPattern:@"aaaaaa"];

}



-(void)startAutoScroll
{
    _needAutoScroll = YES;
    NSLog(@"%@", @"Enable Auto scroll");
    
    
}

-(void)pagerViewScroller
{
    if (_needAutoScroll) {
        [self performSelectorOnMainThread:@selector(scrollPagerView) withObject:nil waitUntilDone:YES];
    }
    else
    {
        [NSThread sleepForTimeInterval:2];
        NSLog(@"%@",@"Skipping Auto Scrolling");
        
    }
}


-(void)scrollPagerView
{
    if (!_needAutoScroll) {
        NSLog(@"%@",@"Skipping Auto Scrolling from scrollPagerView");
        return;
    }
    
    
    if (_pagerView.page < 5)
        _pagerView.page++;
    else
        _pagerView.page=0;
    NSLog(@"Current Page is  , %d", _pagerView.page);
    
}


//----------------------PagerView Delegate
- (void)updatePager
{
    CGFloat contentOffset = _scrollPagerView.contentOffset.x+160; // half imageView width
    _pagerView.page = floorf(contentOffset / _scrollPagerView.frame.size.width);
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self updatePager];
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    _needAutoScroll = NO;
    NSLog(@"%@", @"Disable Auto scroll");
    _autoScrollTimer = [NSTimer scheduledTimerWithTimeInterval: 10
                                                        target: self
                                                      selector: @selector(startAutoScroll)
                                                      userInfo: nil
                                                       repeats: NO];
}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate) {
        [self updatePager];
    }
}

- (void)pageView:(MCPagerView *)pageView didUpdateToPage:(NSInteger)newPage
{
    CGPoint offset = CGPointMake(_scrollPagerView.frame.size.width * _pagerView.page, 0);
    [_scrollPagerView setContentOffset:offset animated:YES];
    
    NSLog(@"Scrolling to , %f", _scrollPagerView.frame.size.width * _pagerView.page);
    
}

-(void)needStopAutoScrolling
{
    _needAutoScroll = NO;
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
