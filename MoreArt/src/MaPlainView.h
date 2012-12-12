//
//  MaPlainView.h
//  MoreArt
//
//  Created by Thunder on 10/13/12.
//  Copyright (c) 2012 MagicApp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MaDefine.h"
#import "AsyncImageView.h"
#import "MaScaleImageView.h"


@class MaPlainView; 
@protocol MaViewPlainDelegate   
- (void) toggleZoom: (UIView *) sender; 
@end 

@interface MaPlainView : UIView <DTAttributedTextContentViewDelegate,AsyncImageViewDelegate,MaScaleImageViewDelegate> 
{
    MaDouViewType _douViewType;
	AsyncImageView* _hiddenView;
	MaScaleImageView* _scaleImageView;
}

@property (nonatomic, weak) id <MaViewPlainDelegate> delegate; //define MaViewPlainDelegate as delegate

-(void)setupViewsFromArray:(NSArray*)itemArray to:(UIScrollView*)scrollView;
@end
