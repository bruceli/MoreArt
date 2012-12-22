//
//  MaImageGalleryViewController.m
//  MoreArt
//
//  Created by Thunder on 12/20/12.
//  Copyright (c) 2012 MagicApp. All rights reserved.
//

#import "MaImageGalleryViewController.h"
#import "MaDefine.h"
#import "MaImageGalleryPhotoView.h"
#import "MoreArtAppDelegate.h"

@interface MaImageGalleryViewController ()

@end

@implementation MaImageGalleryViewController
@synthesize startingIndex = _startingIndex;
@synthesize photoSource = _photoSource;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithPhotoSource:(NSArray*)photoSrc
{
	if((self = [self initWithNibName:nil bundle:nil])) {
		
		_photoSource = photoSrc;
	}
	return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadView
{
    _container							= [[UIView alloc] initWithFrame:CGRectZero];
    _innerContainer						= [[UIView alloc] initWithFrame:CGRectZero];
    _scroller							= [[UIScrollView alloc] initWithFrame:CGRectZero];
    _captionContainer					= [[UIView alloc] initWithFrame:CGRectZero];
    _caption							= [[UILabel alloc] initWithFrame:CGRectZero];
	_container.backgroundColor			= [UIColor blackColor];
	_photoViews							= [[NSMutableArray alloc] init];

    [_container addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:nil];
    // setup scroller
    _scroller.delegate							= self;
    _scroller.pagingEnabled						= YES;
    _scroller.showsVerticalScrollIndicator		= NO;
    _scroller.showsHorizontalScrollIndicator	= NO;
    
    // setup caption
    _captionContainer.backgroundColor			= [UIColor colorWithWhite:0.0 alpha:.35];
    _captionContainer.hidden					= YES;
    _captionContainer.userInteractionEnabled	= NO;
    _captionContainer.exclusiveTouch			= YES;
    _caption.font								= [UIFont systemFontOfSize:14.0];
    _caption.textColor							= [UIColor whiteColor];
    _caption.backgroundColor					= [UIColor clearColor];
    _caption.textAlignment						= UITextAlignmentCenter;
    _caption.shadowColor						= [UIColor blackColor];
    _caption.shadowOffset						= CGSizeMake( 1, 1 );
    
    // make things flexible
    _container.autoresizesSubviews				= NO;
    _innerContainer.autoresizesSubviews			= NO;
    _scroller.autoresizesSubviews				= NO;
    _container.autoresizingMask					= UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
	// set view
	self.view                                   = _container;
	
	self.view.backgroundColor = [UIColor blackColor];
	_innerContainer.backgroundColor = [UIColor clearColor];
	_scroller.backgroundColor = [UIColor clearColor];
	
	// add items to their containers
	[self.view addSubview:_innerContainer];
	
	[_innerContainer addSubview:_scroller];
	
//	[_toolbar addSubview:_captionContainer];
	[_captionContainer addSubview:_caption];
	
	[self reloadGallery];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
	[_container removeObserver:self forKeyPath:@"frame"];
}


-(void)reloadGallery
{
    _currentIndex = _startingIndex;	
    [self destroyViews];
    if ([_photoSource count] > 0) {
		[self buildViews];
        [self gotoImageByIndex:_currentIndex animated:NO];
        [self layoutViews];
	}
}

- (void)destroyViews {
    for (UIView *view in _photoViews) {
        [view removeFromSuperview];
    }
    [_photoViews removeAllObjects];


}


- (void)buildViews
{
	MoreArtAppDelegate* app = (MoreArtAppDelegate *)[[UIApplication sharedApplication] delegate];
	NSDictionary* imgDict = app.dataSourceMgr.imageIndexDict;

	NSUInteger i, count = [_photoSource count];
	for (i = 0; i < count; i++) {
		MaImageGalleryPhotoView *photoView = [[MaImageGalleryPhotoView alloc] initWithFrame:CGRectZero];
		photoView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
		photoView.autoresizesSubviews = YES;
		photoView.photoDelegate = self;
		
		NSDictionary* dict = [_photoSource objectAtIndex:i];
		NSString* name = [dict objectForKey:@"imageName"];

		NSString* path = [imgDict objectForKey:name];
		if ([path length] >0) {
			[photoView.imageView setImageByString:path];
			
			[_scroller addSubview:photoView];
			[_photoViews addObject:photoView];
		}
	}
}


- (void)enterFullscreen
{
	_isFullscreen = YES;
	
	[self disableApp];
	
	UIApplication* application = [UIApplication sharedApplication];
	if ([application respondsToSelector: @selector(setStatusBarHidden:withAnimation:)]) {
		[[UIApplication sharedApplication] setStatusBarHidden: YES withAnimation: UIStatusBarAnimationFade]; // 3.2+
	} else {
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
		[[UIApplication sharedApplication] setStatusBarHidden: YES animated:YES]; // 2.0 - 3.2
#pragma GCC diagnostic warning "-Wdeprecated-declarations"
	}
	
	[self.navigationController setNavigationBarHidden:YES animated:YES];
	
	[UIView beginAnimations:@"galleryOut" context:nil];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(enableApp)];
	_captionContainer.alpha = 0.0;
	[UIView commitAnimations];
}



