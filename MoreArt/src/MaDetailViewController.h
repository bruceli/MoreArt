//
//  MaDetailViewController.h
//  MoreArt
//
//  Created by Thunder on 9/2/12.
//  Copyright (c) 2012 MagicApp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MaDetailViewController : UIViewController
{
    UIScrollView* _scrollView;
    UIImageView* _imgView;
    
    UILabel* _titleLabel;
    UILabel* _headerLabel;
    UILabel* _bodyLabel;
    UILabel* _endingLabel;
}


@end
