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
        NSString* path = [[NSBundle mainBundle] pathForResource:@"activityDataSource" ofType:@"plist"];
        //    NSLog(@"Datasource Location... %@", path);
        
        NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
        _allActivityArray = [dict objectForKey:@"ActivityArray"];
        _currentActivityArray = [[NSMutableArray alloc] init];
        _dataSource = [[NSMutableDictionary alloc] init];

    
    }

    return self;
}


-(void)updateSiteArray
{
    [_dataSource removeAllObjects];
    NSMutableArray* sectionArray = [[NSMutableArray alloc] init];
    
    // get all site name
    for (NSDictionary *dict in _currentActivityArray) {
        NSString* siteString = [dict objectForKey:@"site"];
        if(![sectionArray containsObject:siteString])
            [sectionArray addObject:siteString];
    }
    [_dataSource setObject:sectionArray forKey:@"sectionNameArray"];
    
    // seprate array by site name
    for(NSString* siteString in sectionArray)
    {
        NSMutableArray* secArray  = [[NSMutableArray alloc] init];
        for (NSDictionary *dict in _currentActivityArray) {
            NSString* string = [dict objectForKey:@"site"];
            if([string isEqualToString:siteString])
                [secArray addObject:dict];
            
        }
        [_dataSource setObject:secArray forKey:siteString];
    }
}

@end
