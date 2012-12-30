//
//  MaCoverFlowView.m
//  MoreArt
//
//  Created by Thunder on 8/25/12.
//  Copyright (c) 2012 MagicApp. All rights reserved.
//

#import "MaCoverFlowView.h"
#import "AsyncImageView.h"

@interface MaCoverFlowView ()
@end


@implementation MaCoverFlowView
@synthesize coverflow,covers;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight;
//        NSLog(@"%@", @"Layout coverFlow View");
        covers = [[NSMutableArray alloc] init ];
		
        self.backgroundColor = [UIColor whiteColor];
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        coverflow = [[TKCoverflowView alloc] initWithFrame:CGRectZero];
        coverflow.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        coverflow.coverflowDelegate = self;
        coverflow.dataSource = self;
		[coverflow setNumberOfCovers:0];
        [self addSubview:coverflow];
		
		
                
     //   detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 200, 460 , 90)];
     //   detailLabel.backgroundColor = [[UIColor darkGrayColor]colorWithAlphaComponent:0.9];
     //   [self addSubview:detailLabel];
    }
    return self;
}

-(void)loadCoverFlowImageBy:(NSArray*)array
{
	_imagePathArray = array;
	[coverflow setNumberOfCovers:[array count]];
}


- (void) coverflowView:(TKCoverflowView*)coverflowView coverAtIndexWasBroughtToFront:(int)index{
//	NSLog(@"Front %d",index);
}

- (TKCoverflowCoverView*) coverflowView:(TKCoverflowView*)coverflowView coverAtIndex:(int)index{
	
	TKCoverflowCoverView *cover = [coverflowView dequeueReusableCoverView];
	
	if(cover == nil){
		CGRect rect = CGRectMake(0, 0, 224, 300);
		cover = [[TKCoverflowCoverView alloc] initWithFrame:rect]; // 224
		cover.baseline = 224;
	}
	
	//if ([covers count]>0)     
	//	cover.image = [covers objectAtIndex:index%[covers count]];
    
	NSDictionary* dict = [_imagePathArray objectAtIndex:index];
	NSString* path = [dict objectForKey:@"imagePath"];
	[[AsyncImageLoader sharedLoader] loadImageWithURL:[NSURL URLWithString:path] target:cover action:@selector(setImage:)];
	
	return cover;
}

- (void) coverflowView:(TKCoverflowView*)coverflowView coverAtIndexWasTappedInFront:(int)index tapCount:(NSInteger)tapCount{
	
//	TKLog(@"Index: %d",index);
	
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
