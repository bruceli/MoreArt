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
    }
    return self;
}


/*
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.tableView.backgroundColor = [UIColor darkGrayColor];
    self.navigationItem.title = NSLocalizedString(@"douWo_Nav_Title",nil);

	self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(showSettings)];

	[[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationChanged:) name:@"UIDeviceOrientationDidChangeNotification" object:nil];
    
    
    landscapeView = [[UIView alloc]initWithFrame:self.view.bounds];
    portraitView = [[UIView alloc]initWithFrame:self.view.bounds];
    
    landscapeView.backgroundColor = [UIColor greenColor];
    portraitView.backgroundColor = [UIColor blueColor];

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

 - (void) orientationChanged:(id)object
{
	UIInterfaceOrientation interfaceOrientation = [[object object] orientation];
	
	if (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)
	{
		self.view = portraitView;
	}
	else
	{
		self.view = landscapeView;
	}
}

*/

@end
