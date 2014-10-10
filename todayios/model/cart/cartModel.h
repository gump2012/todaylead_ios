//
//  cartModel.h
//  todayios
//
//  Created by gump on 9/30/14.
//  Copyright (c) 2014 gump. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface cartModel : NSObject
{
    NSString *_strurl;
    NSString *_strname;
    NSString *_strattrname;
    int      _number;
    float    _price;
    int      _pid;
    NSArray *_attrarr;
}

@property(nonatomic,strong) NSString *strurl;
@property(nonatomic,strong) NSString *strname;
@property(nonatomic,strong) NSString *strattrname;
@property(nonatomic,assign) int number;
@property(nonatomic,assign) float price;
@property(nonatomic,assign) int pid;
@property(nonatomic,strong) NSArray *attrarr;

@end
