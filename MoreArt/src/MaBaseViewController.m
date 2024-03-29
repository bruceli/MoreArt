//
//  MaBaseViewController.m
//  MoreArt
//
//  Created by Thunder on 8/23/12.
//  Copyright (c) 2012 MagicApp. All rights reserved.
//
#import "MaDefine.h"

#import "MaBaseViewController.h"
#import "MaSettingViewController.h"
#import "MoreArtAppDelegate.h"
#import "MaDetailViewController.h"
#import "MaEZCell.h"
#import "MaImageGalleryViewController.h"

@interface MaBaseViewController ()

@end

@implementation MaBaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        MoreArtAppDelegate* app = (MoreArtAppDelegate *)[[UIApplication sharedApplication] delegate];

        _dataSourceMgr = app.dataSourceMgr;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
	_scrollView = [[UIScrollView alloc]init];
	_scrollView.delegate = self;
	_scrollView.backgroundColor = [UIColor orangeColor];
	
	self.view.backgroundColor = [UIColor darkGrayColor];
    
    self.navigationItem.title = NSLocalizedString(@"douWo_Nav_Title",nil);
    MoreArtAppDelegate* app = (MoreArtAppDelegate *)[[UIApplication sharedApplication] delegate];
    [_dataSourceMgr updateDataSourceArrayByViewType:DOU_TYPE_DO_WUO];

    self.view = app.douWoView;
    
	
	[[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"UIDeviceOrientationDidChangeNotification" object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationChanged:) name:@"UIDeviceOrientationDidChangeNotification" object:nil];
	
	UIButton* buttomView = [[UIButton alloc] initWithFrame:CGRectMake(0,0, 50, 44)];
	[buttomView setImage:[UIImage imageNamed:@"button_slider_1"] forState:UIControlStateNormal];
	[buttomView addTarget:self action:@selector(slideSettingViewController) forControlEvents:UIControlEventTouchDown];
	UIBarButtonItem* buttom = [[UIBarButtonItem alloc] initWithCustomView:buttomView];

	self.navigationItem.leftBarButtonItem = buttom;	
}

-(void)updateDataSourceBy:(MaDouViewType)type
{
    [_dataSourceMgr updateDataSourceArrayByViewType:type];
}


/*-(void)viewDidDisappear:(BOOL)animated
{
 //   NSLog(@"%@", @"Unload here...");
    [super viewDidDisappear:animated];
}*/

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)slideSettingViewController
{
    MaSettingViewController *c = [[MaSettingViewController alloc] init];
    MoreArtAppDelegate* app = (MoreArtAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    [app.revealSideViewController pushViewController:c onDirection:PPRevealSideDirectionLeft withOffset:SETTINGVIEW_OFFSET animated:YES];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataSourceMgr.dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSLog(@"cellForRowAtIndexPath =  %d", indexPath.row);
    static NSString *CellIdentifier = @"Cell";
    MaEZCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[MaEZCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.rightLayout = YES;
    cell.imgName = @"";

    cell.accessoryView = [[ UIImageView alloc ] initWithImage:[UIImage imageNamed:@"cellAccessory" ]];
    
    NSDictionary* dict = [_dataSourceMgr.dataSource objectAtIndex: indexPath.row];
        
    cell.titleString = [dict objectForKey:@"title"];
    cell.discriptionString = [dict objectForKey:@"discription"];
    NSString* imgName = [dict objectForKey:@"avatar"] ;
    
    if ([imgName length]>0) {
        CGFloat scale = [[UIScreen mainScreen] scale];
        NSMutableString* retinaImageName = [NSMutableString stringWithString:imgName];
        if (scale>1 && [imgName length] >0)
        {
            [retinaImageName appendString:@"@2x"];
            NSString* imgPath = [_dataSourceMgr.imageIndexDict objectForKey:retinaImageName];
            cell.imgName = imgPath;
        }
        else
        {
            NSString* imgPath = [_dataSourceMgr.imageIndexDict objectForKey:imgName];
            cell.imgName = imgPath;
        }
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//	get section array from dataSource
//	NSDictionary* dict = [dataSource objectAtIndex:indexPath.row];
    
    MaDetailViewController* viewController = [[MaDetailViewController alloc]init];
    viewController.indexPath = indexPath;
    NSDictionary* dict = [_dataSourceMgr.dataSource objectAtIndex: indexPath.row];
    viewController.navigationItem.title = [dict objectForKey:@"title"];
    
    [self.navigationController pushViewController: viewController animated:YES];
}

-(BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
	return YES;
}

-(NSInteger)supportedOrientations{
	NSInteger supportType;
	if ([self.view isKindOfClass:[MaPlainView class]]) {
		supportType =  UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskLandscape;
	}
	else if ([self.view isKindOfClass:[MaTableView class]]) {
		supportType =  UIInterfaceOrientationMaskPortrait; 
		if ([[self.navigationController topViewController] isKindOfClass:[MaDetailViewController class]] ||  [[self.navigationController topViewController] isKindOfClass:[MaImageGalleryViewController class]]) {
			supportType =  UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskLandscape;
		}
	}
	else
	{
		supportType =  UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskLandscape;
	}
	
	
	return supportType;
}


- (BOOL)shouldAutorotate {	
	return NO;
}


- (void) orientationChanged:(id)object
{
	
//	NSLog(@"%@",@"Base View OrientationChanged");
	
	UIInterfaceOrientation interfaceOrientation = [[object object] orientation];
    MoreArtAppDelegate* app = (MoreArtAppDelegate *)[[UIApplication sharedApplication] delegate];

	if (interfaceOrientation == UIInterfaceOrientationPortrait)
	{
        if (currentView)
        {
            self.view = currentView;
			currentView = nil;
            self.navigationController.navigationBarHidden = NO;
//            NSLog(@"%@", @"==== portrait");
        }

	}
	else if(interfaceOrientation == UIDeviceOrientationLandscapeRight|| interfaceOrientation == UIDeviceOrientationLandscapeLeft)
	{
		//if (((MaPlainView*)app.baseViewController.view).scaleImageView != nil) {
			//NSLog(@"%@", @"is ScaleImageView");}
		
		
		if (app.coverFlowView != self.view) {
//            NSLog(@"%@", @"==== landScape Mode");
            currentView = self.view;
        }
		
		if ([app.baseViewController.view isKindOfClass:[MaPlainView class]]) {
			NSArray* imageArray = ((MaPlainView*)app.baseViewController.view).imageViewArray ;
			[app.coverFlowView loadCoverFlowImageBy: imageArray];
		}

		
        self.view = app.coverFlowView;
        self.navigationController.navigationBarHidden = YES;
	}

	
}




@end
