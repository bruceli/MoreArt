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
    
    NSData *data = UIImageJPEGRepresentation(_image, 1.0);
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,  YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:@"tianshanOutput.jpg"];
    [fileManager createFileAtPath:fullPath contents:data attributes:nil];

    _imageView = [[UIImageView alloc] initWithImage:_image];
//    [self addSubview:_imageView];
    _leftArray = [[NSMutableArray alloc ]init];
    [self separateImage];
    
    for(UIImageView* imageView in _leftArray)
    {
        [self addSubview:imageView];
    }
    
}

-(void)separateImage
{
/*    UIGraphicsBeginImageContext(self.bounds.size);
    NSLog(@"%@",NSStringFromCGSize(self.bounds.size));
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
*/
//    CGRect baseRect = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    
    NSInteger x = 2;
    NSInteger y = 2;
    
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
    
    NSInteger fileNo = 0;
    for (NSInteger i =0; i<x; i++) {
        for (NSInteger k =0; k<y; k++) {
            
            cropRect.origin.x = theXlength*i;
            cropRect.origin.y = theYlength*k;
            
            NSLog(@"%@",NSStringFromCGRect(cropRect));
            
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
            [_leftArray addObject:cropImageView];
            NSLog(@"%@",NSStringFromCGRect(cropImageView.frame));

            
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

            CGImageRelease(imageRef);

        }
    }
    
    
/*
 
 theXsize = self.bond.size.width/X  // get the width of each rect
 theYsize = self.bond.size.height/Y // get the height of each rect
 
 theRect = CGRectMake(CGRectZero)   // init rect
 theRect.width = theXsize;          // set rect size
 theRect.height = theYsize;
 
 for (NSint i =0, i<2,i++)
 {
    for(NSint k=0, k<2, k++)
    {
        // move rect from top left to bottom right
        theRect.orig.x += theRect.orig.x*i;
        theRect.orig.y += theRect.orig.y*i;
        
 
        // copy image and create a uiImageview array.
        
 

 
    }
    
 }
 
 
 
 
 */
    
    
}

@end
