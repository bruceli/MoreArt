//
//  MaStartPageController.m
//  MoreArt
//
//  Created by Thunder on 12/28/12.
//  Copyright (c) 2012 MagicApp. All rights reserved.
//

#import "MaStartPageController.h"
#import "subViewController.h"
#import "MaDefine.h"
#import "MoreArtAppDelegate.h"


@implementation subView

@synthesize rows;
@synthesize columns;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


- (void)layoutSubviews
{
    int widthSize = [[UIScreen mainScreen] bounds].size.width / columns;
    int heightSize = [[UIScreen mainScreen] bounds].size.height / rows;
    int index = 0;
    for (int y = 0; y < rows; ++y) {
        for (int x = 0; x < columns; ++x) {
            UIView *subview = [self.subviews objectAtIndex:index++];
            subview.frame = CGRectMake(x * widthSize, y * heightSize, widthSize, heightSize);
		//	NSLog(@"SubView frame is %@",NSStringFromCGRect(subview.frame));
        }
    }
}
@end

@interface MaStartPageController ()

@end

@implementation MaStartPageController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	int rows;
	int columns = MA_START_PAGE_COL;
	int backsideImageNO = 1;
	
	if ([[UIScreen mainScreen] bounds].size.height > 480) 
	{
		rows = MA_START_PAGE_ROWXL	
	}
	else
	{
		rows = MA_START_PAGE_ROW;
		backsideImageNO = 5;
	}
	
	subView *containerView = [[subView alloc] init];
	[self.view addSubview: containerView];
	containerView.rows = rows;
	containerView.columns = columns;
	containerView.contentMode = UIViewContentModeScaleAspectFill;

	for (int i = 0; i < columns * rows; ++i)
	{
		subViewController *subController = [[subViewController alloc] init];
		subController.view.backgroundColor = [UIColor colorWithWhite:50 alpha:0.3];

		NSInteger min = 10; 
		NSInteger max = 100;

		NSInteger randNum = (arc4random() % (max - min) + min) ; 
		NSString *numString = [NSString stringWithFormat:@"%d", randNum];
		NSString *backsideNOString = [NSString stringWithFormat:@"%d", backsideImageNO];
		
		NSMutableString* fileName = [NSMutableString stringWithString: @"/launchIMG/squareIMG"];
		NSMutableString* backsideName = [NSMutableString stringWithString: @"/launchIMG/backside"];
		[fileName appendString:numString];
		[fileName appendString:@".jpg"];
		[backsideName appendString:backsideNOString];
		[backsideName appendString:@".png"];

		//NSLog(@"File named %@",backsideName);
		subController.imageName = fileName;
		subController.secondImageName = backsideName;
		[subController setupImage: i];
		[containerView addSubview:subController.view];
		backsideImageNO++;
	}
}

-(void) viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	NSLog(@"%@",@"StartPage did appear. ");

	MoreArtAppDelegate* app = (MoreArtAppDelegate *)[[UIApplication sharedApplication] delegate];
	[app startAnimationCounting];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
