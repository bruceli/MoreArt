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
    }
	
    return self;
}

@end
