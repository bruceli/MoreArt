//
//  MaArtistViewController.m
//  MoreArt
//
//  Created by Thunder on 8/19/12.
//  Copyright (c) 2012 MagicApp. All rights reserved.
//

#import "MaArtistViewController.h"

@interface MaArtistViewController ()
- (void)loadCoverflowView;
@end

@implementation MaArtistViewController
@synthesize coverflow,covers;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight;
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Artist" image:[UIImage imageNamed:@"clock"] tag:0];    }
    return self;
}

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	if([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone)
		return (interfaceOrientation == UIInterfaceOrientationLandscapeRight);
	return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    covers = [[NSMutableArray alloc] initWithObjects:
              [UIImage imageNamed:@"cover_2.jpg"],[UIImage imageNamed:@"cover_1.jpg"],
              [UIImage imageNamed:@"cover_3.jpg"],[UIImage imageNamed:@"cover_4.jpg"],
              [UIImage imageNamed:@"cover_5.jpg"],[UIImage imageNamed:@"cover_6.jpg"],
              [UIImage imageNamed:@"cover_7.jpg"],[UIImage imageNamed:@"cover_8.jpg"],
              [UIImage imageNamed:@"cover_9.jpeg"],nil];
    
    [coverflow setNumberOfCovers:580];


//    [self loadCoverflowView];
//    [self.view addSubview:coverflow];

}
- (void) viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque];
}

- (void) loadView{
	
	CGRect r = [UIScreen mainScreen].bounds;
	r = CGRectApplyAffineTransform(r, CGAffineTransformMakeRotation(90 * M_PI / 180.));
	r.origin = CGPointZero;
	
	self.view = [[UIView alloc] initWithFrame:r];
    self.view.backgroundColor = [UIColor whiteColor];
	self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	
    r = self.view.bounds;
	r.size.height = 1000;
	
	coverflow = [[TKCoverflowView alloc] initWithFrame:self.view.bounds];
	coverflow.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	coverflow.coverflowDelegate = self;
	coverflow.dataSource = self;
	if([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad){
		coverflow.coverSpacing = 100;
		coverflow.coverSize = CGSizeMake(300, 300);
	}
	
	[self.view addSubview:coverflow];
	
	
	if([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone){
		
		UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
		btn.frame = CGRectMake(0,0,100,20);
		[btn setTitle:@"# Covers" forState:UIControlStateNormal];
		[btn addTarget:self action:@selector(changeNumberOfCovers) forControlEvents:UIControlEventTouchUpInside];
		[self.view addSubview:btn];
	}else{
		
		UIBarButtonItem *nocoversitem = [[UIBarButtonItem alloc] initWithTitle:@"# Covers"
                                                                         style:UIBarButtonItemStyleBordered
                                                                        target:self action:@selector(changeNumberOfCovers)];
		
		UIBarButtonItem *flex = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        
		self.toolbarItems = [NSArray arrayWithObjects:flex,nocoversitem,nil];
    }
    
	
    
	CGSize s = self.view.bounds.size;
	
	UIButton *infoButton = [UIButton buttonWithType:UIButtonTypeInfoLight];
	[infoButton addTarget:self action:@selector(info) forControlEvents:UIControlEventTouchUpInside];
	infoButton.frame = CGRectMake(s.width-50, 5, 50, 30);
	[self.view addSubview:infoButton];
}

- (void) viewDidAppear:(BOOL)animated{
	[super viewDidAppear:animated];
	[coverflow bringCoverAtIndexToFront:[covers count]*2 animated:NO];
}

- (void) viewWillDisappear:(BOOL)animated{
	[super viewWillDisappear:animated];
	[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadCoverflowView
{

	CGRect r = [UIScreen mainScreen].bounds;
	r = CGRectApplyAffineTransform(r, CGAffineTransformMakeRotation(90 * M_PI / 180.));
	r.origin = CGPointZero;
	
	self.view = [[UIView alloc] initWithFrame:r];
	
	
    self.view.backgroundColor = [UIColor whiteColor];
	self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	
	
	r = self.view.bounds;
	r.size.height = 1000;
	
	coverflow = [[TKCoverflowView alloc] initWithFrame:self.view.bounds];
	coverflow.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	coverflow.coverflowDelegate = self;
	coverflow.dataSource = self;
	if([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad){
		coverflow.coverSpacing = 100;
		coverflow.coverSize = CGSizeMake(300, 300);
	}
    
    CGSize s = self.view.bounds.size;
	
	UIButton *infoButton = [UIButton buttonWithType:UIButtonTypeInfoLight];
	[infoButton addTarget:self action:@selector(info) forControlEvents:UIControlEventTouchUpInside];
	infoButton.frame = CGRectMake(s.width-50, 5, 50, 30);
	[self.view addSubview:infoButton];

}

- (void) info{
	
	if([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone)
		[self dismissModalViewControllerAnimated:YES];
	else{
		
		CGRect rect = self.view.bounds;
        
		
		if(!collapsed)
			rect = CGRectInset(rect, 100, 100);
		self.coverflow.frame = rect;
		
		collapsed = !collapsed;
        
	}
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

@end
