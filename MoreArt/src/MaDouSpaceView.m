//
//  MaDouSpaceView.m
//  MoreMusic
//
//  Created by Accthun He on 5/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MaDouSpaceView.h"
#import "MoreArtAppDelegate.h"

@interface MaDouSpaceView ()

@end

@implementation MaDouSpaceView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _douViewType = DOU_TYPE_DOU_SPACE;
		CGRect bounds = [ [ UIScreen mainScreen ] applicationFrame ];
		CGRect frame = CGRectMake(0, 0, bounds.size.width, bounds.size.height - MA_TOOLBAR_HEIGHT);
		_scrollView = [[UIScrollView alloc ] initWithFrame:frame ];
		_scrollView.alwaysBounceVertical=YES;
		_scrollView.showsVerticalScrollIndicator = NO;
		_scrollView.showsHorizontalScrollIndicator = NO;
		_scrollView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"setting_bkg.png"]];
		[self addSubview:_scrollView ];		
		
		MoreArtAppDelegate* app = (MoreArtAppDelegate *)[[UIApplication sharedApplication] delegate];
		NSArray* itemArray = app.dataSourceMgr.dataSource;
		
		[app.dataSourceMgr updateDataSourceArrayByViewType:_douViewType];
		[self setupViewsFromArray:itemArray to:_scrollView];		
    }
	
    return self;
}

@end
