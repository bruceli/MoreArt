//
//  MaStartPageView.m
//  MoreArt
//
//  Created by Thunder on 12/25/12.
//  Copyright (c) 2012 MagicApp. All rights reserved.
//

#import "MaStartPageView.h"
#import "subViewController.h"
#import "MaDefine.h"

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
//			NSLog(@"SubView frame is %@",NSStringFromCGRect(subview.frame));
        }
    }
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

@implementation MaStartPageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
		int rows;
		int columns = MA_START_PAGE_COL;
		
		if ([[UIScreen mainScreen] bounds].size.height > 480) {
			 rows = MA_START_PAGE_ROWXL	
		}else
		{
			rows = MA_START_PAGE_ROW;
		}
		
		subView *containerView = [[subView alloc] init];
		[self addSubview: containerView];
		containerView.rows = rows;
		containerView.columns = columns;
		containerView.contentMode = UIViewContentModeScaleAspectFill;
		NSInteger fileSeq = 0;
		
		for (int i = 0; i < columns * rows; ++i) {
			subViewController *subController = [[subViewController alloc] init];
			subController.view.backgroundColor = [UIColor colorWithWhite:50 alpha:0.5];
			
			NSInteger min = 10; 
			NSInteger max = 100;
			
			NSInteger randNum = (arc4random() % (max - min) + min) ; 
			NSString *numString = [NSString stringWithFormat:@"%d", randNum];
			NSMutableString* fileName = [NSMutableString stringWithString: @"/launchIMG/squareIMG"];
			NSMutableString* secondFileName = [NSMutableString stringWithString: @"b"];
			[fileName appendString:numString];
			[fileName appendString:@".jpg"];
			[secondFileName appendString:@".jpeg"];
			
		//	NSLog(@"File named %@",fileName);
			subController.imageName = fileName;
			subController.secondImageName = secondFileName;
			[subController setupImage: i];
			[containerView addSubview:subController.view];
			
			fileSeq++;
		}
    }
	NSLog(@"%@",@"StartPage is ready");
    return self;
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
