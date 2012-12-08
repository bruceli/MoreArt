//
//  MaDouWoView.m
//  MoreMusic
//
//  Created by Accthun He on 5/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MaDouWoView.h"
#import "MoreArtAppDelegate.h"
#import "AsyncImageView.h"

/*
@interface UIImageView (AutoResize)  
@end  

@implementation UIImageView (AutoResize)  

- (void)resizeViewSizeBy:(UIImage*)img{  
	self.image = img;
	self.bounds = CGRectMake(0, 0, img.size.width, img.size.height);
}
@end  
*/


@interface MaDouWoView ()
//-(void)setupViewsByImageArray:(NSArray*)itemArray;
-(void)setupViewsByArray:(NSArray*)itemArray;
-(AsyncImageView*)createImgViewBy:(CGRect)frame;
-(void)addGestureRecognizerTo:(UIView*)view;

@end

@implementation MaDouWoView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _douViewType = DOU_TYPE_DO_WUO;

		CGRect bounds = [ [ UIScreen mainScreen ] applicationFrame ];
		MoreArtAppDelegate* app = (MoreArtAppDelegate *)[[UIApplication sharedApplication] delegate];

		CGRect frame = CGRectMake(0, 0, bounds.size.width, bounds.size.height - MA_TOOLBAR_HEIGHT);
        _scrollView = [[UIScrollView alloc ] initWithFrame:frame ];
        _scrollView.alwaysBounceVertical=YES;
		_scrollView.showsVerticalScrollIndicator = NO;
		_scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"setting_bkg.png"]];
		
		[app.dataSourceMgr updateDataSourceArrayByViewType:DOU_TYPE_DO_WUO];
		NSArray* itemArray = app.dataSourceMgr.dataSource;
		[self setupViewsByArray:itemArray];		
		
		[self addSubview:_scrollView ];		
		self.delegate = app.baseViewController;
    }
    return self;
}



-(void)addGestureRecognizerTo:(UIView*)view
{
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
	singleTap.numberOfTapsRequired = 1;
	[view setUserInteractionEnabled:YES];
    [view addGestureRecognizer:singleTap];
}

- (void)handleSingleTap:(UIGestureRecognizer *)gestureRecognizer {
	UIView* view = gestureRecognizer.view;	
	[self.delegate toggleZoom:(AsyncImageView*)view];
}



-(void)adjustViewSize:(CGSize)size
{
	_scrollView.contentSize = size; 
	
}


-(void)setupViewsByArray:(NSArray*)itemArray
{ 
	MoreArtAppDelegate* app = (MoreArtAppDelegate *)[[UIApplication sharedApplication] delegate];
	NSDictionary* imgDict = app.dataSourceMgr.imageIndexDict;

//	CGRect frame = CGRectMake(10, 15, 0, 0);
	float y_Location = 15.0;
	
	for(NSDictionary* dict in itemArray)
	{
		NSString* path = [imgDict objectForKey:[dict objectForKey:@"imageName"]];
		NSString* text = [dict objectForKey:@"artDiscription"];
		
		DTAttributedTextView* textView = [self createTextViewBy:CGRectMake(10, y_Location, 300, 100)]; 
		NSString* string = [self encodeingText:text];
		[self fillText:string to:textView];
		
		CGSize textViewSize = [textView.contentView suggestedFrameSizeToFitEntireStringConstraintedToWidth:300];
		[_scrollView addSubview:textView];
		y_Location = textViewSize.height + y_Location +16;

		AsyncImageView* imgView = [self createImgViewBy:CGRectMake(10, y_Location, 300, 200)]; 
		[imgView setImageByString:path];
		[_scrollView addSubview:imgView];
		y_Location = imgView.frame.size.height + y_Location +20;		
	}
	
	[self adjustViewSize:CGSizeMake(320, y_Location)];
}


-(void)imageIsReadyNotify:(UIView*)view
{
	view.clipsToBounds = NO;
	[view.layer setShadowColor:[[UIColor blackColor] CGColor]];
	[view.layer setShadowOffset:CGSizeMake(4, 3)];
	[view.layer setShadowOpacity:0.9];
	[view.layer setShadowRadius:4];
	
	CGSize size = [(AsyncImageView*)view imageScale];
	UIImage* img = [(AsyncImageView*)view image];
	CGSize realSize = CGSizeMake(size.width*img.size.width, size.height*img.size.height);


	float deltaX = view.frame.size.width - realSize.width;
	float deltaY = view.frame.size.height - realSize.height;
	CGRect rect = CGRectMake(deltaX/2, deltaY/2, realSize.width, realSize.height);
	
	view.layer.shadowPath = [UIBezierPath bezierPathWithRect:rect].CGPath;

	
}
-(AsyncImageView*)createImgViewBy:(CGRect)frame
{
    AsyncImageView* imgView = [[AsyncImageView alloc] initWithFrame:frame];
	imgView.contentMode = UIViewContentModeScaleAspectFit;
	imgView.delegate = self;
	//  [imgView.layer setBorderColor: [[UIColor darkGrayColor] CGColor]];
	//	[imgView.layer setBorderWidth: 0.5];

    [self addGestureRecognizerTo:imgView];
	
	//imgView.backgroundColor = [UIColor colorWithRed:(random()%100)/(float)100 green:(random()%100)/(float)100 blue:(random()%100)/(float)100 alpha:1];
    imgView.backgroundColor = [UIColor clearColor];
	return imgView;
}

