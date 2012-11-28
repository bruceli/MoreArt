//
//  MaDouWoView.m
//  MoreMusic
//
//  Created by Accthun He on 5/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MaDouWoView.h"
#import "MoreArtAppDelegate.h"
#import "AsyncImageView.h"

/*
@interface UIImageView (AutoResize)  
@end  

@implementation UIImageView (AutoResize)  

- (void)resizeViewSizeBy:(UIImage*)img{  
	self.image = img;
	self.bounds = CGRectMake(0, 0, img.size.width, img.size.height);
}
@end  
*/


@interface MaDouWoView ()
-(void)setupViewsByImageArray:(NSArray*)itemArray;
-(void)addGestureRecognizerTo:(UIView*)view;

@end

@implementation MaDouWoView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _douViewType = DOU_TYPE_DO_WUO;

		CGRect bounds = [ [ UIScreen mainScreen ] applicationFrame ];
		MoreArtAppDelegate* app = (MoreArtAppDelegate *)[[UIApplication sharedApplication] delegate];

		CGRect frame = CGRectMake(0, 0, bounds.size.width, bounds.size.height - MA_TOOLBAR_HEIGHT);
        _scrollView = [[UIScrollView alloc ] initWithFrame:frame ];
        _scrollView.alwaysBounceHorizontal=YES;
		_scrollView.delegate = self;
        _scrollView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"setting_bkg.png"]];
		_currentPageIndex = 0;
		
		[app.dataSourceMgr updateDataSourceArrayByViewType:DOU_TYPE_DO_WUO];
		NSArray* itemArray = app.dataSourceMgr.dataSource;

		[self setupViewsByImageArray:itemArray];
		_scrollView.contentSize = CGSizeMake(MA_PLAIN_VIEW_FRAME_WIDE * [itemArray count] , bounds.size.height - MA_TOOLBAR_HEIGHT);

		[self addSubview:_scrollView ];
//		[self bringSubviewToFront:_leftShadowView];
//		[self bringSubviewToFront:_rightShadowView];
		
		self.delegate = app.baseViewController;
    }
    return self;
	
}

-(void)setupViewsByImageArray:(NSArray*)itemArray
{
	MoreArtAppDelegate* app = (MoreArtAppDelegate *)[[UIApplication sharedApplication] delegate];
	NSDictionary* imgDict = app.dataSourceMgr.imageIndexDict;
	CGRect bounds = [ [ UIScreen mainScreen ] applicationFrame ];

	for (int i = 0 ; i < [itemArray count]; i ++)
	{
		CGRect frame = CGRectMake(MA_PLAIN_VIEW_FRAME_WIDE * i ,
								  0,
								  MA_PLAIN_VIEW_FRAME_WIDE,
								  bounds.size.height - MA_TOOLBAR_HEIGHT );
		
		AsyncImageView* imgView = [[AsyncImageView alloc] initWithFrame:frame];
		imgView.contentMode = UIViewContentModeScaleAspectFill;
		imgView.clipsToBounds = YES;
		imgView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
		[imgView.layer setBorderColor: [[UIColor whiteColor] CGColor]];
		[imgView.layer setBorderWidth: 1.0];
		
		[self addGestureRecognizerTo:imgView];
		
		NSDictionary* dict = [itemArray objectAtIndex:i];
		NSString* path = [imgDict objectForKey:[dict objectForKey:@"imageName"]];
		[imgView setImageByString:path];
		
		imgView.backgroundColor = [UIColor colorWithRed:(random()%100)/(float)100 green:(random()%100)/(float)100 blue:(random()%100)/(float)100 alpha:1];
		//  [_imageViewArray addObject:imgView];
		[_scrollView addSubview:imgView];
		
		CGRect textFrame = CGRectMake(frame.origin.x+10,frame.origin.y+300, 300, 200);
		DTAttributedTextView *textView = [[DTAttributedTextView alloc] initWithFrame:textFrame];
		//	_textView.textDelegate = self;
		textView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		textView.backgroundColor = [UIColor darkGrayColor];
		[_scrollView addSubview:textView];
		[_scrollView bringSubviewToFront:textView];
	}
}

-(void)addGestureRecognizerTo:(UIView*)view
{
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
	singleTap.numberOfTapsRequired = 1;
	[view setUserInteractionEnabled:YES];
    [view addGestureRecognizer:singleTap];
}

- (void)handleSingleTap:(UIGestureRecognizer *)gestureRecognizer {
	UIView* view = gestureRecognizer.view;	
	[self.delegate toggleZoom:(AsyncImageView*)view];
}



-(void)adjustViewSize
{

}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat contentOffset = _scrollView.contentOffset.x + MA_PLAIN_VIEW_FRAME_WIDE/2; // half imageView width
    NSInteger currentIndex = floorf(contentOffset / _scrollView.frame.size.width);
    CGPoint offset = CGPointMake(_scrollView.frame.size.width * currentIndex, 0);
    [_scrollView setContentOffset:offset animated:YES];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate) {
        CGFloat contentOffset = _scrollView.contentOffset.x + MA_PLAIN_VIEW_FRAME_WIDE/2; // half imageView width
        _currentPageIndex = floorf(contentOffset / _scrollView.frame.size.width);
		
        CGPoint offset = CGPointMake(_scrollView.frame.size.width * _currentPageIndex, 0);
        [_scrollView setContentOffset:offset animated:YES];
        
//        NSLog(@"Drag to , %f", _scrollView.frame.size.width * _currentPageIndex);
    }
}




@end
