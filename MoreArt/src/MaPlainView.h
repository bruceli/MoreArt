//
//  MaPlainView.h
//  MoreArt
//
//  Created by Thunder on 10/13/12.
//  Copyright (c) 2012 MagicApp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MaDefine.h"

@class MaPlainView,AsyncImageView; 
@protocol MaViewPlainDelegate   //define delegate protocol
- (void) toggleZoom: (UIView *) sender; 
@end //end protocol

@interface MaPlainView : UIView 
{
    MaDouViewType _douViewType;    
//    DTAttributedTextView* _textView;
    UIView* _leftShadowView;
    UIView* _rightShadowView;    
}
@property (nonatomic, weak) id <MaViewPlainDelegate> delegate; //define MaViewPlainDelegate as delegate

@end
