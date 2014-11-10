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
    int      _number;
    float    _price;
    int      _pid;
    NSMutableArray *_attrarr;
    BOOL     _isSelect;
    int      _editNumber;
}

@property(nonatomic,strong) NSString *strurl;
@property(nonatomic,strong) NSString *strname;
@property(nonatomic,assign) int number;
@property(nonatomic,assign) float price;
@property(nonatomic,assign) int pid;
@property(nonatomic,strong) NSMutableArray *attrarr;
@property(nonatomic,assign) BOOL isSelect;
@property(nonatomic,assign) int editNumber;

+(cartModel *)creatCartByDic:(NSDictionary *)dic;

@end
