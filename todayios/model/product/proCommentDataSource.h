//
//  proCommentDataSource.h
//  todayios
//
//  Created by gump on 9/7/14.
//  Copyright (c) 2014 gump. All rights reserved.
//

#import "baseDataSource.h"

enum {
    COMMENT_HIDE,
    COMMENT_READYSHOW,
    COMMENT_SHOW,
};

@interface proCommentDataSource : baseDataSource

@property(nonatomic,assign) int commentType;

+ (proCommentDataSource *)shareInstance;

@end
