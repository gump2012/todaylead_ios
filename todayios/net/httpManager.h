//
//  httpManager.h
//  todayios
//
//  Created by lishiming on 14-7-21.
//  Copyright (c) 2014年 lishiming. All rights reserved.
//

#import <Foundation/Foundation.h>
@class getShopAdList;
@class getShopTop;
@class getProductDetail;
@class getPromotionList;
@class getProductHtml;
@class getProductReport;
@class getProComment;

@interface httpManager : NSObject
{
    getShopAdList *_getshopad;
    getShopTop  *_getshoptop;
    getProductDetail *_ProductDetail;
    getPromotionList *_promotionlist;
    getProductHtml  *_productHtml;
    getProductReport *_proReport;
    getProComment *_proComment;
}

@property(nonatomic,strong) getShopAdList *getshopad;
@property(nonatomic,strong) getShopTop *getshoptop;
@property(nonatomic,strong) getProductDetail *ProductDetail;
@property(nonatomic,strong) getPromotionList *promotionlist;
@property(nonatomic,strong) getProductHtml  *productHtml;
@property(nonatomic,strong) getProductReport *proReport;
@property(nonatomic,strong) getProComment   *proComment;

+ (httpManager *)shareInstance;

@end
