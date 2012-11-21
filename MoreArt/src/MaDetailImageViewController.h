//
//  MaDetailImageViewController.h
//  MoreMusic
//
//  Created by Accthun He on 6/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"


@interface MaDetailImageViewController : UIViewController <UIScrollViewDelegate>
{
    UIScrollView* _scrollView;
    AsyncImageView* _imageView;
    NSString* _imagePath;
}

-(void)setupImage;

@property (nonatomic, copy) NSString* imagePath;

@end
