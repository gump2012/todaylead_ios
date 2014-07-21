//
//  getShopAdList.h
//  todayios
//
//  Created by lishiming on 14-7-21.
//  Copyright (c) 2014年 lishiming. All rights reserved.
//

#import "baseRequest.h"

@interface getShopAdList : baseRequest
{
    NSString *_strcid;
}
@property(nonatomic,strong)NSString* strcid;

@end
