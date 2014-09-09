//
//  commentView.h
//  todayios
//
//  Created by gump on 9/8/14.
//  Copyright (c) 2014 gump. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface commentView : UIView
{
    UILabel *_namelabel;
    UILabel *_contentlabel;
    UILabel *_timelabel;
}

-(void)setTextWithDictionary:(NSDictionary*)dic;
@end
