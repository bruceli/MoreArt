//
//  MaImageGalleryPhotoView.m
//  MoreArt
//
//  Created by Thunder on 12/20/12.
//  Copyright (c) 2012 MagicApp. All rights reserved.
//

#import "MaImageGalleryPhotoView.h"
#import <QuartzCore/QuartzCore.h>

@implementation MaImageGalleryPhotoView
@synthesize imageView = _imageView;
@synthesize button = _button;
@synthesize photoDelegate;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
		self = [super initWithFrame:frame];
		
		self.userInteractionEnabled = YES;
		self.clipsToBounds = YES;
		self.delegate = self;
		self.contentMode = UIViewContentModeCenter;
		self.maximumZoomScale = 3.0;
		self.minimumZoomScale = 1.0;
		self.decelerationRate = .85;
		self.contentSize = CGSizeMake(frame.size.width, frame.size.height);

		// create the image view
		_imageView = [[AsyncImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
		_imageView.backgroundColor = [UIColor clearColor];

		_imageView.delegate = self;
		_imageView.contentMode = UIViewContentModeScaleAspectFit;
		[self addSubview:_imageView];
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
- (id)initWithFrame:(CGRect)frame target:(id)target action:(SEL)action
{
	self = [self initWithFrame:frame];
	
	// fit them images!
	_imageView.contentMode = UIViewContentModeScaleAspectFill;
	
	// disable zooming
	self.minimumZoomScale = 1.0;
	self.maximumZoomScale = 1.0;
	
	// allow buttons to be clicked
	[self setUserInteractionEnabled:YES];
	
	// but don't allow zooming/panning
	self.scrollEnabled = NO;
	
	// create button
	_button = [[UIButton alloc] initWithFrame:CGRectZero];
	[_button setBackgroundColor:[UIColor yellowColor]];
	[_button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
	[self addSubview:_button];
	
	// create outline
	[self.layer setBorderWidth:1.0];
	[self.layer setBorderColor:[[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:.25] CGColor]];
	
	return self;
}


-(void)imageIsReadyNotify:(UIView*)view
{
	/*
	AsyncImageView* imageView = (AsyncImageView*)view ;
	CGSize size = imageView.image.size;
	CGFloat ratio = imageView.image.size.width/imageView.image.size.height;
	
	if (ratio > 1) {
		// 
		//CGRect = 
		
		
	}
	else{
	
	}

	NSLog(@"%@", NSStringFromCGSize(size));
*/
}
- (void)resetZoom
{
	_isZoomed = NO;
//	[self stopTapTimer];
	[self setZoomScale:self.minimumZoomScale animated:NO];
	[self zoomToRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height ) animated:NO];
	self.contentSize = CGSizeMake(self.frame.size.width * self.zoomScale, self.frame.size.height * self.zoomScale );
}

- (void)setFrame:(CGRect)theFrame
{
	// store position of the image view if we're scaled or panned so we can stay at that point
	CGPoint imagePoint = _imageView.frame.origin;
	
	[super setFrame:theFrame];
	
	// update content size
	self.contentSize = CGSizeMake(theFrame.size.width * self.zoomScale, theFrame.size.height * self.zoomScale );
	
	// resize image view and keep it proportional to the current zoom scale
	_imageView.frame = CGRectMake( imagePoint.x, imagePoint.y, theFrame.size.width * self.zoomScale, theFrame.size.height * self.zoomScale);
	
	// center the activity indicator
	//[_activity setCenter:CGPointMake(theFrame.size.width * .5, theFrame.size.height * .5)];
	
	// update button
	if( _button )
	{
		// resize the button
		_button.frame = CGRectMake(0, 0, theFrame.size.width, theFrame.size.height);
		
		// create a fresh image for button highlight state
		[_button setImage:[self createHighlightImageWithFrame:theFrame] forState:UIControlStateHighlighted];
	}
}


- (UIImage*)createHighlightImageWithFrame:(CGRect)rect
{
	if( rect.size.width == 0 || rect.size.height == 0 ) return nil;
	
	// create a tint layer for the selected state of the button
	UIGraphicsBeginImageContext(CGSizeMake(rect.size.width, rect.size.height));
	CALayer *blankLayer = [CALayer layer];
	[blankLayer setFrame:CGRectMake(0, 0, rect.size.width, rect.size.height)];
	[blankLayer setBackgroundColor:[[UIColor colorWithRed:0 green:0 blue:0 alpha:.4] CGColor]];
	[blankLayer renderInContext: UIGraphicsGetCurrentContext()];
	UIImage *clearImg = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return clearImg;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = [[event allTouches] anyObject];
	
	if (touch.tapCount == 2) {
		[self stopTapTimer];
		
		if( _isZoomed ) 
		{
			_isZoomed = NO;
			[self setZoomScale:self.minimumZoomScale animated:YES];
		}
		else {
			
			_isZoomed = YES;
			
			// define a rect to zoom to. 
			CGPoint touchCenter = [touch locationInView:self];
			CGSize zoomRectSize = CGSizeMake(self.frame.size.width / self.maximumZoomScale, self.frame.size.height / self.maximumZoomScale );
			CGRect zoomRect = CGRectMake( touchCenter.x - zoomRectSize.width * .5, touchCenter.y - zoomRectSize.height * .5, zoomRectSize.width, zoomRectSize.height );
			
			// correct too far left
			if( zoomRect.origin.x < 0 )
				zoomRect = CGRectMake(0, zoomRect.origin.y, zoomRect.size.width, zoomRect.size.height );
			
			// correct too far up
			if( zoomRect.origin.y < 0 )
				zoomRect = CGRectMake(zoomRect.origin.x, 0, zoomRect.size.width, zoomRect.size.height );
			
			// correct too far right
			if( zoomRect.origin.x + zoomRect.size.width > self.frame.size.width )
				zoomRect = CGRectMake(self.frame.size.width - zoomRect.size.width, zoomRect.origin.y, zoomRect.size.width, zoomRect.size.height );
			
			// correct too far down
			if( zoomRect.origin.y + zoomRect.size.height > self.frame.size.height )
				zoomRect = CGRectMake( zoomRect.origin.x, self.frame.size.height - zoomRect.size.height, zoomRect.size.width, zoomRect.size.height );
			
			// zoom to it.
			[self zoomToRect:zoomRect animated:YES];
		}
	}
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	if([[event allTouches] count] == 1 ) {
		UITouch *touch = [[event allTouches] anyObject];
		if( touch.tapCount == 1 ) {
			
			if(_tapTimer ) [self stopTapTimer];
			[self startTapTimer];
		}
	}
}

- (void)startTapTimer
{
	_tapTimer = [[NSTimer alloc] initWithFireDate:[NSDate dateWithTimeIntervalSinceNow:.5] interval:.5 target:self selector:@selector(handleTap) userInfo:nil repeats:NO];
	[[NSRunLoop currentRunLoop] addTimer:_tapTimer forMode:NSDefaultRunLoopMode];
	
}
- (void)stopTapTimer
{
	if([_tapTimer isValid])
		[_tapTimer invalidate];
	
	[_tapTimer release];
	_tapTimer = nil;
}

- (void)handleTap
{
	// tell the controller
	if([_photoDelegate respondsToSelector:@selector(didTapPhotoView:)])
		[_photoDelegate didTapPhotoView:self];
}


- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
	return _imageView;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(float)scale
{
	if( self.zoomScale == self.minimumZoomScale ) _isZoomed = NO;
	else _isZoomed = YES;
}




@end
