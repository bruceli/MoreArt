//
//  MaDouWoView.m
//  MoreMusic
//
//  Created by Accthun He on 5/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MaDouWoView.h"
#import "MoreArtAppDelegate.h"

@interface MaDouWoView ()

@end

@implementation MaDouWoView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _douViewType = DOU_TYPE_DO_WUO;
        _scrollImageViewController = [[MaScrollImageViewController alloc] init];
//        [self addSubview:_scrollImageViewController.view];
        _scrollImageViewController.view.frame = CGRectMake(0, 0, 320, 135);
        self.tableHeaderView = _scrollImageViewController.view;
    }
    return self;
}


@end
