//
//  getKeywordList.h
//  todayios
//
//  Created by gump on 9/17/14.
//  Copyright (c) 2014 gump. All rights reserved.
//

#import "baseRequest.h"

@interface getKeywordList : baseRequest
{
}

-(void)requestWithLimit:(int)ilimit withPage:(int)ipage withKeyword:(NSString *)strkey;

@end
