//
//  MaImageGalleryViewController.h
//  MoreArt
//
//  Created by Thunder on 12/20/12.
//  Copyright (c) 2012 MagicApp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MaImageGalleryPhotoView.h"

@interface MaImageGalleryViewController : UIViewController <UIScrollViewDelegate,MaImageGalleryPhotoViewDelegate>
{
	UIView *_container; // used as view for the controller
	UIView *_innerContainer; // sized and placed to be fullscreen within the container
//	UIToolbar *_toolbar;
//	UIScrollView *_thumbsView;
	UIScrollView *_scroller;
	UIView *_captionContainer;
	UILabel *_caption;

	NSInteger _currentIndex;
//	BOOL _isThumbViewShowing;

	
	NSMutableArray *_photoViews;
	NSArray* _photoSource;
	
	BOOL _isFullscreen;
	BOOL _isScrolling;
	BOOL _isActive;

}

@property NSInteger startingIndex;
@property (nonatomic,retain) NSArray* photoSource;
- (id)initWithPhotoSource:(NSArray*)photoSrc;

@end
