//
//  MaDetailViewController.h
//  MoreArt
//
//  Created by Thunder on 9/2/12.
//  Copyright (c) 2012 MagicApp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"
#import "MaImageArrayView.h"


@interface MaDetailViewController : UIViewController <DTAttributedTextContentViewDelegate,MaImageArrayViewDelegate,UIScrollViewDelegate>
{
    UIScrollView* _scrollView;
    
    AsyncImageView* _headerImageView;
    MaImageArrayView* _imageGroupView;
    
    DTAttributedTextView* _textView;
    
    NSIndexPath* _indexPath;
	AsyncImageView* _hiddenView;
	UIScrollView* _scrollableImageView;

    id _currentView;
}

@property (nonatomic, retain) NSIndexPath* indexPath;




@end
