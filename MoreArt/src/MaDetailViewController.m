//
//  MaDetailViewController.m
//  MoreArt
//
//  Created by Thunder on 9/2/12.
//  Copyright (c) 2012 MagicApp. All rights reserved.
//

#import "MaDetailViewController.h"
#import "MoreArtAppDelegate.h"

@interface MaDetailViewController ()
-(void) fillContents;
-(void) adjustViewSize;

@end

@implementation MaDetailViewController
@synthesize indexPath = _indexPath;

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

    CGRect bounds = [ [ UIScreen mainScreen ] applicationFrame ];
    _scrollView = [[UIScrollView alloc ] initWithFrame:bounds ];
    _scrollView.alwaysBounceVertical=YES;
    
    self.view = _scrollView;
    _scrollView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"setting_bkg.png"]];
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 140, 310, 35)];
    _bodyLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, _titleLabel.frame.origin.y + _titleLabel.frame.size.height, 310, 400)];
 
    _titleLabel.backgroundColor = [UIColor darkGrayColor];
    _bodyLabel.backgroundColor = [UIColor darkGrayColor];

    _titleLabel.textColor = [UIColor whiteColor];
    _bodyLabel.textColor = [UIColor greenColor];
    
    _titleLabel.font = [UIFont fontWithName:@"STHeitiTC-Medium" size:20];
    _bodyLabel.font = [UIFont fontWithName:@"STHeitiTC-Light" size:16];

    _bodyLabel.textAlignment = UITextAlignmentLeft;
    _bodyLabel.numberOfLines = 0;
    
    [self.view addSubview:_titleLabel];
    [self.view addSubview:_bodyLabel];

    _scrollImageView = [[MaScrollImageView alloc] initWithFrame: CGRectMake(0, 0, 320, 135)];
    [self.view addSubview:_scrollImageView];
    
    
    // add ending Label
    CGRect rect = _bodyLabel.frame;
    _endingLabel = [[UILabel alloc] initWithFrame:CGRectMake(rect.origin.x, rect.origin.y+rect.size.height+5, 310, 20)];
    _endingLabel.backgroundColor = [UIColor darkGrayColor];
    [self.view addSubview:_endingLabel];
    
    // set scroll view size
    CGSize viewSize = CGSizeMake(_titleLabel.frame.size.width, _endingLabel.frame.origin.y+_endingLabel.frame.size.height+10);

    _scrollView.contentSize = viewSize;
    

    [self fillContents];
    [self adjustViewSize];
    
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"UIDeviceOrientationDidChangeNotification" object:nil];

//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationChanged:) name:@"UIDeviceOrientationDidChangeNotification" object:nil];

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void) fillContents
{
    MoreArtAppDelegate* app = (MoreArtAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSDictionary* dict = [app.dataSourceMgr.dataSource objectAtIndex: _indexPath.row];
    _titleLabel.text = [dict objectForKey:@"title"];
    _bodyLabel.text = [dict objectForKey:@"detail"];
    
    // BodyLabel resize here
    [_bodyLabel sizeToFit];
}


-(void)adjustViewSize
{

}

- (void) orientationChanged:(id)object
{
	UIInterfaceOrientation interfaceOrientation = [[object object] orientation];
    MoreArtAppDelegate* app = (MoreArtAppDelegate *)[[UIApplication sharedApplication] delegate];
    
	if (interfaceOrientation == UIInterfaceOrientationPortrait ||interfaceOrientation ==  UIInterfaceOrientationPortraitUpsideDown)
	{
        if (_currentView)
        {
            self.view = _currentView;
            self.navigationController.navigationBarHidden = NO;
            //            NSLog(@"%@", @"==== portrait");
        }
        
	}
	else if(interfaceOrientation == UIDeviceOrientationLandscapeRight|| interfaceOrientation == UIDeviceOrientationLandscapeLeft)
	{
        if (app.coverFlowView != self.view) {
            //            NSLog(@"%@", @"==== landScape Mode");
            _currentView = self.view;
        }
        self.view = app.coverFlowView;
        self.navigationController.navigationBarHidden = YES;
        
        
	}
}


@end
