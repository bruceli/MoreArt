//
//  MaDetailViewController.m
//  MoreArt
//
//  Created by Thunder on 9/2/12.
//  Copyright (c) 2012 MagicApp. All rights reserved.
//

#import "MaDetailViewController.h"

@interface MaDetailViewController ()

@end

@implementation MaDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    CGRect bounds = [ [ UIScreen mainScreen ] applicationFrame ];
    _scrollView = [[UIScrollView alloc ] initWithFrame:bounds ];
    _scrollView.alwaysBounceVertical=YES;
    
    self.view = _scrollView;
    _scrollView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"setting_bkg.png"]];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 310, 35)];
    _headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 45, 210, 100)];
    _imgView = [[UIImageView alloc ] initWithFrame:CGRectMake(220, 45, 95, 100)];
    _bodyLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 150, 310, 400)];
    
    _titleLabel.backgroundColor = [UIColor darkGrayColor];
    _headerLabel.backgroundColor = [UIColor darkGrayColor];
    _imgView.backgroundColor = [UIColor darkGrayColor];
    _bodyLabel.backgroundColor = [UIColor darkGrayColor];

    [self.view addSubview:_titleLabel];
    [self.view addSubview:_headerLabel];
    [self.view addSubview:_imgView];
    [self.view addSubview:_bodyLabel];
    
    
    // BodyLabel resize here
    
    // add ending Label
    CGRect rect = _bodyLabel.frame;
    _endingLabel = [[UILabel alloc] initWithFrame:CGRectMake(rect.origin.x, rect.origin.y+rect.size.height+5, 310, 20)];
    _endingLabel.backgroundColor = [UIColor darkGrayColor];
    [self.view addSubview:_endingLabel];
    
    // set scroll view size
    CGSize viewSize = CGSizeMake(_titleLabel.frame.size.width, _endingLabel.frame.origin.y+_endingLabel.frame.size.height+10);

    _scrollView.contentSize = viewSize;

    
//    self.navigationController.title = @"title";

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

@end
