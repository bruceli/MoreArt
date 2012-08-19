//
//  MaScheduleViewController.m
//  MoreMusic
//
//  Created by Accthun He on 5/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MaScheduleViewController.h"
#import "MaTableViewController.h"
#import "MoreArtAppDelegate.h"

@interface MaScheduleViewController ()

@end

@implementation MaScheduleViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight;          
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Schedule" image:[UIImage imageNamed:@"clock"] tag:0];
        return self;


    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{    
    [super viewWillAppear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.tableView.backgroundColor = [UIColor darkGrayColor];
    self.navigationItem.title = @"MaScheduleViewController";

	self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(showSettings)];

	[[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationChanged:) name:@"UIDeviceOrientationDidChangeNotification" object:nil];
    
    
    landscapeView = [[UIView alloc]initWithFrame:self.view.bounds];
    portraitView = [[UIView alloc]initWithFrame:self.view.bounds];
    
    landscapeView.backgroundColor = [UIColor greenColor];
    portraitView.backgroundColor = [UIColor blueColor];

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

-(void)showSettings
{
    [super slideSettingViewController];
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



@end
