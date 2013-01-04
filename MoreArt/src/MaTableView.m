//
//  MaTableView.m
//  MoreArt
//
//  Created by Thunder on 8/23/12.
//  Copyright (c) 2012 MagicApp. All rights reserved.
//

#import "MaTableView.h"
#import "MoreArtAppDelegate.h"

@implementation MaTableView

@synthesize douViewType = _douViewType;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    //    _douViewType = 0;
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"setting_bkg1"]];
		[self setSeparatorColor:[UIColor lightGrayColor]];

    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
