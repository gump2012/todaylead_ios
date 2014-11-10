//
//  cartUpdate.h
//  todayios
//
//  Created by gump on 10/10/14.
//  Copyright (c) 2014 gump. All rights reserved.
//

#import "baseRequest.h"

@interface cartUpdate : baseRequest
{
    NSString *_strtype;
}
-(void)requestWithList:(NSString *)strlist withType:(NSString *)strtype;

@end
