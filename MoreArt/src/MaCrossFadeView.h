//
//  MaCrossFadeView.h
//  MoreArt
//
//  Created by Thunder on 9/2/12.
//  Copyright (c) 2012 MagicApp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MaCrossFadeView : UIView <UIGestureRecognizerDelegate>
{
    UIImageView* _imageView;
    UIImage* _image;
    
    NSMutableArray* _leftArray;
    NSMutableArray* _rightArray;
    
    UIPanGestureRecognizer* _panGesture;
    
}

-(void) startAnimat;

@end
