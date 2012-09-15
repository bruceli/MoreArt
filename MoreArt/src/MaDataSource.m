//
//  MaDataSource.m
//  MoreArt
//
//  Created by Thunder on 8/25/12.
//  Copyright (c) 2012 MagicApp. All rights reserved.
//

#import "MaDataSource.h"


@implementation MaDataSource
@synthesize dataSource = _dataSource;

-(id)init
{
    self = [super init];
    
    if (self) {
        NSLog(@"%@", @"Init DataSourceMgr");

        NSString* path = [[NSBundle mainBundle] pathForResource:@"activityDataSource" ofType:@"plist"];
        //    NSLog(@"Datasource Location... %@", path);
        
        _rootDictonary = [[NSDictionary alloc] initWithContentsOfFile:path];
        _enumActivitiesArray = [_rootDictonary objectForKey:@"enumArray"];
        _currentActivityArray = [[NSMutableArray alloc] init];
        _dataSource = [[NSMutableArray alloc] init];
//        _dataSource  = [_rootDictonary objectForKey:[_enumActivitiesArray objectAtIndex:DOU_TYPE_DO_WUO]];

        
    }

    return self;
}


-(void)updateDataSourceArrayByViewType:(MaDouViewType)type
{
    [_dataSource removeAllObjects];
    NSLog(@"%@", @"UpdateSiteArray");
    
    /*
     Get Array Name from enumArray type;
     Get array from Root ditionary;
     */
    
    NSString* arrayName = [_enumActivitiesArray objectAtIndex:type];
    [_dataSource addObjectsFromArray:[_rootDictonary objectForKey:arrayName]];
    
    
}

@end