- (void)exitFullscreen
{
	_isFullscreen = NO;
    
	[self disableApp];
    
	UIApplication* application = [UIApplication sharedApplication];
	if ([application respondsToSelector: @selector(setStatusBarHidden:withAnimation:)]) {
		[[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade]; // 3.2+
	} else {
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
		[[UIApplication sharedApplication] setStatusBarHidden:NO animated:NO]; // 2.0 - 3.2
#pragma GCC diagnostic warning "-Wdeprecated-declarations"
	}
    
	[self.navigationController setNavigationBarHidden:NO animated:YES];
    
	[UIView beginAnimations:@"galleryIn" context:nil];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(enableApp)];
	_captionContainer.alpha = 1.0;
	[UIView commitAnimations];
}



- (void)enableApp
{
	[[UIApplication sharedApplication] endIgnoringInteractionEvents];
}


- (void)disableApp
{
	[[UIApplication sharedApplication] beginIgnoringInteractionEvents];
}


- (void)didTapPhotoView:(MaImageGalleryPhotoView*)photoView
{
	// don't change when scrolling
	if( _isScrolling || !_isActive ) return;
	
	// toggle fullscreen.
	if( _isFullscreen == NO ) {
		
		[self enterFullscreen];
	}
	else {
		
		[self exitFullscreen];
	}
	
}

- (void)updateCaption
{
}

- (void)updateScrollSize
{
	float contentWidth = _scroller.frame.size.width * [_photoSource count];
	[_scroller setContentSize:CGSizeMake(contentWidth, _scroller.frame.size.height)];
}


- (void)updateTitle
{
	[self setTitle:[NSString stringWithFormat:@"%i of %i", _currentIndex+1, [_photoSource count]]];
}

-(void)layoutViews
{
	[self positionInnerContainer];
	[self positionScroller];
//	[self resizeThumbView];
//	[self positionToolbar];
	[self updateScrollSize];
	[self updateCaption];
	[self resizeImageViewsWithRect:_scroller.frame];
//	[self layoutButtons];
//	[self arrangeThumbs];
	[self moveScrollerToCurrentIndexWithAnimation:NO];
}

#pragma mark - Private Methods


- (void)resizeImageViewsWithRect:(CGRect)rect
{
	// resize all the image views
	NSUInteger i, count = [_photoViews count];
	float dx = 0;
	for (i = 0; i < count; i++) {
		MaImageGalleryPhotoView * photoView = [_photoViews objectAtIndex:i];
		photoView.frame = CGRectMake(dx, 0, rect.size.width, rect.size.height );
		dx += rect.size.width;
	}
}


- (void)gotoImageByIndex:(NSUInteger)index animated:(BOOL)animated
{
	NSUInteger numPhotos = [_photoSource count];
	
	// constrain index within our limits
    if( index >= numPhotos ) index = numPhotos - 1;
	
	
	if( numPhotos == 0 ) {
		
		// no photos!
		_currentIndex = -1;
	}
	else {
		
		// clear the fullsize image in the old photo
//		[self unloadFullsizeImageWithIndex:_currentIndex];
		
		_currentIndex = index;
		[self moveScrollerToCurrentIndexWithAnimation:animated];
		[self updateTitle];
		
		if( !animated )	{
//			[self preloadThumbnailImages];
//			[self loadFullsizeImageWithIndex:index];
		}
	}
//	[self updateButtons];
//	[self updateCaption];
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
	if([keyPath isEqualToString:@"frame"]) 
	{
		[self layoutViews];
	}
}


- (void)positionInnerContainer
{
	CGRect screenFrame = [[UIScreen mainScreen] bounds];
	CGRect innerContainerRect;
	
	if( self.interfaceOrientation == UIInterfaceOrientationPortrait || self.interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown )
	{//portrait
		innerContainerRect = CGRectMake( 0, _container.frame.size.height - screenFrame.size.height, _container.frame.size.width, screenFrame.size.height );
	}
	else 
	{// landscape
		innerContainerRect = CGRectMake( 0, _container.frame.size.height - screenFrame.size.width, _container.frame.size.width, screenFrame.size.width );
	}
	
	_innerContainer.frame = innerContainerRect;
}


- (void)positionScroller
{
	CGRect screenFrame = [[UIScreen mainScreen] bounds];
	CGRect scrollerRect;
	
	if( self.interfaceOrientation == UIInterfaceOrientationPortrait || self.interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown )
	{//portrait
		scrollerRect = CGRectMake( 0, 0, screenFrame.size.width, screenFrame.size.height );
	}
	else
	{//landscape
		scrollerRect = CGRectMake( 0, 0, screenFrame.size.height, screenFrame.size.width );
	}
	
	_scroller.frame = scrollerRect;
}

- (void)moveScrollerToCurrentIndexWithAnimation:(BOOL)animation
{
	int xp = _scroller.frame.size.width * _currentIndex;
	[_scroller scrollRectToVisible:CGRectMake(xp, 0, _scroller.frame.size.width, _scroller.frame.size.height) animated:animation];
	_isScrolling = animation;
}



@end
