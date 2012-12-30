//
//  subView.m
//  FlipImage
//
//  Created by Bruce Li on 9/15/12.
//  Copyright (c) 2012 Bruce Li. All rights reserved.
//

#import "subView.h"

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
    int widthSize = self.bounds.size.width / columns;
    int heightSize = self.bounds.size.height / rows;
    int index = 0;
    for (int y = 0; y < rows; ++y) {
        for (int x = 0; x < columns; ++x) {
            UIView *subview = [self.subviews objectAtIndex:index++];
            subview.frame = CGRectMake(x * widthSize, y * heightSize, widthSize, heightSize);
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
