//
//  MaCoverFlowView.m
//  MoreArt
//
//  Created by Thunder on 8/25/12.
//  Copyright (c) 2012 MagicApp. All rights reserved.
//

#import "MaCoverFlowView.h"

@interface MaCoverFlowView ()
@end


@implementation MaCoverFlowView
@synthesize coverflow,covers;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight;
        NSLog(@"%@", @"Layout coverFlow View");
        covers = [[NSMutableArray alloc] initWithObjects:
                  [UIImage imageNamed:@"cover_2.jpg"],[UIImage imageNamed:@"cover_1.jpg"],
                  [UIImage imageNamed:@"cover_3.jpg"],[UIImage imageNamed:@"cover_4.jpg"],
                  [UIImage imageNamed:@"cover_5.jpg"],[UIImage imageNamed:@"cover_6.jpg"],
                  [UIImage imageNamed:@"cover_7.jpg"],[UIImage imageNamed:@"cover_8.jpg"],
                  [UIImage imageNamed:@"cover_9.jpeg"],nil];
        
        
        CGRect r = [UIScreen mainScreen].bounds;
        r = CGRectApplyAffineTransform(r, CGAffineTransformMakeRotation(90 * M_PI / 180.));
        r.origin = CGPointZero;
        
        self.backgroundColor = [UIColor whiteColor];
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        
        CGRect theRect =  CGRectMake(0, 0, 0, 0);
        
        coverflow = [[TKCoverflowView alloc] initWithFrame:theRect];
        coverflow.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        coverflow.coverflowDelegate = self;
        coverflow.dataSource = self;
        [coverflow setNumberOfCovers:20];

        [self addSubview:coverflow];

    }
    return self;
}



- (void) coverflowView:(TKCoverflowView*)coverflowView coverAtIndexWasBroughtToFront:(int)index{
	NSLog(@"Front %d",index);
}

- (TKCoverflowCoverView*) coverflowView:(TKCoverflowView*)coverflowView coverAtIndex:(int)index{
	
	TKCoverflowCoverView *cover = [coverflowView dequeueReusableCoverView];
	
	if(cover == nil){
		CGRect rect = CGRectMake(0, 0, 224, 300);
		cover = [[TKCoverflowCoverView alloc] initWithFrame:rect]; // 224
		cover.baseline = 224;
	}
    
	cover.image = [covers objectAtIndex:index%[covers count]];
    
	return cover;
	
}

- (void) coverflowView:(TKCoverflowView*)coverflowView coverAtIndexWasTappedInFront:(int)index tapCount:(NSInteger)tapCount{
	
	TKLog(@"Index: %d",index);
	
	if(tapCount<2) return;
    
	TKCoverflowCoverView *cover = [coverflowView coverAtIndex:index];
	if(cover == nil) return;
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:1];
	[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:cover cache:YES];
	[UIView commitAnimations];
	
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
