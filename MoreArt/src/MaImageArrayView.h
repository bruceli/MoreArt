//
//  MaImageArrayView.h
//  MoreArt
//
//  Created by Thunder on 11/8/12.
//  Copyright (c) 2012 MagicApp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MaImageArrayView : UIScrollView
{
    NSMutableArray* _imageViewArray;
    NSArray* _imageArray;
}
-(void)loadImagesBy: (NSArray*)array;


@property (nonatomic, retain) NSArray* imageArray;

@end
