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
#define MA_IMAGE_ARRAY_MINIMUM_CELL_COUNT 6

@implementation MaImageArrayView
@synthesize imageArray = _imageArray;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor grayColor];
        
        _imageViewArray = [[NSMutableArray alloc]init];
        
        for (int i = 0 ; i < 6; i ++) {
            CGRect frame = CGRectMake(MA_IMAGE_ARRAY_CELL_SIZE * i + MA_IMAGE_ARRAY_CELL_GAP*i,
                                      MA_IMAGE_ARRAY_CELL_GAP*2,
                                      MA_IMAGE_ARRAY_CELL_SIZE,
                                      MA_IMAGE_ARRAY_CELL_SIZE);
//            NSLog(@"%d", i);
//            NSLog(@"%@", NSStringFromCGRect(frame));
            
            AsyncImageView* imgView = [[AsyncImageView alloc] initWithFrame:frame];
            [imgView.layer setBorderColor: [[UIColor whiteColor] CGColor]];
            [imgView.layer setBorderWidth: 1.0];
            
            imgView.backgroundColor = [UIColor colorWithRed:(random()%100)/(float)100 green:(random()%100)/(float)100 blue:(random()%100)/(float)100 alpha:1];
            [_imageViewArray addObject:imgView];
            [self addSubview:imgView];
        }
        
        self.contentSize = CGSizeMake((MA_IMAGE_ARRAY_CELL_SIZE + MA_IMAGE_ARRAY_CELL_GAP)*MA_IMAGE_ARRAY_MINIMUM_CELL_COUNT, MA_IMAGE_ARRAY_CELL_SIZE);
        self.backgroundColor = [UIColor orangeColor];
        self.showsHorizontalScrollIndicator = NO;
        
        
        // Initialization code
    }
    return self;
}

-(NSString*)getSquareImagePathBy:(NSString*)path
{
    if ([path length]<=0)
        return @"";
    
    NSRange range = [path rangeOfString:@"/" options:NSBackwardsSearch];
    NSRange itemRange = NSMakeRange(0, range.location);
//    NSLog(@"itemRange is %@", NSStringFromRange(itemRange));
    NSString* pathString = [path substringWithRange:itemRange];
//    NSLog(@"%@",pathString);
    NSMutableString* result = [NSMutableString stringWithString:pathString];
    [result appendString:@"/square.jpg"];
    return result;
}

-(void)loadImagesBy: (NSArray*)array;
{
    _imageArray = array;
    
    if ([_imageArray count]>MA_IMAGE_ARRAY_MINIMUM_CELL_COUNT)
    {   // Add more cells for image if needed.
        for (int i = MA_IMAGE_ARRAY_MINIMUM_CELL_COUNT ; i < [_imageArray count]; i ++)
        {
            CGRect frame = CGRectMake(MA_IMAGE_ARRAY_CELL_SIZE * i + MA_IMAGE_ARRAY_CELL_GAP*i,
                                        MA_IMAGE_ARRAY_CELL_GAP*2,
                                        MA_IMAGE_ARRAY_CELL_SIZE,
                                        MA_IMAGE_ARRAY_CELL_SIZE);

            AsyncImageView* imgView = [[AsyncImageView alloc] initWithFrame:frame];
            [imgView.layer setBorderColor: [[UIColor whiteColor] CGColor]];
            [imgView.layer setBorderWidth: 1.0];

            imgView.backgroundColor = [UIColor colorWithRed:(random()%100)/(float)100 green:(random()%100)/(float)100 blue:(random()%100)/(float)100 alpha:1];
            [_imageViewArray addObject:imgView];
            [self addSubview:imgView];        
        }
        self.contentSize = CGSizeMake((MA_IMAGE_ARRAY_CELL_SIZE + MA_IMAGE_ARRAY_CELL_GAP)*[_imageArray count], MA_IMAGE_ARRAY_CELL_SIZE);

    }
    
    for (int i = 0; i <= ([_imageArray count]-1); i++) {
        // img source
        NSDictionary* dict = [_imageArray objectAtIndex:i];
        // img view
        AsyncImageView* imgView = [_imageViewArray objectAtIndex:i];
        NSString* imgPath = [dict objectForKey:@"imagePath"];
        NSString* path = [self getSquareImagePathBy:imgPath];
        [imgView setImageByString:path];
    }
}

-(void)layoutSubviews
{
    
    
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
