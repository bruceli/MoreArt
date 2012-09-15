//
//  MaCrossFadeView.m
//  MoreArt
//
//  Created by Thunder on 9/2/12.
//  Copyright (c) 2012 MagicApp. All rights reserved.
//

#import "MaCrossFadeView.h"
#import <QuartzCore/QuartzCore.h>

@interface MaCrossFadeView ()
-(void)separateImage;
-(void)addImageViews;
@end

@implementation MaCrossFadeView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
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



- (void)layoutSubviews
{
    _image = [UIImage imageNamed:@"tianShan"]; 
    _imageView = [[UIImageView alloc] initWithImage:_image];
 //   [self addSubview:_imageView];
    _leftArray = [[NSMutableArray alloc ]init];
    _rightArray = [[NSMutableArray alloc ]init];
    self.backgroundColor = [UIColor darkGrayColor];
    
    [self separateImage];
    [self addImageViews];

    UIButton* button = [[UIButton alloc] initWithFrame:CGRectMake(10, 15, 40, 17)];
    [button addTarget:self
               action:@selector(startAnimat)
     forControlEvents:UIControlEventTouchDown];
    [button setTitle:@"Go !" forState:UIControlStateNormal];
    [self addSubview:button];

}

-(void)addImageViews
{
    for(UIImageView* imageView in _leftArray)
    {
        [self addSubview:imageView];
    }
    
    for(UIImageView* imageView in _rightArray)
    {
        [self addSubview:imageView];
    }
    

}

-(void)separateImage
{
    NSInteger x = 5;
    NSInteger y = 100;
    
    CGFloat theXlength = self.bounds.size.width/x;
    CGFloat theYlength = self.bounds.size.height/y;
    CGFloat scale = [[UIScreen mainScreen] scale];

    if (scale>1) {
        theXlength = theXlength*scale;
        theYlength = theYlength*scale;
    }
    
    CGRect cropRect = CGRectZero;
    cropRect.size.width = theXlength;
    cropRect.size.height = theYlength;
//    NSLog(@"%@",NSStringFromCGRect(cropRect));
//    NSInteger fileNo = 0;
    for (NSInteger i =0; i<x; i++) {
        for (NSInteger k =0; k<y; k++) {
            
            cropRect.origin.x = theXlength*i;
            cropRect.origin.y = theYlength*k;
//            NSLog(@"%@",NSStringFromCGRect(cropRect));
            CGImageRef imageRef = CGImageCreateWithImageInRect([_image CGImage], cropRect);
            
            CGRect realRect;
            UIImageView* cropImageView;
            if (scale>1) {
                realRect = CGRectMake(cropRect.origin.x / scale,
                                  cropRect.origin.y / scale,
                                  cropRect.size.width / scale,
                                  cropRect.size.height / scale);
                cropImageView = [[UIImageView alloc] initWithFrame:realRect];
            }
            else
            {
                cropImageView = [[UIImageView alloc] initWithFrame:cropRect];
            }

            cropImageView.image = [UIImage imageWithCGImage:imageRef];
            
            if (i%2==0)
            {
                [_leftArray addObject:cropImageView];
             //   NSLog(@"%@",@"left array");
            }
            else
            {
                [_rightArray addObject:cropImageView];
              //  NSLog(@"%@",@"right array");
            }
//            NSLog(@"%@",NSStringFromCGRect(cropImageView.frame));
/*
            NSData *data = UIImageJPEGRepresentation([UIImage imageWithCGImage:imageRef], 1.0);
            NSFileManager *fileManager = [NSFileManager defaultManager];
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,  YES);
            NSString *documentsDirectory = [paths objectAtIndex:0];
            NSMutableString* fileName = [NSMutableString stringWithFormat:@"%d", fileNo];
            [fileName appendString:@"image.jpeg"];
            NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:fileName];
//            NSLog(@"%@",fullPath);
            fileNo++;
            [fileManager createFileAtPath:fullPath contents:data attributes:nil];
*/
            CGImageRelease(imageRef);
        }
    }
/*
 
 theXsize = self.bond.size.width/X  // get the width of each rect
 theYsize = self.bond.size.height/Y // get the height of each rect
 
 theRect = CGRectMake(CGRectZero)   // init rect
 theRect.width = theXsize;          // set rect size
 theRect.height = theYsize;
 
 for (NSint i =0, i<2,i++) {
    for(NSint k=0, k<2, k++){
        // move rect from top left to bottom right
        theRect.orig.x += theRect.orig.x*i;
        theRect.orig.y += theRect.orig.y*i;

        // copy image and create a uiImageview array.
    }
 } */
}

-(void)startAnimat
{
    CGRect theLeftRects;
    CGRect theRightRects;
    //Init status

    [UIView beginAnimations:nil context:nil];
    for(UIImageView* imageView in _leftArray)
    {
        theLeftRects = imageView.frame;
        theLeftRects.origin.x = -theLeftRects.size.width*5;
        imageView.frame = theLeftRects;
        if ([_leftArray indexOfObject:imageView] %2==0)
        {
            [UIView setAnimationDuration:0.4];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];

        }
        else
        {
            [UIView setAnimationDuration:0.3];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        }

    }
    [UIView commitAnimations];

    [UIView beginAnimations:nil context:nil];
    for(UIImageView* imageView in _rightArray)
    {
        theRightRects = imageView.frame;
        theRightRects.origin.x = theRightRects.size.width*5;
        imageView.frame = theRightRects;
        if ([_rightArray indexOfObject:imageView] %2==0)
        {
            [UIView setAnimationDuration:0.4];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
            
        }
        else
        {
            [UIView setAnimationDuration:0.3];
            [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        }

    }

    [UIView commitAnimations];
    NSLog(@"%@", @"Animating");

}

@end
