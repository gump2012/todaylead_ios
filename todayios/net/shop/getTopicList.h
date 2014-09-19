//
//  getTopicList.h
//  todayios
//
//  Created by gump on 9/19/14.
//  Copyright (c) 2014 gump. All rights reserved.
//

#import "baseRequest.h"

@interface getTopicList : baseRequest

-(void)requestWithLimit:(int)ilimit withPage:(int)ipage withTopic:(int)itopic;

@end
