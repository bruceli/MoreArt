//
//  MaImageArrayView.h
//  MoreArt
//
//  Created by Thunder on 11/8/12.
//  Copyright (c) 2012 MagicApp. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MaImageArrayView;

@protocol MaImageArrayViewDelegate
-(void)toggleZoom:(UIView*) sender;
@end //end protocol

@interface MaImageArrayView : UIScrollView
{
    NSMutableArray* _imageViewArray;
    NSArray* _imageArray;
}

-(void)loadImagesBy: (NSArray*)array;

@property (nonatomic, weak) id <MaImageArrayViewDelegate> img_delegate;
@property (nonatomic, retain) NSArray* imageArray;
@property (nonatomic, readonly) NSMutableArray* imageViewArray;

@end
