//
//  MaImageArrayView.m
//  MoreArt
//
//  Created by Thunder on 11/8/12.
//  Copyright (c) 2012 MagicApp. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>

#import "MaImageArrayView.h"
#import "AsyncImageView.h"

#define MA_IMAGE_ARRAY_CELL_SIZE 60
#define MA_IMAGE_ARRAY_CELL_GAP 2


@implementation MaImageArrayView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor grayColor];
        
        imageViewArray = [[NSMutableArray alloc]init];
        
        for (int i = 0 ; i < 6; i ++) {
            CGRect frame = CGRectMake(MA_IMAGE_ARRAY_CELL_SIZE * i + MA_IMAGE_ARRAY_CELL_GAP*i,
                                      MA_IMAGE_ARRAY_CELL_GAP*2,
                                      MA_IMAGE_ARRAY_CELL_SIZE,
                                      MA_IMAGE_ARRAY_CELL_SIZE);
            NSLog(@"%d", i);
            NSLog(@"%@", NSStringFromCGRect(frame));
            
            AsyncImageView* imgView = [[AsyncImageView alloc] initWithFrame:frame];
            [imgView.layer setBorderColor: [[UIColor whiteColor] CGColor]];
            [imgView.layer setBorderWidth: 1.0];
            
            imgView.backgroundColor = [UIColor colorWithRed:(random()%100)/(float)100 green:(random()%100)/(float)100 blue:(random()%100)/(float)100 alpha:1];
            [imageViewArray addObject:imgView];
            [self addSubview:imgView];
        }
        
        self.contentSize = CGSizeMake((MA_IMAGE_ARRAY_CELL_SIZE+MA_IMAGE_ARRAY_CELL_GAP)*6, MA_IMAGE_ARRAY_CELL_SIZE);
        self.backgroundColor = [UIColor orangeColor];
        self.showsHorizontalScrollIndicator = NO;
        
        
        // Initialization code
    }
    return self;
}


-(void)layoutSubviews
{
    // 5 image cell will display
    
    // NSDictionary* dict = [_imageArray objectAtIndex:_imageCount];
    
    
    /*        [imgView setImageByString:[dict objectForKey:@"imageName"]];
     NSLog(@"%@", [dict objectForKey:@"imageName"]);
     
     imgView.backgroundColor = [UIColor whiteColor];
     [_scrollView addSubview:imgView];
     
     _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width *(_imageCount+1), _scrollView.frame.size.height);
     _scrollView.backgroundColor = [UIColor orangeColor];
     _scrollView.showsHorizontalScrollIndicator = NO;
     */
    
    
    
    
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
