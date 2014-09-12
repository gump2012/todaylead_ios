//
//  AttrCellView.h
//  todayios
//
//  Created by gump on 9/12/14.
//  Copyright (c) 2014 gump. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AttrCellView : UIView
{
    UILabel *_textLabel;
    NSDictionary *_dic;
}

@property (nonatomic,copy) void (^clickblock)(NSDictionary *,int);

-(void)setDic:(NSDictionary *)dic;
-(void)selectCell:(BOOL)bselect;

@end
