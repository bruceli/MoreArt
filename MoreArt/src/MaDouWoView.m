//
//  MaDouWoView.m
//  MoreMusic
//
//  Created by Accthun He on 5/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MaDouWoView.h"
#import "MoreArtAppDelegate.h"

@interface MaDouWoView ()

@end

@implementation MaDouWoView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _douViewType = DOU_TYPE_DO_WUO;
//        _scrollImageViewController = [[MaScrollImageViewController alloc] init];
//        [self addSubview:_scrollImageViewController.view];
//        _scrollImageViewController.view.frame = CGRectMake(0, 0, 320, 135);
//        self.tableHeaderView = _scrollImageViewController.view;
        CGRect bounds = [ [ UIScreen mainScreen ] applicationFrame ];
        _scrollView = [[UIScrollView alloc ] initWithFrame:bounds ];
        _scrollView.alwaysBounceHorizontal=YES;
        
  //      _scrollView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"setting_bkg.png"]];

        
    
    
    
    }
    return self;
}

-(void)adjustViewSize
{
    CGSize textViewSize = [_textView.contentView suggestedFrameSizeToFitEntireStringConstraintedToWidth:300];
    _textView.frame = CGRectMake(_textView.frame.origin.x,
                                 _textView.frame.origin.y,
                                 textViewSize.width,
                                 textViewSize.height+5);
    
    _textView.contentSize = CGSizeMake(_textView.contentSize.width,_textView.frame.size.height);
    
 /*   CGSize size = CGSizeMake(_headerImageView.frame.size.width ,
                             _headerImageView.frame.size.height + 10+
                             _imageGroupView.frame.size.height +
                             _textView.frame.size.height);
    
    _scrollView.contentSize = size;
  */
}



@end