-(DTAttributedTextView*)createTextViewBy:(CGRect)frame
{
	DTAttributedTextView* textView = [[DTAttributedTextView alloc] initWithFrame:frame];
	//	_textView.textDelegate = self;
	textView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
	textView.backgroundColor = [UIColor clearColor];
    return textView;
}

-(NSString*)encodeingText:(NSString*)text
{
	if ([text length]==0) {
		return @"";
	}
	
	NSString* path = [[NSBundle mainBundle] pathForResource:@"css" ofType:@"plist"];
    NSDictionary* cssStyleDict = [[NSDictionary alloc] initWithContentsOfFile:path];

	NSMutableString* subEventString = [[NSMutableString alloc] init];
	// Event Name <p style="font-size:15px;line-height:15px;color:white;">eventName</p>
	[subEventString insertString:[cssStyleDict objectForKey:@"kMA_DOUWO_DETAIL_STYLE"] atIndex:0];
	[subEventString insertString:[cssStyleDict objectForKey:@"kMA_PARAGRPH_HEADER"] atIndex:0];
	[subEventString appendString:text];
	[subEventString appendString:[cssStyleDict objectForKey:@"kMA_PARAGRPH_END"]];
	//<ul  style="font-size:13px;line-height:15px;color:white;">
	return subEventString;
}

-(void)fillText:(NSString*)inString to:(DTAttributedTextView*)view
{
	if ([inString length]==0) {
		return;
	}
	
	void (^callBackBlock)(DTHTMLElement *element) = ^(DTHTMLElement *element) {
		// if an element is larger than twice the font size put it in it's own block
		if (element.displayStyle == DTHTMLElementDisplayStyleInline && element.textAttachment.displaySize.height > 2.0 * element.fontDescriptor.pointSize)
		{
			element.displayStyle = DTHTMLElementDisplayStyleBlock;
		}
	};
	
	NSData *data = [inString dataUsingEncoding:NSUTF8StringEncoding];
    CGSize maxImageSize = CGSizeMake(view.bounds.size.width - 20.0, view.bounds.size.height - 20.0);
    
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
    
	view.attributedString = string;
}

-(void)gestureTapEvent:(id)sender
{
	NSLog(@"%@", @"Tapped");
}


-(void) toggleZoom:(UIView*) sender 
{
	if (_hiddenView)
	{					
		// zoomout
		CGRect frame = [sender.window convertRect:_hiddenView.frame fromView:_hiddenView.superview];
		//		NSLog(@"end frame is ,%@", NSStringFromCGRect(frame));
		[[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
		[UIView animateWithDuration:0.3 animations:
		 ^{ sender.frame = frame; sender.alpha = 0.0;} 
						 completion:
		 ^(BOOL finished){
			 [_scaleImageView removeFromSuperview];
			 _hiddenView = nil;
			 _scaleImageView = nil;
		 }];
	}
	else
	{					// zoom in		
		_hiddenView = (AsyncImageView*)sender;
		CGRect frame = [sender.window convertRect:sender.frame fromView:sender.superview];
		//		NSLog(@"Sender frame is ,%@", NSStringFromCGRect(frame));
		
		CGRect screenRect = [[UIScreen mainScreen] bounds];
		//		NSLog(@"screenRect frame is ,%@", NSStringFromCGRect(screenRect));
		// prepair scrollableImage Animation
		_scaleImageView = [[MaScaleImageView alloc] initWithFrame:frame];
		_scaleImageView._scaleImageViewDelegate = self;
		//		_scaleImageView.frame = frame;
		[UIView animateWithDuration:0.2 animations:^{ _scaleImageView.frame = screenRect; }];
//		[self setImageForScrollableImageView:((AsyncImageView*)sender)];
		[sender.window addSubview:_scaleImageView];
		
		//		[self.navigationController setNavigationBarHidden:YES animated:YES];
		[[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
		
	}
}

@end
