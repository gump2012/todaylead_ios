//
//  productDetailDataSource.h
//  todayios
//
//  Created by gump on 8/23/14.
//  Copyright (c) 2014 gump. All rights reserved.
//

@interface productDetailDataSource : NSObject
{
    NSMutableDictionary *_detailDic;
}

@property(nonatomic,strong) NSMutableDictionary *detailDic;

+ (productDetailDataSource *)shareInstance;
-(NSString *)getTitle;
-(float)getPrice;
-(float)getOldPrice;
-(int)getAlreadyBuy;
-(int)getrecentvolume;
@end
