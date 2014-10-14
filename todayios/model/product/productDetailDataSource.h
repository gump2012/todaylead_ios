//
//  productDetailDataSource.h
//  todayios
//
//  Created by gump on 8/23/14.
//  Copyright (c) 2014 gump. All rights reserved.
//

#import "baseDataSource.h"

enum{
    BASEATTR_HIDE,
    BASEATTR_SHOW,
};

@interface productDetailDataSource : baseDataSource
{
}
@property(nonatomic,assign) int ibaseAttr;
@property(nonatomic,assign) int iSelectNum;
@property(nonatomic,strong) NSString *SelectAttrId;

+ (productDetailDataSource *)shareInstance;
-(NSString *)getTitle;
-(float)getPrice;
-(float)getOldPrice;
-(int)getAlreadyBuy;
-(int)getrecentvolume;
-(NSArray *)getAttrList;
@end
