//
//  MaScrollImageView.h
//  MoreArt
//
//  Created by Thunder on 9/15/12.
//  Copyright (c) 2012 MagicApp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MaScrollImageView : UIScrollView
{
    UIScrollView* _scrollView;
    NSInteger _imageCount;
    NSArray* _imageArray;
}

@property (nonatomic, retain) UIScrollView*   scrollView;
@property (nonatomic, retain) NSArray*   imageArray;

//-(void)addImageWith:(NSString*)imagePath;


@end
