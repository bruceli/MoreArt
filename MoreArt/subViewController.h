//
//  subViewController.h
//  FlipImage
//
//  Created by Bruce Li on 9/15/12.
//  Copyright (c) 2012 Bruce Li. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface subViewController : UIViewController
{
    NSString* _imageName;
    NSString* _secondImageName;
 
    UIImage* image;
    UIImage* secondImage;
    UIImageView* imageView;
}

@property (nonatomic, copy) NSString* imageName;
@property (nonatomic, copy) NSString* secondImageName;


- (void)setupImage: (int) index;
- (void)flip: (NSTimer *) timer;

@end
