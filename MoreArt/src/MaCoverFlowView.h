//
//  MaCoverFlowView.h
//  MoreArt
//
//  Created by Thunder on 8/25/12.
//  Copyright (c) 2012 MagicApp. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TKGlobal.h"
#import "TKCoverflowView.h"
#import "TKCoverflowCoverView.h"

@interface MaCoverFlowView : UIView <TKCoverflowViewDelegate, TKCoverflowViewDataSource, UIScrollViewDelegate>
{
	TKCoverflowView *coverflow;
	NSMutableArray *covers; // album covers images
	BOOL collapsed;

}

@property (retain,nonatomic) TKCoverflowView *coverflow;
@property (retain,nonatomic) NSMutableArray *covers;

@end
