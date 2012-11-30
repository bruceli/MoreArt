//
//  MaScaleImageView.h
//  MoreArt
//
//  Created by Thunder on 11/30/12.
//  Copyright (c) 2012 MagicApp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"
@protocol MaScaleImageViewDelegate
-(void)toggleZoom:()view;
@end 

@interface MaScaleImageView : UIScrollView <UIScrollViewDelegate, AsyncImageViewDelegate>
{
	AsyncImageView* _imageView;
}

-(void)loadImageFrom:(NSString*)imgPath;
@property (nonatomic, weak) id <MaScaleImageViewDelegate> _scaleImageViewDelegate; 


@end
