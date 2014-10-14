//
//  baseRequest.m
//  todayios
//
//  Created by lishiming on 14-7-21.
//  Copyright (c) 2014年 lishiming. All rights reserved.
//

#import "baseRequest.h"

@implementation baseRequest

-(id)init{
    self = [super init];
    if (self) {
        
    }
    
    return self;
}

-(void)request{
    
}

-(NSString *)getDefaultValue{
    NSString *str = [NSString stringWithFormat:
                     @"&device_id=%@&platform=ios&vc=1&vn=1.0.0&channel=appstore&sw=320&sh=480&alias=jrtp",
                     [CP shareInstance].idfv];
    
    return str;
}

-(NSString *)getDoMain{
    NSString *str = [NSString stringWithFormat:@"%@:%@",@"http://192.168.1.102",MAIN_PORT];
    return str;
}

@end
