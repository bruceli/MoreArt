//
//  MaAboutView.m
//  MoreArt
//
//  Created by Thunder on 8/24/12.
//  Copyright (c) 2012 MagicApp. All rights reserved.
//

#import "MaAboutView.h"
#import "MaDefine.h"

@implementation MaAboutView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//		CGRect bounds = [ [ UIScreen mainScreen ] applicationFrame ];
//		CGRect frame = CGRectMake(0, 0, bounds.size.width, bounds.size.height - MA_TOOLBAR_HEIGHT);
		self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"setting_bkg1"]];
		DTAttributedTextView* textView = [[DTAttributedTextView alloc] initWithFrame:CGRectMake(20, 15, 290, 330)];
		textView.textDelegate = self;
		textView.backgroundColor = [UIColor clearColor];
		
		NSString* string = [self encodeingText:NSLocalizedString(@"about_String",nil)];
		[self fillText:string to:textView];		
		[self addSubview:textView];
	}
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
    
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


@end
