//
//  productPromotionDataSource.h
//  todayios
//
//  Created by gump on 9/3/14.
//  Copyright (c) 2014 gump. All rights reserved.
//

@interface productPromotionDataSource : NSObject
{
    NSMutableDictionary *_dataDic;
}

@property(nonatomic,strong) NSMutableDictionary *dataDic;

+ (productPromotionDataSource *)shareInstance;
-(NSArray *)getPromotionList;
@end
