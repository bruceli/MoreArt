//
//  MaScrollImageViewController.m
//  MoreArt
//
//  Created by Thunder on 9/15/12.
//  Copyright (c) 2012 MagicApp. All rights reserved.
//

#import "MaScrollImageViewController.h"

@interface MaScrollImageViewController ()

@end

@implementation MaScrollImageViewController
@synthesize imageArray = _imageArray;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _scrollImageView = [[MaScrollImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 135)];
        [self.view addSubview:_scrollImageView];
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    //INIT RECT
    CGRect rect = self.view.bounds;
    [self.view setFrame:rect];
    

	// Do any additional setup after loading the view.
    
    _theScroller = [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(pagerViewScroller) userInfo:nil repeats:YES];
    _needAutoScroll = YES;
    NSArray* array = [NSArray arrayWithObjects:@"0",@"1",@"2",@"3",@"4", nil];
    _imageArray = [[NSMutableArray alloc] initWithArray:array];
    _scrollImageView.delegate = self;
    
    _currentPageIndex = 0;
    _scrollImageView.scrollView.delegate = self;

}


- (void)viewWillDisappear:(BOOL)animated
{
    [_autoScrollTimer invalidate];
    _autoScrollTimer = nil;
    [_theScroller invalidate];
    _theScroller = nil;
    
    [super viewWillDisappear:animated];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)startAutoScroll
{
    _needAutoScroll = YES;
    NSLog(@"%@", @"Enable Auto scroll");
    
    
}

-(void)pagerViewScroller
{
    if (_needAutoScroll) {
        [self scrollPagerView];
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
    
    NSInteger page = _currentPageIndex + 1;
    if (page < [_imageArray count])
        _currentPageIndex++;
    else
        _currentPageIndex=0;
    NSLog(@"Current Page is  , %d", _currentPageIndex);
    
    [self updatePager];
}


//----------------------PagerView Delegate
- (void)updatePager
{
//    CGFloat contentOffset = _scrollImageView.contentOffset.x+160; // half imageView width
    CGPoint offset = CGPointMake(_scrollImageView.scrollView.frame.size.width * _currentPageIndex, 0);
    [_scrollImageView.scrollView setContentOffset:offset animated:YES];
    
//    NSLog(@"Scrolling to , %f", _scrollImageView.frame.size.width * _currentPageIndex);

}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat contentOffset = _scrollImageView.contentOffset.x+160; // half imageView width
    NSInteger currentIndex = floorf(contentOffset / _scrollImageView.frame.size.width);
    CGPoint offset = CGPointMake(_scrollImageView.scrollView.frame.size.width * currentIndex, 0);
    [_scrollImageView.scrollView setContentOffset:offset animated:YES];

}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    _needAutoScroll = NO;
    NSLog(@"%@", @"Disable Auto scroll");
    _autoScrollTimer = [NSTimer scheduledTimerWithTimeInterval: 5
                                                        target: self
                                                      selector: @selector(startAutoScroll)
                                                      userInfo: nil
                                                       repeats: NO];
}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate) {
        CGFloat contentOffset = _scrollImageView.contentOffset.x+160; // half imageView width
        _currentPageIndex = floorf(contentOffset / _scrollImageView.frame.size.width);

        CGPoint offset = CGPointMake(_scrollImageView.scrollView.frame.size.width * _currentPageIndex, 0);
        [_scrollImageView.scrollView setContentOffset:offset animated:YES];
        
        NSLog(@"Drag to , %f", _scrollImageView.frame.size.width * _currentPageIndex);
    }
}

/*
- (void)pageView:(MCPagerView *)pageView didUpdateToPage:(NSInteger)newPage
{
    CGPoint offset = CGPointMake(_scrollImageView.scrollView.frame.size.width * _scrollImageView.pagerView.page, 0);
    [_scrollImageView.scrollView setContentOffset:offset animated:YES];
    
    NSLog(@"Scrolling to , %f", _scrollImageView.frame.size.width * _scrollImageView.pagerView.page);
    
}
-(void)needStopAutoScrolling
{
    _needAutoScroll = NO;
}
 */


@end
