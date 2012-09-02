//
//  MaEZCell.m
//  MoreArt
//
//  Created by Accthun He on 6/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MaEZCell.h"
//#import "NSDate-Utilities.h"

@implementation MaEZCell
@synthesize titleString = _titleString;
@synthesize imgName = _imgName;
@synthesize rightLayout = _rightLayout;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        _rightLayout = false;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)layoutSubviews{
    [super layoutSubviews];
    
    if (!_rightLayout) {
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(7, 10, 70, 55)];
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(85, 5,210 , 25)];
        _detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(85, 35, 210, 35)];
    }
    else
    {
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(225, 10, 70, 55)];
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(7, 5,210 , 25)];
        _detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(7, 35, 210, 35)];

    }
    //        _isSchCell = YES;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self addSubview:_titleLabel];
    [self addSubview:_detailLabel];
    [self addSubview:_imgView];

    
    self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"setting_bkg.png"]];
    _titleLabel.backgroundColor = [UIColor lightGrayColor];
    _detailLabel.backgroundColor = [UIColor lightGrayColor];
    _imgView.backgroundColor = [UIColor grayColor];
    
    _titleLabel.text = _titleString;
    _titleLabel.font = [UIFont fontWithName:@"STHeitiTC-Medium" size:19];
    _titleLabel.textColor = [UIColor darkGrayColor];
//    _titleLabel.shadowOffset = CGSizeMake(1.0f, 1.0f);
//    titleLabel.shadowBlur = 3.0f;

    NSMutableString* imagetitleString = [NSMutableString stringWithString:_imgName];
    [imagetitleString appendString:@".jpeg"];
    UIImage* bandImg = [UIImage imageNamed:imagetitleString];
    _imgView.image = bandImg;
}



@end
