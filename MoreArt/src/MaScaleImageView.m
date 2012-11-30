//
//  MaScaleImageView.m
//  MoreArt
//
//  Created by Thunder on 11/30/12.
//  Copyright (c) 2012 MagicApp. All rights reserved.
//

#import "MaScaleImageView.h"

@implementation MaScaleImageView
@synthesize _scaleImageViewDelegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
		self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"setting_bkg.png"]];
		
		_imageView = [[AsyncImageView alloc] initWithFrame:CGRectMake(0,0, 320, 190)];
		_imageView.contentMode = UIViewContentModeScaleAspectFill;
		_imageView.clipsToBounds = YES;
		_imageView.showActivityIndicator = YES;
		_imageView.delegate = self;
		
		[[AsyncImageLoader sharedLoader] cancelLoadingImagesForTarget:_imageView];
		[self addSubview:_imageView];
		
		[self addSingleTapGestureRecognizer];
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
-(void)loadImageFrom:(NSString*)imgPath
{
	[_imageView setImageByString:imgPath];
}

-(void) initScrollableImageView
{
}

-(void)imageIsReadyNotify
{
	NSLog(@"%@",@"image is ready");
}


-(void)addSingleTapGestureRecognizer
{
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
	singleTap.numberOfTapsRequired = 1;
	[self setUserInteractionEnabled:YES];
    [self addGestureRecognizer:singleTap];
}

- (void)handleSingleTap:(UIGestureRecognizer *)gestureRecognizer {
	UIView* view = gestureRecognizer.view;	
	[_scaleImageViewDelegate toggleZoom:view];
}


/*
 - (void)handleDoubleTap:(UIGestureRecognizer *)gestureRecognizer {
 // double tap zooms in
 float newScale = [_scrollView zoomScale] * ZOOM_STEP;
 CGRect zoomRect = [self zoomRectForScale:newScale withCenter:[gestureRecognizer locationInView:gestureRecognizer.view]];
 [_scrollView zoomToRect:zoomRect animated:YES];
 }
 
 - (void)handleTwoFingerTap:(UIGestureRecognizer *)gestureRecognizer {
 // two-finger tap zooms out
 float newScale = [_scrollView zoomScale] / ZOOM_STEP;
 CGRect zoomRect = [self zoomRectForScale:newScale withCenter:[gestureRecognizer locationInView:gestureRecognizer.view]];
 [_scrollView zoomToRect:zoomRect animated:YES];
 }
 */

- (CGRect)zoomRectForScale:(float)scale withCenter:(CGPoint)center {
    
    CGRect zoomRect;
    
    // the zoom rect is in the content view's coordinates. 
    //    At a zoom scale of 1.0, it would be the size of the imageScrollView's bounds.
    //    As the zoom scale decreases, so more content is visible, the size of the rect grows.
    zoomRect.size.height = [self frame].size.height / scale;
    zoomRect.size.width  = [self frame].size.width  / scale;
    
    // choose an origin so as to get the right center.
    zoomRect.origin.x    = center.x - (zoomRect.size.width  / 2.0);
    zoomRect.origin.y    = center.y - (zoomRect.size.height / 2.0);
    
    return zoomRect;
}




@end
