//
//  subViewController.m
//  FlipImage
//
//  Created by Bruce Li on 9/15/12.
//  Copyright (c) 2012 Bruce Li. All rights reserved.
//

#import "subViewController.h"

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
    CGRect frame = CGRectMake(0,0,79,90);
    
    imageView = [[UIImageView alloc] initWithFrame:frame];
    image = [UIImage imageNamed:_imageName];
    imageView.image = image;

    image = [UIImage imageNamed: _imageName];
    secondImage = [UIImage imageNamed: _secondImageName];
//    imageView = [[UIImageView alloc] initWithImage:image];
    imageView.contentMode = UIViewContentModeScaleToFill;
    
    NSTimer *timer;
    double time = index / 5.0 + 2.5;
    NSLog(@"index is %d", index);
    NSLog(@"time is %f", time);
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
                      duration:0.5
                       options:UIViewAnimationOptionTransitionFlipFromBottom
                    animations:^{ imageView.image = nextImage; }
                    completion:NULL];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
