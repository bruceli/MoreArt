//
//  MaSettingViewController.m
//  WeiboNote
//
//  Created by Accthun He on 6/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MaSettingViewController.h"
#import "MoreArtAppDelegate.h"
#import "MaDefine.h"
@interface MaSettingViewController ()

@end

@implementation MaSettingViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    self.tableView.backgroundColor = [UIColor darkGrayColor];
    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"setting_bkg.png"]];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    MoreArtAppDelegate* app = (MoreArtAppDelegate *)[[UIApplication sharedApplication] delegate];
    

    NSArray* itemArray1 = [[NSArray alloc] initWithObjects:NSLocalizedString(@"douWo_Nav_Title",nil), app.douWoView, nil];
    NSArray* itemArray2 = [[NSArray alloc] initWithObjects:NSLocalizedString(@"douSpace_Nav_Title",nil), app.douSpaceView, nil];
    NSArray* itemArray3 = [[NSArray alloc] initWithObjects:NSLocalizedString(@"douBasePeking_Nav_Title",nil), app.douPeikingView, nil];
    NSArray* itemArray4 = [[NSArray alloc] initWithObjects:NSLocalizedString(@"moLangPhotography_Nav_Title",nil), app.moLangPhotoView, nil];
    NSArray* itemArray5 = [[NSArray alloc] initWithObjects:NSLocalizedString(@"art029_Nav_Title",nil), app.art029View, nil];
    NSArray* itemArrayTEST = [[NSArray alloc] initWithObjects:NSLocalizedString(@"TEST_COVERFLOW",nil), app.coverFlowView, nil];
     
    menuArray = [[NSMutableArray alloc] initWithObjects: itemArray1, itemArray2, itemArray3, itemArray4, itemArray5,itemArrayTEST, nil];
    
    NSArray* itemArray6 = [[NSArray alloc] initWithObjects:NSLocalizedString(@"about_Nav_Title",nil), app.aboutView, nil];
    moreArray = [[NSMutableArray alloc] initWithObjects:itemArray6 , nil];
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 2;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    NSString *sectionTitle =  @"Title";
    
    // Create label with section title
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(5, 0, 284, 23);
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont fontWithName:@"STHeitiTC-Medium" size:17];
    label.text = sectionTitle;
    label.backgroundColor = [UIColor clearColor];
    
    // Create header view and add label as a subview
    //    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 100)];
    UIImageView* view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"setting_header_section"]];
    [view addSubview:label];
    
    return view;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger count = 0;
    if (section == 0) 
        count =  [menuArray count];
    else
        count =  [moreArray count];
    
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray* itemArray;
    if (indexPath.section == 0) 
        itemArray = [menuArray objectAtIndex:indexPath.row];
    else
        itemArray = [moreArray objectAtIndex:indexPath.row];

    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    
    cell.textLabel.text = [itemArray objectAtIndex:MA_MENU_TITLE];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.font = [UIFont fontWithName:@"STHeitiSC-Medium" size:16];
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MoreArtAppDelegate* app = (MoreArtAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSArray* itemArray;
    if (indexPath.section == 0)
        itemArray = [menuArray objectAtIndex:indexPath.row];
    else
        itemArray = [moreArray objectAtIndex:indexPath.row];

    app.baseViewController.view = [itemArray objectAtIndex:MA_MENU_CONTROLLER];
    app.baseViewController.navigationItem.title = [itemArray objectAtIndex:MA_MENU_TITLE];
    
    [self.revealSideViewController popViewControllerAnimated:YES];
    
}

@end
