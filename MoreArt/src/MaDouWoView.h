//
//  MaDouWoView.h
//  MoreMusic
//
//  Created by Accthun He on 5/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MaPlainView.h"
#import "MaScaleImageView.h"

@interface MaDouWoView : MaPlainView <DTAttributedTextContentViewDelegate,MaScaleImageViewDelegate,AsyncImageViewDelegate>
{
//	NSInteger _currentPageIndex;
    UIScrollView* _scrollView;
	AsyncImageView* _hiddenView;
	MaScaleImageView* _scaleImageView;

//	DTAttributedTextView* _textView;
}


@end
