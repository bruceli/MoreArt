//
//  magicappViewController.m
//  FlipImage
//
//  Created by Bruce Li on 9/13/12.
//  Copyright (c) 2012 Bruce Li. All rights reserved.
//

#import "magicappViewController.h"
#import "subView.h"
#import "subViewController.h"

@interface magicappViewController ()
{
    
}
@end

@implementation magicappViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    int columns = 4;
    int rows = 6;
    
    subView *containerView = [[subView alloc] init];
    self.view = containerView;
    containerView.rows = rows;
    containerView.columns = columns;
    containerView.contentMode = UIViewContentModeScaleAspectFill;
    NSInteger fileSeq = 0;
    
    for (int i = 0; i < columns * rows; ++i) {
        subViewController *subController = [[subViewController alloc] init];
        subController.view.backgroundColor = [UIColor colorWithWhite:50 alpha:0.5];
        
        NSMutableString* fileName = [NSMutableString stringWithString: @"a"];
        NSMutableString* secondFileName = [NSMutableString stringWithString: @"b"];
        //[fileName appendString:[NSString stringWithFormat: @"%d", fileSeq]];
        [fileName appendString:@".jpeg"];
        [secondFileName appendString:@".jpeg"];
        
        NSLog(@"File named %@",fileName);
        subController.imageName = fileName;
        subController.secondImageName = secondFileName;
        [subController setupImage: i];
        [containerView addSubview:subController.view];
        
        fileSeq++;
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
