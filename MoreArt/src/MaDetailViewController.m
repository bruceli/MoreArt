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
        // preload
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
    
    //    MoreArtAppDelegate* app = (MoreArtAppDelegate *)[[UIApplication sharedApplication] delegate];
    // Load data from MGR
    
    //    NSDictionary* dict = [app.dataSourceMgr.dataSource objectAtIndex: _indexPath.row];
    
    _headerImageView = [[AsyncImageView alloc] initWithFrame:CGRectMake(0,0, 320, 190)];
    _headerImageView.contentMode = UIViewContentModeScaleAspectFill;
    _headerImageView.clipsToBounds = YES;
    _headerImageView.showActivityIndicator = YES;
    [[AsyncImageLoader sharedLoader] cancelLoadingImagesForTarget:_headerImageView];
    [self.view addSubview:_headerImageView];
    
    _imageGroupView = [[MaImageArrayView alloc] initWithFrame:CGRectMake(0, 195, 320, 68)];
    _imageGroupView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:_imageGroupView];
    
	_textView = [[DTAttributedTextView alloc] initWithFrame:CGRectMake(10, 260, 300, 100)];
    //	_textView.textDelegate = self;
	_textView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    _textView.backgroundColor = [UIColor clearColor];
	[self.view addSubview:_textView];
    
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
    [_headerImageView setImageByString:imgName];
    //[_headerImageView setImage:[UIImage imageNamed:@"1.jpg"]];
    
    // example for setting a willFlushCallback, that gets called before elements are written to the generated attributed string
	void (^callBackBlock)(DTHTMLElement *element) = ^(DTHTMLElement *element) {
		// if an element is larger than twice the font size put it in it's own block
		if (element.displayStyle == DTHTMLElementDisplayStyleInline && element.textAttachment.displaySize.height > 2.0 * element.fontDescriptor.pointSize)
		{
			element.displayStyle = DTHTMLElementDisplayStyleBlock;
		}
	};
    // Fill TXT
    //    _textView.text = [dict objectForKey:@"detail"];
    NSString *detailStr = [dict objectForKey:@"detail"];
    NSLog(@"%@",detailStr);
    
    NSData *data = [detailStr dataUsingEncoding:NSUTF8StringEncoding];
    CGSize maxImageSize = CGSizeMake(self.view.bounds.size.width - 20.0, self.view.bounds.size.height - 20.0);
    
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithFloat:1.0],
                             NSTextSizeMultiplierDocumentOption,
                             [NSValue valueWithCGSize:maxImageSize],
                             DTMaxImageSize,
                             @"STHeitiSC-Light",
                             DTDefaultFontFamily,
                             @"",
                             DTDefaultLinkColor,
                             callBackBlock,
                             DTWillFlushBlockCallBack,
                             nil];
    
	NSAttributedString *string = [NSAttributedString alloc];
    string = [string initWithHTMLData:data options:options documentAttributes:NULL];
    
	_textView.attributedString = string;
    
}


-(void)adjustViewSize
{
    CGSize textViewSize = [_textView.contentView suggestedFrameSizeToFitEntireStringConstraintedToWidth:300];
    _textView.frame = CGRectMake(_textView.frame.origin.x,
                                 _textView.frame.origin.y,
                                 textViewSize.width,
                                 textViewSize.height+5);
    
    _textView.contentSize = CGSizeMake(_textView.contentSize.width,_textView.frame.size.height);
    
    CGSize size = CGSizeMake(_headerImageView.frame.size.width ,
                             _headerImageView.frame.size.height + 10+
                             _imageGroupView.frame.size.height +
                             _textView.frame.size.height);
    
    _scrollView.contentSize = size;
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
