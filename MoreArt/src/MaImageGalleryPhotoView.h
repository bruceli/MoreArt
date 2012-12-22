//
//  MaImageGalleryPhotoView.h
//  MoreArt
//
//  Created by Thunder on 12/20/12.
//  Copyright (c) 2012 MagicApp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"

@protocol MaImageGalleryPhotoViewDelegate;

@interface MaImageGalleryPhotoView : UIScrollView <UIScrollViewDelegate,AsyncImageViewDelegate>
{
	AsyncImageView* _imageView;
	BOOL _isZoomed;
	UIButton *_button;
	NSTimer *_tapTimer;
	NSObject <MaImageGalleryPhotoViewDelegate>* _photoDelegate;
}
- (id)initWithFrame:(CGRect)frame target:(id)target action:(SEL)action;
- (void)resetZoom;

@property (nonatomic, weak) NSObject <MaImageGalleryPhotoViewDelegate> *photoDelegate;
@property (nonatomic,readonly) AsyncImageView* imageView;
@property (nonatomic,readonly) UIButton* button;

@end


@protocol MaImageGalleryPhotoViewDelegate

// indicates single touch and allows controller repsond and go toggle fullscreen
- (void)didTapPhotoView:(MaImageGalleryPhotoView*)photoView;

@end