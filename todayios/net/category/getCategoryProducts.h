//
//  getCategoryProducts.h
//  todayios
//
//  Created by gump on 9/21/14.
//  Copyright (c) 2014 gump. All rights reserved.
//

#import "baseRequest.h"

@interface getCategoryProducts : baseRequest
{
    int _ipage;
}
-(void)requestWithLimit:(int)ilimit withPage:(int)ipage withCid:(int)icid;

@end
