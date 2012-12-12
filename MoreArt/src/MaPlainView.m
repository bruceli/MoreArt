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


@interface MaPlainView ()
-(AsyncImageView*)createImgViewBy:(CGRect)frame;
-(void)addGestureRecognizerTo:(UIView*)view;
@end


@implementation MaPlainView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {	
    }
    return self;
}

-(void)setupViewsFromArray:(NSArray*)itemArray to:(UIScrollView*)scrollView
{ 
	MoreArtAppDelegate* app = (MoreArtAppDelegate *)[[UIApplication sharedApplication] delegate];
	NSDictionary* imgDict = app.dataSourceMgr.imageIndexDict;
	
	float y_Location = 15.0;
	
	for(NSDictionary* dict in itemArray)
	{
		NSString* path = [imgDict objectForKey:[dict objectForKey:@"imageName"]];
		NSString* text = [dict objectForKey:@"artDiscription"];
		
		DTAttributedTextView* textView = [self createTextViewBy:CGRectMake(10, y_Location, 300, 100)]; 
		NSString* string = [self encodeingText:text];
		[self fillText:string to:textView];
		
		CGSize textViewSize = [textView.contentView suggestedFrameSizeToFitEntireStringConstraintedToWidth:300];
		[scrollView addSubview:textView];
		y_Location = textViewSize.height + y_Location +16;
		
		AsyncImageView* imgView = [self createImgViewBy:CGRectMake(10, y_Location, 300, 200)]; 
		[imgView setImageByString:path];
		[scrollView addSubview:imgView];
		y_Location = imgView.frame.size.height + y_Location +20;		
	}
	
	scrollView.contentSize = CGSizeMake(320, y_Location); 
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
	UIView* view = gestureRecognizer.view;	
	[self toggleZoom:view];
}

-(void) toggleZoom:(UIView*) sender 
{
	if (_hiddenView)
	{					
		// zoomout
		CGRect frame = [sender.window convertRect:_hiddenView.frame fromView:_hiddenView.superview];
		NSLog(@"end frame is ,%@", NSStringFromCGRect(frame));
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
		_scaleImageView.scaleImageViewDelegate = self;
		//		_scaleImageView.frame = frame;
		[UIView animateWithDuration:0.2 animations:^{ _scaleImageView.frame = screenRect; }];
		[self setImageForScrollableImageView:((AsyncImageView*)sender)];
		[sender.window addSubview:_scaleImageView];
		
		//		[self.navigationController setNavigationBarHidden:YES animated:YES];
		[[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
		
	}
}

-(void) setImageForScrollableImageView:(AsyncImageView*)imageView
{
	NSURL* imgURL = imageView.imgURL; 
	[_scaleImageView loadImageFrom:[imgURL absoluteString]];
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
