//
//  MaEZCell.h
//  MoreMusic
//
//  Created by Accthun He on 6/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"

@interface MaEZCell : UITableViewCell
{
    NSString* _titleString;
    NSString* _discriptionString;

    NSString* _imgName;
    
    UILabel* _titleLabel;
    UILabel* _detailLabel;
    AsyncImageView* _imgView;
    BOOL _rightLayout;
}

@property (nonatomic, copy) NSString *titleString;
@property (nonatomic, copy) NSString *discriptionString;
@property (nonatomic, copy) NSString *imgName;
@property (nonatomic) BOOL rightLayout;

@end
