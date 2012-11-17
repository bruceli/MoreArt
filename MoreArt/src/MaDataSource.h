//
//  MaDataSource.h
//  MoreArt
//
//  Created by Thunder on 8/25/12.
//  Copyright (c) 2012 MagicApp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MaDefine.h"

@interface MaDataSource : NSObject
{
    NSMutableArray* _enumActivitiesArray;
    NSMutableArray* _currentActivityArray;
    NSDictionary* _rootDictonary;
    NSMutableDictionary* _imageIndexDict;
    
    
    NSMutableArray* _dataSource;
}
@property (nonatomic, retain) NSMutableArray* dataSource;
@property (nonatomic, retain) NSMutableDictionary* imageIndexDict;

-(void)updateDataSourceArrayByViewType:(MaDouViewType)type;

@end
