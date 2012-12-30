//
//  subViewController.m
//  FlipImage
//
//  Created by Bruce Li on 9/15/12.
//  Copyright (c) 2012 Bruce Li. All rights reserved.
//

#import "subViewController.h"
#import "MaDefine.h"

@interface subViewController ()
{
    BOOL first;
}
@end

@implementation subViewController

@synthesize imageName = _imageName;
@synthesize secondImageName = _secondImageName;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    first = TRUE;
}

-(void)setupImage: (int) index
{
	int heightSize;
	if ([[UIScreen mainScreen] bounds].size.height > 480) {
		heightSize = [[UIScreen mainScreen] bounds].size.height / MA_START_PAGE_ROWXL;
	}
	else
	{
		heightSize = [[UIScreen mainScreen] bounds].size.height / MA_START_PAGE_ROW;
	}
	
	int widthSize = [[UIScreen mainScreen] bounds].size.width / MA_START_PAGE_COL;
	
    CGRect frame = CGRectMake(0,0,widthSize,heightSize);
    
    imageView = [[UIImageView alloc] initWithFrame:frame];
    image = [UIImage imageNamed:_imageName];
    imageView.image = image;

    image = [UIImage imageNamed: _imageName];
    secondImage = [UIImage imageNamed: _secondImageName];
//    imageView = [[UIImageView alloc] initWithImage:image];
    imageView.contentMode = UIViewContentModeScaleToFill;
    
    NSTimer *timer;
	NSInteger min = 10; 
	NSInteger max = 100;
	
	double randNum = (arc4random() % (max - min) + min) ; 
	double time = randNum/100.0f + 1.5f ;
//	NSString *num = [NSString stringWithFormat:@"%f", time]; //Make the number into a string.
//	NSLog(@"randNum is %@", num);

    timer = [NSTimer scheduledTimerWithTimeInterval: time
                                             target: self
                                           selector: @selector(flip:)
                                           userInfo: nil
                                            repeats: NO];
    
    [self.view addSubview:imageView];
}

- (void)flip: (NSTimer *) timer
{
    UIImage* nextImage;
    
    if (first) {
        nextImage = secondImage;
    } else {
        nextImage = image;
    }
    
    first = !first;
    [UIView transitionWithView:imageView
                      duration:0.3
                       options:UIViewAnimationOptionTransitionFlipFromBottom
                    animations:^{ imageView.image = nextImage; }
                    completion:NULL];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
