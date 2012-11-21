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
    
    self.view.backgroundColor = [UIColor darkGrayColor];
    
    self.navigationItem.title = NSLocalizedString(@"douWo_Nav_Title",nil);
    MoreArtAppDelegate* app = (MoreArtAppDelegate *)[[UIApplication sharedApplication] delegate];
    [_dataSourceMgr updateDataSourceArrayByViewType:DOU_TYPE_DO_WUO];

    self.view = app.douWoView;
    
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"UIDeviceOrientationDidChangeNotification" object:nil];

	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationChanged:) name:@"UIDeviceOrientationDidChangeNotification" object:nil];
    
	self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(slideSettingViewController)];
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
    // get section array from dataSource
//    NSDictionary* dict = [dataSource objectAtIndex:indexPath.row];
    
    MaDetailViewController* viewController = [[MaDetailViewController alloc]init];
    viewController.indexPath = indexPath;
    NSDictionary* dict = [_dataSourceMgr.dataSource objectAtIndex: indexPath.row];
    viewController.navigationItem.title = [dict objectForKey:@"title"];
    
    [self.navigationController pushViewController: viewController animated:YES];
}


- (void) orientationChanged:(id)object
{
	UIInterfaceOrientation interfaceOrientation = [[object object] orientation];
    MoreArtAppDelegate* app = (MoreArtAppDelegate *)[[UIApplication sharedApplication] delegate];

	if (interfaceOrientation == UIInterfaceOrientationPortrait ||interfaceOrientation ==  UIInterfaceOrientationPortraitUpsideDown)
	{
        if (currentView)
        {
            self.view = currentView;
            self.navigationController.navigationBarHidden = NO;
//            NSLog(@"%@", @"==== portrait");
        }

	}
	else if(interfaceOrientation == UIDeviceOrientationLandscapeRight|| interfaceOrientation == UIDeviceOrientationLandscapeLeft)
	{
        if (app.coverFlowView != self.view) {
//            NSLog(@"%@", @"==== landScape Mode");
            currentView = self.view;
        }
        self.view = app.coverFlowView;
        self.navigationController.navigationBarHidden = YES;
	}
}



@end
