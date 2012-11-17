//
//  MaDetailViewController.m
//  MoreArt
//
//  Created by Thunder on 9/2/12.
//  Copyright (c) 2012 MagicApp. All rights reserved.
//

#import "MaDetailViewController.h"
#import "MoreArtAppDelegate.h"
#define kMA_PARAGRPH_MARK

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
    NSDictionary* imgDict = app.dataSourceMgr.imageIndexDict;
    
    // Fill IMG
    CGFloat scale = [[UIScreen mainScreen] scale];
    NSMutableString* avatarImageName = [NSMutableString stringWithString:[dict objectForKey:@"avatar"]];
    [avatarImageName appendString:@"Title"];
    NSString* imgPath;
    if ([avatarImageName length]>0) {
        if (scale>1)
        {   // Image Upload issue, switch retina here.
            imgPath = [imgDict objectForKey:avatarImageName];
        }
        else
        {
            NSMutableString* retinaImageName = [NSMutableString stringWithString:avatarImageName];
            [retinaImageName appendString:@"@2x"];
            imgPath = [imgDict objectForKey:retinaImageName];
        }
    }
    [_headerImageView setImageByString:imgPath];
    
    // Fill imageArray;
    NSArray* array = [dict objectForKey:@"imageArray"];
    NSMutableArray* imgArray = [[NSMutableArray alloc] init];
    // Use square image form pic server
    for (NSDictionary* dict in array) {
        NSString* imagePrefix = [dict objectForKey:@"imageName"];
        if ([imagePrefix length]>0) {
            if (scale>1)
            {
                NSMutableString* retinaImageName = [NSMutableString stringWithString:imagePrefix];
                [retinaImageName appendString:@"@2x"];
                imgPath = [imgDict objectForKey:retinaImageName];
            }
            else
                imgPath = [imgDict objectForKey:imagePrefix];
        }
        NSMutableDictionary* imgDict = [NSMutableDictionary dictionaryWithDictionary:dict];
        
        if([imgPath length]>0)
            [imgDict setObject:imgPath forKey:@"imagePath"];
        
        [imgArray addObject:imgDict];
    }
    [_imageGroupView loadImagesBy:imgArray];
    
    
    // example for setting a willFlushCallback, that gets called before elements are written to the generated attributed string
	void (^callBackBlock)(DTHTMLElement *element) = ^(DTHTMLElement *element) {
		// if an element is larger than twice the font size put it in it's own block
		if (element.displayStyle == DTHTMLElementDisplayStyleInline && element.textAttachment.displaySize.height > 2.0 * element.fontDescriptor.pointSize)
		{
			element.displayStyle = DTHTMLElementDisplayStyleBlock;
		}
	};
    
    // Fill TXT
    NSString *detailStr = [self encodeDetailText:[dict objectForKey:@"discription"]];
    NSString *eventStr = [self encodeEventsText:[dict objectForKey:@"event"]];
    NSMutableString* infoString = [NSMutableString stringWithString:detailStr];
    [infoString appendString:eventStr];
//    NSLog(@"%@",infoString);

    NSData *data = [infoString dataUsingEncoding:NSUTF8StringEncoding];
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

-(NSString*) encodeDetailText:(NSString*)text
{
    if ([text length] ==0)
        return @"";
    
    // Load CSS style file.
    NSString* path = [[NSBundle mainBundle] pathForResource:@"css" ofType:@"plist"];
//    NSLog(@"Datasource Location... %@", path);
    NSDictionary* cssStyleDict = [[NSDictionary alloc] initWithContentsOfFile:path];
    
    // init result string.
    NSMutableString* detailText = [NSMutableString stringWithString:text];
    // Append header <p style=""; "">
    [detailText insertString:[cssStyleDict objectForKey:@"kMA_029DETAIL_STYLE"] atIndex:0];
    [detailText insertString:[cssStyleDict objectForKey:@"kMA_PARAGRPH_HEADER"] atIndex:0];

    // add </p> at the end
    [detailText appendString:[cssStyleDict objectForKey:@"kMA_PARAGRPH_END"]];
    
    // replacement paragraph mark  </p> <p>
    NSMutableString* paragraphMark = [NSMutableString stringWithString: [cssStyleDict objectForKey:@"kMA_PARAGRPH_MARK"]];
    [paragraphMark appendString:[cssStyleDict objectForKey:@"kMA_029DETAIL_STYLE"]];
    
    NSMutableString* result = [NSMutableString stringWithString: [detailText stringByReplacingOccurrencesOfString: @"kMA_PARAGRPH_MARK" withString:paragraphMark]];
    
    return result;
}

-(NSString*) encodeEventsText: (NSArray*)eventArray
{
    if ([eventArray count] ==0)
        return @"";
    
    NSString* path = [[NSBundle mainBundle] pathForResource:@"css" ofType:@"plist"];
    NSDictionary* cssStyleDict = [[NSDictionary alloc] initWithContentsOfFile:path];

    NSMutableString* resultString = [[NSMutableString alloc] init];
    
    for (NSDictionary *dict in eventArray)
    {
        NSMutableString* subEventString = [[NSMutableString alloc] init];
        // Event Name <p style="font-size:15px;line-height:15px;color:white;">eventName</p>
        [subEventString insertString:[cssStyleDict objectForKey:@"kMA_029DETAIL_STYLE"] atIndex:0];
        [subEventString insertString:[cssStyleDict objectForKey:@"kMA_PARAGRPH_HEADER"] atIndex:0];
        [subEventString appendString:[dict objectForKey:@"eventName"]];
        [subEventString appendString:[cssStyleDict objectForKey:@"kMA_PARAGRPH_END"]];
        //<ul  style="font-size:13px;line-height:15px;color:white;">
        
        [subEventString appendString:[cssStyleDict objectForKey:@"kMA_LIST_HEADER"]];
        [subEventString appendString:[cssStyleDict objectForKey:@"kMA_029DETAIL_STYLE"]];

        NSArray* itemArray = [dict objectForKey:@"events"];
        for (NSString *eventItem in itemArray)
        {
            //<li > EVENT TEXT HERE  </li>
            NSMutableString* eventItemString = [NSMutableString stringWithString:eventItem];
            [eventItemString insertString:[cssStyleDict objectForKey:@"kMA_ITEM_HEADER"] atIndex:0];
            [eventItemString appendString:[cssStyleDict objectForKey:@"kMA_ITEM_END"]];
            [subEventString appendString: eventItemString];
        }

        //</ul>
        [subEventString appendString:[cssStyleDict objectForKey:@"kMA_LIST_END"]];
        [resultString appendString:subEventString];
    }

    return resultString;
}



@end
