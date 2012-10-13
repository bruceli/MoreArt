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
    
    MoreArtAppDelegate* app = (MoreArtAppDelegate *)[[UIApplication sharedApplication] delegate];
    // Load data from MGR

    NSDictionary* dict = [app.dataSourceMgr.dataSource objectAtIndex: _indexPath.row];
    _scrollImageViewController = [[MaScrollImageViewController alloc] init];
    [_scrollImageViewController setScrollingImagesBy:[dict objectForKey:@"imageArray"]];
    [self.view addSubview:_scrollImageViewController.view];

/*    _avatarImgView = [[AsyncImageView alloc] initWithFrame:CGRectMake(0,140, 85, 85)];
    _avatarImgView.contentMode = UIViewContentModeScaleAspectFill;
    _avatarImgView.clipsToBounds = YES;
 _avatarImgView.showActivityIndicator = YES;
    [[AsyncImageLoader sharedLoader] cancelLoadingImagesForTarget:_avatarImgView];*/
    
    _detail_Label = [[MTLabel alloc] initWithFrame:CGRectMake(20, 150, 280, 100)];
    _detail_Label.backgroundColor = [UIColor clearColor];
    _detail_Label.resizeToFitText = YES;
    _detail_Label.fontColor = [UIColor whiteColor];
    _detail_Label.font = [UIFont fontWithName:@"STHeitiTC-Light" size:14];
    _detail_Label.textAlignment = MTLabelTextAlignmentLeft;
    _detail_Label.numberOfLines = 0;
    _detail_Label.lineHeight = MA_SUB_DETAIL_LINE_HEIGHT;
    [self.view addSubview:_detail_Label];


/*    // add ending Label
    CGRect rect = _detail_Label.frame;
    _endingLabel = [[UILabel alloc] initWithFrame:CGRectMake(rect.origin.x, rect.origin.y+rect.size.height+5, 310, 20)];
    _endingLabel.backgroundColor = [UIColor darkGrayColor];
    [self.view addSubview:_endingLabel];    */
    
    // set scroll view size
//    CGSize viewSize = CGSizeMake(320, _endingLabel.frame.origin.y+_endingLabel.frame.size.height+10);
//    _scrollView.contentSize = viewSize;

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
//    _titleLabel.text = [dict objectForKey:@"title"];
//    _bodyLabel.text = [dict objectForKey:@"detail"];

    // Split text
    NSString* headerText = [dict objectForKey:@"discription"];
//    _header_S_Label.text = [headerText substringWithRange:NSMakeRange(0, MA_SUB_DETAIL_HEADER_LINE_COUNT*2)];
//    NSString* bottomString = [headerText substringFromIndex:MA_SUB_DETAIL_HEADER_LINE_COUNT*2] ;
    [headerText stringByAppendingString:[dict objectForKey:@"detail"]];
    _detail_Label.text = headerText;
    
}


-(void)adjustViewSize
{
    CGRect Lframe = _detail_Label.frame;
    NSInteger lineCount = _detail_Label.text.length/MA_SUB_DETAIL_TEXT_PER_LINE;
    
    CGRect newFrame = CGRectMake(Lframe.origin.x, Lframe.origin.y, Lframe.size.width, lineCount*MA_SUB_DETAIL_LINE_HEIGHT);
    
    _detail_Label.frame = newFrame;
    
    _scrollView.contentSize = CGSizeMake(_scrollView.contentSize.width, _scrollView.contentSize.height+newFrame.size.height-Lframe.size.height);
    
    //CGFloat delta = newFrame.size.height-Lframe.size.height;
    //height = 25/line
    // 
    
    
//    CGRect rect = CGRectMake(_bodyLabel.frame.origin.x, _detail_Label.frame.origin.y+_detail_Label.frame.size.height,_bodyLabel.frame.size.width, _bodyLabel.frame.size.width);
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
