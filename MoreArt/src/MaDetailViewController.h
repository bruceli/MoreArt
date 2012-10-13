//
//  MaDetailViewController.h
//  MoreArt
//
//  Created by Thunder on 9/2/12.
//  Copyright (c) 2012 MagicApp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MaScrollImageViewController.h"
#import "AsyncImageView.h"
#import "MTLabel.h"

@interface MaDetailViewController : UIViewController <MTLabelDelegate>
{
    UIScrollView* _scrollView;
    AsyncImageView* _avatarImgView;
    
    MaScrollImageViewController* _scrollImageViewController;
    MTLabel* _detail_Label;

//    MTLabel* _bodyLabel;
    UILabel* _endingLabel;
    
    NSIndexPath* _indexPath;
        
    id _currentView;
}

@property (nonatomic, retain) NSIndexPath* indexPath;




@end
