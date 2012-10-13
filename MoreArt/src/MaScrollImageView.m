//
//  MaScrollImageView.m
//  MoreArt
//
//  Created by Thunder on 9/15/12.
//  Copyright (c) 2012 MagicApp. All rights reserved.
//

#import "MaScrollImageView.h"
#import "AsyncImageView.h"
#import "MaDefine.h"

@implementation MaScrollImageView
@synthesize scrollView = _scrollView;
@synthesize imageArray = _imageArray;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _imageCount = 0;
    }
    return self;
}

-(void)layoutSubviews
{
    CGRect theFrame = CGRectMake(0, 0, MA_SCROLL_IMAGE_WIDTH, MA_SCROLL_IMAGE_HEIGHT);
    _scrollView = [[UIScrollView alloc] initWithFrame:theFrame];
    
    _scrollView.backgroundColor = [UIColor brownColor];
    [self addSubview: _scrollView];
    
    for (_imageCount = 0 ; _imageCount < [_imageArray count]; _imageCount ++) {
        CGRect frame = CGRectMake(MA_SCROLL_IMAGE_WIDTH * _imageCount,
                                  0,
                                  MA_SCROLL_IMAGE_WIDTH,
                                  MA_SCROLL_IMAGE_HEIGHT);
        
        NSLog(@"%d", _imageCount);
        NSLog(@"%@", NSStringFromCGRect(frame));
        
        NSDictionary* dict = [_imageArray objectAtIndex:_imageCount];
        AsyncImageView* imgView = [[AsyncImageView alloc] initWithFrame:frame];
        [imgView setImageByString:[dict objectForKey:@"imageName"]];
        NSLog(@"%@", [dict objectForKey:@"imageName"]);

        imgView.backgroundColor = [UIColor whiteColor];
        [_scrollView addSubview:imgView];
        
        _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width *(_imageCount+1), _scrollView.frame.size.height);
        _scrollView.backgroundColor = [UIColor orangeColor];
        _scrollView.showsHorizontalScrollIndicator = NO;
    }
    
}

/*
-(void)addImageWith:(NSString*)imagePath
{
    CGRect frame = CGRectMake(MA_SCROLL_IMAGE_WIDTH * _imageCount,
                              0,
                              MA_SCROLL_IMAGE_WIDTH,
                              MA_SCROLL_IMAGE_HEIGHT);

    NSLog(@"%d", _imageCount);
    NSLog(@"%@", NSStringFromCGRect(frame));
    
    AsyncImageView* imgView = [[AsyncImageView alloc] initWithFrame:frame];
    [imgView setImageByString:imagePath];
    imgView.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:imgView];
    
    _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width * _imageCount, _scrollView.frame.size.height);
    _scrollView.backgroundColor = [UIColor orangeColor];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _imageCount++;
}
*/


@end
