//
//  MaPlainView.m
//  MoreArt
//
//  Created by Thunder on 10/13/12.
//  Copyright (c) 2012 MagicApp. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "MaPlainView.h"
#import "AsyncImageView.h"
#import "MoreArtAppDelegate.h"
#import "MaImageGalleryViewController.h"


@interface MaPlainView ()
-(AsyncImageView*)createImgViewBy:(CGRect)frame;
-(void)addGestureRecognizerTo:(UIView*)view;
@end


@implementation MaPlainView
@synthesize imageViewArray = _imageViewArray;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {	
		
		CGRect bounds = [ [ UIScreen mainScreen ] applicationFrame ];
		CGRect frame = CGRectMake(0, 0, bounds.size.width, bounds.size.height - MA_TOOLBAR_HEIGHT);
		_scrollView = [[UIScrollView alloc ] initWithFrame:frame ];
		_scrollView.alwaysBounceVertical=YES;
		_scrollView.showsVerticalScrollIndicator = NO;
		_scrollView.showsHorizontalScrollIndicator = NO;
		_scrollView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"setting_bkg.png"]];
		
		[self addSubview:_scrollView ];		
		[self reloadViewsByType:_douViewType];
		
    }
    return self;
}

-(void)reloadViewsByType:(MaDouViewType)type
{
	MoreArtAppDelegate* app = (MoreArtAppDelegate *)[[UIApplication sharedApplication] delegate];
	NSArray* itemArray = app.dataSourceMgr.dataSource;
	[app.dataSourceMgr updateDataSourceArrayByViewType:_douViewType];
	
	[[_scrollView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];

	[self setupViewsFromArray:itemArray];

}

-(void)setupViewsFromArray:(NSArray*)itemArray
{ 
	_imageViewArray = [[NSMutableArray alloc] init];
	
	MoreArtAppDelegate* app = (MoreArtAppDelegate *)[[UIApplication sharedApplication] delegate];
	NSDictionary* imgDict = app.dataSourceMgr.imageIndexDict;
	
	float y_Location = 15.0;
	
	for(NSDictionary* dict in itemArray)
	{
		NSString* imgName = [dict objectForKey:@"imageName"];
		NSString* text = [dict objectForKey:@"artDiscription"];
		
		DTAttributedTextView* textView = [self createTextViewBy:CGRectMake(10, y_Location, 300, 100)]; 
		NSString* string = [self encodeingText:text];
		[self fillText:string to:textView];
		
		CGSize textViewSize = [textView.contentView suggestedFrameSizeToFitEntireStringConstraintedToWidth:300];
		if (textView.frame.size.height < textViewSize.height ) {
			textView.frame = CGRectMake(textView.frame.origin.x, textView.frame.origin.y, textView.frame.size.width, textViewSize.height+10);
		}
		[_scrollView addSubview:textView];
		y_Location = textViewSize.height + y_Location +16;
		
		if ([imgName length]>0) {
			NSString* path = [imgDict objectForKey:imgName];

			AsyncImageView* imgView = [self createImgViewBy:CGRectMake(10, y_Location, 300, 200)]; 
			[imgView setImageByString:path];
			[_scrollView addSubview:imgView];

			NSMutableDictionary* dict = [NSMutableDictionary dictionaryWithObjects:[NSArray arrayWithObjects:imgView,path,nil] forKeys:[NSArray arrayWithObjects:@"imageView",@"imagePath",nil] ];
			[_imageViewArray addObject:dict];

			y_Location = imgView.frame.size.height + y_Location +20;	
		}

	}
	
	_scrollView.contentSize = CGSizeMake(320, y_Location); 
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

-(DTAttributedTextView*)createTextViewBy:(CGRect)frame
{
	DTAttributedTextView* textView = [[DTAttributedTextView alloc] initWithFrame:frame];
	textView.textDelegate = self;
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

-(AsyncImageView*)createImgViewBy:(CGRect)frame
{
    AsyncImageView* imgView = [[AsyncImageView alloc] initWithFrame:frame];
	imgView.contentMode = UIViewContentModeScaleAspectFit;
	imgView.delegate = self;
	
    [self addGestureRecognizerTo:imgView];
	
	//imgView.backgroundColor = [UIColor colorWithRed:(random()%100)/(float)100 green:(random()%100)/(float)100 blue:(random()%100)/(float)100 alpha:1];
    imgView.backgroundColor = [UIColor clearColor];
	return imgView;
}

-(void)addGestureRecognizerTo:(UIView*)view
{
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
	singleTap.numberOfTapsRequired = 1;
	[view setUserInteractionEnabled:YES];
    [view addGestureRecognizer:singleTap];
	
//	NSLog(@"addGestureRecognizerTo: %@", [view description]);
}

-(void)adjustViewSize:(CGSize)size
{
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


- (void)handleSingleTap:(UIGestureRecognizer *)gestureRecognizer {
//	NSLog(@"handleSingleTap From: %@", [gestureRecognizer.view description]);
	MoreArtAppDelegate* app = (MoreArtAppDelegate *)[[UIApplication sharedApplication] delegate];

	AsyncImageView* view = (AsyncImageView*)gestureRecognizer.view;	
	int i = 0;
	for (; i< [_imageViewArray count]; i++) {
		AsyncImageView* theView =[ [_imageViewArray objectAtIndex:i] objectForKey:@"imageView"];
		if (theView  == view ) {
			break;
		}
	}
	
	NSArray* itemArray = app.dataSourceMgr.dataSource;
	NSMutableArray* imageSourceArray = [[NSMutableArray alloc]init];
	for (NSDictionary* dict in itemArray) {
		NSString* path = [dict objectForKey:@"imageName"];
		if ([path length]>0) {
			[imageSourceArray addObject:dict];
		}
	}
	
	MaImageGalleryViewController* galleryViewController = [[MaImageGalleryViewController alloc] initWithPhotoSource:imageSourceArray ];
	galleryViewController.startingIndex = i;
	[app.baseViewController.navigationController pushViewController:galleryViewController animated:YES];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/





@end
