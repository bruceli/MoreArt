//
//  MaDetailViewController.m
//  MoreArt
//
//  Created by Thunder on 9/2/12.
//  Copyright (c) 2012 MagicApp. All rights reserved.
//

#import "MaDetailViewController.h"
#import "MoreArtAppDelegate.h"

@interface MaDetailViewController ()
-(void) fillContents;
-(void) adjustViewSize;
-(void) initPagerViews;

@end

@implementation MaDetailViewController
@synthesize indexPath = _indexPath;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _needAutoScroll = YES;

    CGRect bounds = [ [ UIScreen mainScreen ] applicationFrame ];
    _scrollView = [[UIScrollView alloc ] initWithFrame:bounds ];
    _scrollView.alwaysBounceVertical=YES;
    
    self.view = _scrollView;
    _scrollView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"setting_bkg.png"]];
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 140, 310, 35)];
    _bodyLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, _titleLabel.frame.origin.y + _titleLabel.frame.size.height, 310, 400)];
 
    _titleLabel.backgroundColor = [UIColor darkGrayColor];
    _imgView.backgroundColor = [UIColor darkGrayColor];
    _bodyLabel.backgroundColor = [UIColor darkGrayColor];

    _titleLabel.textColor = [UIColor whiteColor];
    _bodyLabel.textColor = [UIColor greenColor];
    
    _titleLabel.font = [UIFont fontWithName:@"STHeitiTC-Medium" size:20];
    _bodyLabel.font = [UIFont fontWithName:@"STHeitiTC-Light" size:16];

    _bodyLabel.textAlignment = UITextAlignmentLeft;
    _bodyLabel.numberOfLines = 0;

    [self initPagerViews];
    
    [self.view addSubview:_titleLabel];
    [self.view addSubview:_imgView];
    [self.view addSubview:_bodyLabel];
    
    // add ending Label
    CGRect rect = _bodyLabel.frame;
    _endingLabel = [[UILabel alloc] initWithFrame:CGRectMake(rect.origin.x, rect.origin.y+rect.size.height+5, 310, 20)];
    _endingLabel.backgroundColor = [UIColor darkGrayColor];
    [self.view addSubview:_endingLabel];
    
    // set scroll view size
    CGSize viewSize = CGSizeMake(_titleLabel.frame.size.width, _endingLabel.frame.origin.y+_endingLabel.frame.size.height+10);

    _scrollView.contentSize = viewSize;
    
    [NSThread detachNewThreadSelector:@selector(pagerViewScroller) toTarget:self withObject:nil];

    [self fillContents];
    [self adjustViewSize];
    
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"UIDeviceOrientationDidChangeNotification" object:nil];

//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationChanged:) name:@"UIDeviceOrientationDidChangeNotification" object:nil];

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void) fillContents
{
    MoreArtAppDelegate* app = (MoreArtAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSDictionary* dict = [app.dataSourceMgr.dataSource objectAtIndex: _indexPath.row];
    _titleLabel.text = [dict objectForKey:@"title"];
    _bodyLabel.text = [dict objectForKey:@"detail"];
    
    // BodyLabel resize here
    [_bodyLabel sizeToFit];
}


-(void)adjustViewSize
{

}


-(void) initPagerViews
{    
    // Pager Scroll view
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
    [self.view addSubview: _scrollPagerView];
    
    
    _pagerView = [[MCPagerView alloc] initWithFrame:CGRectMake(30, 100, 260, 32)];
    _pagerView.delegate = self;
    [self.view addSubview: _pagerView];
    
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
    while(YES) {
        if (_needAutoScroll) {
            [NSThread sleepForTimeInterval:2];
            [self performSelectorOnMainThread:@selector(scrollPagerView) withObject:nil waitUntilDone:YES];
        }
        else
        {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"%@",@"Skipping Auto Scrolling");

        }
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

//    NSLog(@"%@", @"Scrolling");
/*    CGFloat contentOffset = _scrollPagerView.contentOffset.x+170; // half imageView width
    
    CGFloat maxContentSize = _scrollPagerView.frame.size.width * 6;
    
    if (contentOffset > maxContentSize) {
        contentOffset = 160;
    }
    _pagerView.page = floorf(contentOffset / _scrollPagerView.frame.size.width);
    NSLog(@"Current Page is  , %d", _pagerView.page);
 */

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


- (void) orientationChanged:(id)object
{
	UIInterfaceOrientation interfaceOrientation = [[object object] orientation];
    MoreArtAppDelegate* app = (MoreArtAppDelegate *)[[UIApplication sharedApplication] delegate];
    
	if (interfaceOrientation == UIInterfaceOrientationPortrait ||interfaceOrientation ==  UIInterfaceOrientationPortraitUpsideDown)
	{
        if (_currentView)
        {
            self.view = _currentView;
            self.navigationController.navigationBarHidden = NO;
            //            NSLog(@"%@", @"==== portrait");
        }
        
	}
	else if(interfaceOrientation == UIDeviceOrientationLandscapeRight|| interfaceOrientation == UIDeviceOrientationLandscapeLeft)
	{
        if (app.coverFlowView != self.view) {
            //            NSLog(@"%@", @"==== landScape Mode");
            _currentView = self.view;
        }
        self.view = app.coverFlowView;
        self.navigationController.navigationBarHidden = YES;
        
        
	}
}


@end
