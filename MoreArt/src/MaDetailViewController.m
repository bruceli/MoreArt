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
    _avatarImgView = [[AsyncImageView alloc] initWithFrame:CGRectMake(0,140, 85, 85)];
    
    _avatarImgView.contentMode = UIViewContentModeScaleAspectFill;
    _avatarImgView.clipsToBounds = YES;
    _avatarImgView.showActivityIndicator = YES;

    [[AsyncImageLoader sharedLoader] cancelLoadingImagesForTarget:_avatarImgView];
    
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(_avatarImgView.frame.origin.x + _avatarImgView.frame.size.width+5, 140, 220, 35)];

    _header_S_Label = [[MTLabel alloc] initWithFrame:CGRectMake(_titleLabel.frame.origin.x, _titleLabel.frame.origin.y+_titleLabel.frame.size.height+5  , 225, 35)];
    
    _header_L_Label = [[MTLabel alloc] initWithFrame:CGRectMake(5, _avatarImgView.frame.origin.y + _avatarImgView.frame.size.height+5, 315, 100)];

//    _bodyLabel = [[MTLabel alloc] initWithFrame:CGRectMake(5, _header_L_Label.frame.origin.y + _header_L_Label.frame.size.height+5 , 310, 100)];
 
    _titleLabel.backgroundColor = [UIColor clearColor];
    _header_S_Label.backgroundColor = [UIColor redColor];
    _header_L_Label.backgroundColor = [UIColor clearColor];
//    _bodyLabel.backgroundColor = [UIColor darkGrayColor];
    _avatarImgView.backgroundColor = [UIColor brownColor];
    
    _header_S_Label.resizeToFitText = YES;
    _header_L_Label.resizeToFitText = YES;

    
//    _bodyLabel.resizeToFitText = YES;
    

    _titleLabel.textColor = [UIColor whiteColor];
    
    _header_S_Label.fontColor = [UIColor whiteColor];
    _header_L_Label.fontColor = [UIColor whiteColor];
//    _bodyLabel.fontColor = [UIColor greenColor];

    _titleLabel.font = [UIFont fontWithName:@"STHeitiTC-Medium" size:23];
    _header_S_Label.font = [UIFont fontWithName:@"STHeitiTC-Light" size:17];
    _header_L_Label.font = [UIFont fontWithName:@"STHeitiTC-Light" size:17];
//    _bodyLabel.font = [UIFont fontWithName:@"STHeitiTC-Light" size:17];

    _header_S_Label.textAlignment = MTLabelTextAlignmentLeft;
    _header_L_Label.textAlignment = MTLabelTextAlignmentLeft;
//    _bodyLabel.textAlignment = MTLabelTextAlignmentLeft;
    
    //_header_L_Label.delegate = self;
    //_bodyLabel.delegate = self;

    _header_S_Label.numberOfLines = 0;
    _header_L_Label.numberOfLines = 0;
//    _bodyLabel.numberOfLines = 0;
    
    _header_S_Label.lineHeight = MA_SUB_DETAIL_LINE_HEIGHT;
    _header_L_Label.lineHeight = MA_SUB_DETAIL_LINE_HEIGHT;
//    _bodyLabel.lineHeight = 25;

    [self.view addSubview:_titleLabel];
    [self.view addSubview:_header_S_Label];
    [self.view addSubview:_header_L_Label];
//    [self.view addSubview:_bodyLabel];
    [self.view addSubview:_avatarImgView];

    MoreArtAppDelegate* app = (MoreArtAppDelegate *)[[UIApplication sharedApplication] delegate];
    // Load data from MGR
    NSDictionary* dict = [app.dataSourceMgr.dataSource objectAtIndex: _indexPath.row];
    _scrollImageViewController = [[MaScrollImageViewController alloc] init];
    [_scrollImageViewController setScrollingImagesBy:[dict objectForKey:@"imageArray"]];

    [self.view addSubview:_scrollImageViewController.view];

//    _scrollImageView = [[MaScrollImageView alloc] initWithFrame: CGRectMake(0, 0, 320, 135)];
//    [self.view addSubview:_scrollImageView];
    
    
    // add ending Label
    CGRect rect = _header_L_Label.frame;
    _endingLabel = [[UILabel alloc] initWithFrame:CGRectMake(rect.origin.x, rect.origin.y+rect.size.height+5, 310, 20)];
    _endingLabel.backgroundColor = [UIColor darkGrayColor];
//    [self.view addSubview:_endingLabel];
    
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
    
    // Load data from MGR
    NSDictionary* dict = [app.dataSourceMgr.dataSource objectAtIndex: _indexPath.row];
    
    // Fill scrollerImage
    
    NSString* imgName = [dict objectForKey:@"avatar"];
    // Fill IMG
    [_avatarImgView setImageByString:imgName];

    
    // Fill TXT
    _titleLabel.text = [dict objectForKey:@"title"];
//    _bodyLabel.text = [dict objectForKey:@"detail"];

    // Split text
    NSString* headerText = [dict objectForKey:@"discription"];
    _header_S_Label.text = [headerText substringWithRange:NSMakeRange(0, MA_SUB_DETAIL_HEADER_LINE_COUNT*2)];
    NSString* bottomString = [headerText substringFromIndex:MA_SUB_DETAIL_HEADER_LINE_COUNT*2] ;
    [bottomString stringByAppendingString:[dict objectForKey:@"detail"]];
    _header_L_Label.text = bottomString;
    
}


-(void)adjustViewSize
{
    CGRect Lframe = _header_L_Label.frame;
    NSInteger lineCount = _header_L_Label.text.length/MA_SUB_DETAIL_TEXT_PER_LINE;
    
    CGRect newFrame = CGRectMake(Lframe.origin.x, Lframe.origin.y, Lframe.size.width, lineCount*MA_SUB_DETAIL_LINE_HEIGHT);
    
    _header_L_Label.frame = newFrame;
    
    _scrollView.contentSize = CGSizeMake(_scrollView.contentSize.width, _scrollView.contentSize.height+newFrame.size.height-Lframe.size.height);
    
    //CGFloat delta = newFrame.size.height-Lframe.size.height;
    //height = 25/line
    // 
    
    
//    CGRect rect = CGRectMake(_bodyLabel.frame.origin.x, _header_L_Label.frame.origin.y+_header_L_Label.frame.size.height,_bodyLabel.frame.size.width, _bodyLabel.frame.size.width);
//    _bodyLabel.frame = rect;
    
    
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
