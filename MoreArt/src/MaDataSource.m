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
@synthesize imageIndexDict = _imageIndexDict;


-(id)init
{
    self = [super init];
    
    if (self) {
        NSLog(@"%@", @"Init DataSourceMgr");
    //    NSLog(@"%@", @"/");

        NSString* path = [[NSBundle mainBundle] pathForResource:@"activityDataSource" ofType:@"plist"];
        //    NSLog(@"Datasource Location... %@", path);
        
        _rootDictonary = [[NSDictionary alloc] initWithContentsOfFile:path];
        _enumActivitiesArray = [_rootDictonary objectForKey:@"enumArray"];
        _currentActivityArray = [[NSMutableArray alloc] init];
        _dataSource = [[NSMutableArray alloc] init];
//        _dataSource  = [_rootDictonary objectForKey:[_enumActivitiesArray objectAtIndex:DOU_TYPE_DO_WUO]];
        [self loadImageIndex];
    }
    return self;
}


-(void)updateDataSourceArrayByViewType:(MaDouViewType)type
{
    [_dataSource removeAllObjects];
//    NSLog(@"%@", @"UpdateSiteArray");
    
    /*
     Get Array Name from enumArray type;
     Get array from Root ditionary;
     */
    
    NSString* arrayName = [_enumActivitiesArray objectAtIndex:type];
    [_dataSource addObjectsFromArray:[_rootDictonary objectForKey:arrayName]];
}

-(void)loadImageIndex
{
    _imageIndexDict = [[NSMutableDictionary alloc] init];
    
    // Load imageIndex file.
    NSString* path = [[NSBundle mainBundle] pathForResource:@"imageIndex" ofType:@"plist"];
    //    NSLog(@"Datasource Location... %@", path);
    NSDictionary* imageIndex = [[NSDictionary alloc] initWithContentsOfFile:path];
    NSString* sourceString = [imageIndex objectForKey:@"imageIndex"];
    
    // Fill all Item into Dict;
    NSString* withoutHeader = [sourceString stringByReplacingOccurrencesOfString:
                               [imageIndex objectForKey:@"headerString"] withString:@""];
    NSString* withoutMidd = [withoutHeader stringByReplacingOccurrencesOfString:
                             [imageIndex objectForKey:@"midString"] withString:@","];
    NSString* finalString = [withoutMidd stringByReplacingOccurrencesOfString:
                             [imageIndex objectForKey:@"endString"] withString:@"|"];
    
    //   NSLog(@"%@",finalString);
    
    for (int i = 0 ; i< ([finalString length]-1); ) {
        
        NSRange targetRange = NSMakeRange(i, [finalString length]-i);
        //        NSLog(@"targetRange is %@", NSStringFromRange(targetRange));
        
        NSRange subRange = [finalString rangeOfString:@"|" options:NSCaseInsensitiveSearch range: targetRange];
        //        NSLog(@"subRange is %@", NSStringFromRange(subRange));
        if(subRange.location == NSNotFound)
            break;
        
        NSRange itemRange = NSMakeRange(i, subRange.location -i );
        //        NSLog(@"itemRange is %@", NSStringFromRange(itemRange));
        
        NSString* itemString = [finalString substringWithRange:itemRange];
        //        NSLog(@"%@",itemString);
        
        NSRange splitRange = [itemString rangeOfString:@","];
        NSString* imagePath = [itemString substringWithRange:NSMakeRange(0, splitRange.location )];
        NSString* nameIndex = [itemString substringWithRange:NSMakeRange(splitRange.location + 1 ,itemString.length - splitRange.location -1)];
        
        [_imageIndexDict setObject:imagePath forKey:nameIndex];
        
        i=subRange.location+1;
    }
}


@end
