//
//  receiveEditCell.h
//  todayios
//
//  Created by gump on 11/22/14.
//  Copyright (c) 2014 gump. All rights reserved.
//

#import "BaseCell.h"

@interface receiveEditCell : BaseCell<UITextFieldDelegate>
{
    UILabel *_textLabel;
    UITextField *_textField;
}

@property(nonatomic,assign) int itag;
@property(nonatomic,copy) void(^labelclick)(void);
@property(nonatomic,copy) void(^textclick)(void);

-(void)refreshCell:(NSString *)strtitle;
@end
