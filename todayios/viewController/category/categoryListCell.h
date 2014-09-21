//
//  categoryListCell.h
//  todayios
//
//  Created by gump on 9/21/14.
//  Copyright (c) 2014 gump. All rights reserved.
//

#import "BaseCell.h"

@interface categoryListCell : BaseCell
{
    UIImageView *_imageview;
    UILabel *_namelabel;
    UILabel *_describelabel;
}

-(void)refreshCellWithDic:(NSDictionary *)dic;
@end
