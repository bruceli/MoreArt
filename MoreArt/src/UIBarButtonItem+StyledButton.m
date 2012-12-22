//
//  UIBarButtonItem+StyledButton.m
//  MoreArt
//
//  Created by Thunder on 12/22/12.
//  Copyright (c) 2012 MagicApp. All rights reserved.
//

#import "UIBarButtonItem+StyledButton.h"
#define MA_BUTTON_FONT_SIZE 13


@implementation UIBarButtonItem (StyledButton)

+ (UIBarButtonItem *)styledBackBarButtonItemWithTarget:(id)target selector:(SEL)selector;
{
	UIImage *image = [UIImage imageNamed:@"button_back"];
	image = [image stretchableImageWithLeftCapWidth:20.0f topCapHeight:20.0f];
	
	NSString *title = NSLocalizedString(@"Back", nil);
	UIFont *font = [UIFont boldSystemFontOfSize:MA_BUTTON_FONT_SIZE];
	
	UIButton *button = [UIButton styledButtonWithBackgroundImage:image font:font title:title target:target selector:selector];
	button.titleLabel.textColor = [UIColor blackColor];
	
	CGSize textSize = [title sizeWithFont:font];
	CGFloat margin = (button.frame.size.height - textSize.height) / 2;
	CGFloat marginRight = 7.0f;
	CGFloat marginLeft = button.frame.size.width - textSize.width - marginRight;
	[button setTitleEdgeInsets:UIEdgeInsetsMake(margin, marginLeft, margin, marginRight)]; 
	[button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];   
	
	return [[UIBarButtonItem alloc] initWithCustomView:button];
}

+ (UIBarButtonItem *)styledCancelBarButtonItemWithTarget:(id)target selector:(SEL)selector;
{
	UIImage *image = [UIImage imageNamed:@"button_square"];
	image = [image stretchableImageWithLeftCapWidth:20.0f topCapHeight:20.0f];
	
	NSString *title = NSLocalizedString(@"Cancel", nil);
	UIFont *font = [UIFont boldSystemFontOfSize:MA_BUTTON_FONT_SIZE];
	
	UIButton *button = [UIButton styledButtonWithBackgroundImage:image font:font title:title target:target selector:selector];   
	button.titleLabel.textColor = [UIColor blackColor];   
	[button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];   
	
	return [[UIBarButtonItem alloc] initWithCustomView:button];
}

+ (UIBarButtonItem *)styledSubmitBarButtonItemWithTitle:(NSString *)title target:(id)target selector:(SEL)selector;
{
	UIImage *image = [UIImage imageNamed:@"button_submit"];
	image = [image stretchableImageWithLeftCapWidth:20.0f topCapHeight:20.0f];
	
	UIFont *font = [UIFont boldSystemFontOfSize:MA_BUTTON_FONT_SIZE];
	
	UIButton *button = [UIButton styledButtonWithBackgroundImage:image font:font title:title target:target selector:selector];
	button.titleLabel.textColor = [UIColor whiteColor];
	[button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];   
	
	return [[UIBarButtonItem alloc] initWithCustomView:button];
}

@end


@implementation UIButton (UIButton_StyledButton)

+ (UIButton *)styledButtonWithBackgroundImage:(UIImage *)image font:(UIFont *)font title:(NSString *)title target:(id)target selector:(SEL)selector
{
	CGSize textSize = [title sizeWithFont:font];
	CGSize buttonSize = CGSizeMake(textSize.width + 20.0f, image.size.width);
	
	UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0.0f, 0.0f, buttonSize.width, buttonSize.height)];
	[button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
	[button setBackgroundImage:image forState:UIControlStateNormal];
	[button setTitle:title forState:UIControlStateNormal];
	[button.titleLabel setFont:font];
	
	return button;
}



@end
