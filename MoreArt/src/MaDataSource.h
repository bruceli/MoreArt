//
//  MaDataSource.h
//  MoreArt
//
//  Created by Thunder on 8/25/12.
//  Copyright (c) 2012 MagicApp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MaDataSource : NSObject
{
    NSMutableArray* _allActivityArray;
    NSMutableArray* _currentActivityArray;
    
    NSMutableDictionary* _dataSource;
}
@property (nonatomic, retain) NSMutableDictionary* dataSource;


@end
