//
//  MaDetailImageViewController.m
//  MoreMusic
//
//  Created by Accthun He on 6/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
#define ZOOM_VIEW_TAG 100
#define ZOOM_STEP 1.5



#import "MaDetailImageViewController.h"

@interface MaDetailImageViewController ()

@end

@implementation MaDetailImageViewController
@synthesize imagePath = _imagePath;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setupViews];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)setupViews
{
    CGRect frame = CGRectMake(0,0,320,375);
    _scrollView = [[UIScrollView alloc]initWithFrame:frame];
    [self.view addSubview:_scrollView];
    _scrollView.delegate = self;
    
    _scrollView.backgroundColor = [UIColor grayColor];
    
    //    UIImageView* imageView = [[UIImageView alloc] initWithImage:image];
    //    [imageView setContentMode:UIViewContentModeScaleAspectFit];
    
    _imageView =  [[AsyncImageView alloc] initWithFrame:frame];
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    _imageView.clipsToBounds = YES;
    _imageView.showActivityIndicator = YES;
    [[AsyncImageLoader sharedLoader] cancelLoadingImagesForTarget:_imageView];
    
    [_scrollView addSubview:_imageView];
    // CGRect frame = CGRectMake(0,0,320,400);
    // [imageView setFrame:frame];
    
    [_imageView setTag:ZOOM_VIEW_TAG];
    
    // add gesture recognizers to the image view
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
    UITapGestureRecognizer *twoFingerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTwoFingerTap:)];
    //test
    [_imageView setMultipleTouchEnabled:YES];
    [_imageView setUserInteractionEnabled:YES];
    //testend
    [doubleTap setNumberOfTapsRequired:2];
    [twoFingerTap setNumberOfTouchesRequired:2];
    
    [_imageView addGestureRecognizer:singleTap];
    [_imageView addGestureRecognizer:doubleTap];
    [_imageView addGestureRecognizer:twoFingerTap];
    
    float minimumScale = [_scrollView frame].size.width  / [_imageView frame].size.width;
    [_scrollView setMinimumZoomScale:minimumScale];
    [_scrollView setZoomScale:minimumScale];
    

}

-(void) setupImage
{
    [_imageView setImageByString:_imagePath];
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

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return [scrollView viewWithTag:ZOOM_VIEW_TAG];
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(float)scale {
    [scrollView setZoomScale:scale+0.01 animated:NO];
    [scrollView setZoomScale:scale animated:NO];
}

#pragma mark TapDetectingImageViewDelegate methods

- (void)handleSingleTap:(UIGestureRecognizer *)gestureRecognizer {
    // single tap does nothing for now
}

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

#pragma mark Utility methods

- (CGRect)zoomRectForScale:(float)scale withCenter:(CGPoint)center {
    
    CGRect zoomRect;
    
    // the zoom rect is in the content view's coordinates. 
    //    At a zoom scale of 1.0, it would be the size of the imageScrollView's bounds.
    //    As the zoom scale decreases, so more content is visible, the size of the rect grows.
    zoomRect.size.height = [_scrollView frame].size.height / scale;
    zoomRect.size.width  = [_scrollView frame].size.width  / scale;
    
    // choose an origin so as to get the right center.
    zoomRect.origin.x    = center.x - (zoomRect.size.width  / 2.0);
    zoomRect.origin.y    = center.y - (zoomRect.size.height / 2.0);
    
    return zoomRect;
}


@end
