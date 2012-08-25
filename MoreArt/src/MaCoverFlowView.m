//
//  MaCoverFlowView.m
//  MoreArt
//
//  Created by Thunder on 8/25/12.
//  Copyright (c) 2012 MagicApp. All rights reserved.
//

#import "MaCoverFlowView.h"

@interface MaCoverFlowView ()
- (void)loadCoverflowView;
@end


@implementation MaCoverFlowView
@synthesize coverflow,covers;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


- (void)loadCoverflowView
{
    covers = [[NSMutableArray alloc] initWithObjects:
              [UIImage imageNamed:@"cover_2.jpg"],[UIImage imageNamed:@"cover_1.jpg"],
              [UIImage imageNamed:@"cover_3.jpg"],[UIImage imageNamed:@"cover_4.jpg"],
              [UIImage imageNamed:@"cover_5.jpg"],[UIImage imageNamed:@"cover_6.jpg"],
              [UIImage imageNamed:@"cover_7.jpg"],[UIImage imageNamed:@"cover_8.jpg"],
              [UIImage imageNamed:@"cover_9.jpeg"],nil];
    
    [coverflow setNumberOfCovers:580];

    CGRect r = [UIScreen mainScreen].bounds;
	r = CGRectApplyAffineTransform(r, CGAffineTransformMakeRotation(90 * M_PI / 180.));
	r.origin = CGPointZero;
	
    self.backgroundColor = [UIColor whiteColor];
	self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	
    r = self.bounds;
	r.size.height = 1000;
	
	coverflow = [[TKCoverflowView alloc] initWithFrame:self.bounds];
	coverflow.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	coverflow.coverflowDelegate = self;
	coverflow.dataSource = self;
	if([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad){
		coverflow.coverSpacing = 100;
		coverflow.coverSize = CGSizeMake(300, 300);
	}
	
//	[self addSubview:coverflow];
	
	
	if([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone){
		
		UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
		btn.frame = CGRectMake(0,0,100,20);
		[btn setTitle:@"# Covers" forState:UIControlStateNormal];
		[btn addTarget:self action:@selector(changeNumberOfCovers) forControlEvents:UIControlEventTouchUpInside];
		[self addSubview:btn];
	}
    /*
    else{
		
		UIBarButtonItem *nocoversitem = [[UIBarButtonItem alloc] initWithTitle:@"# Covers"
                                                                         style:UIBarButtonItemStyleBordered
                                                                        target:self action:@selector(changeNumberOfCovers)];
		
		UIBarButtonItem *flex = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        
		self.toolbarItems = [NSArray arrayWithObjects:flex,nocoversitem,nil];
    }
    */
	
    
	CGSize s = self.bounds.size;
	
	UIButton *infoButton = [UIButton buttonWithType:UIButtonTypeInfoLight];
	[infoButton addTarget:self action:@selector(info) forControlEvents:UIControlEventTouchUpInside];
	infoButton.frame = CGRectMake(s.width-50, 5, 50, 30);
	[self addSubview:infoButton];

    [self addSubview:coverflow];

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/


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

@end
