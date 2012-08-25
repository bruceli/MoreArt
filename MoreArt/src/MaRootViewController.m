//
//  MaRootViewController.m
//  MoreMusic
//
//  Created by Accthun He on 5/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MaRootViewController.h"
#import "MoreArtAppDelegate.h"
#import "MaSettingViewController.h"
#import "MaDefine.h"

@interface MaRootViewController ()

@end

@implementation MaRootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
                
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}



-(void)slideSettingViewController
{
    MaSettingViewController *c = [[MaSettingViewController alloc] init];
    MoreArtAppDelegate* app = (MoreArtAppDelegate *)[[UIApplication sharedApplication] delegate];

    [app.revealSideViewController pushViewController:c onDirection:PPRevealSideDirectionLeft withOffset:SETTINGVIEW_OFFSET animated:YES];
}


@end
