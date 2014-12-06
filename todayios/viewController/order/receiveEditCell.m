//
//  receiveEditCell.m
//  todayios
//
//  Created by gump on 11/22/14.
//  Copyright (c) 2014 gump. All rights reserved.
//

#import "receiveEditCell.h"
#import "confirmAddressDataSource.h"

@implementation receiveEditCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _textLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 4.0f, 100.0f, 40.0f)];
        _textLabel.text = @"收 货 人:";
        _textLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onLabelClick:)];
        [_textLabel addGestureRecognizer:singleTap];
        [self.contentView addSubview:_textLabel];
        _textLabel.font = [UIFont systemFontOfSize:12.0f];
        _textLabel.textColor = [UIColor grayColor];
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(100.0f, 4.0f, 200.0f, 40.0f)];
        _textField.delegate = self;
        [_textField addTarget:self action:@selector(editingChanged:) forControlEvents:UIControlEventEditingChanged];
        [self.contentView addSubview:_textField];
        
        self.labelclick = nil;
        self.textclick = nil;
        
        NSNotificationCenter *center=[NSNotificationCenter defaultCenter];
        [center addObserver:self
                   selector:@selector(showpick:)
                       name:NotifyConfirmHideAddressPick
                     object:nil];
    }
    return self;
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)showpick:(id)sender{
    if ([_textField isFirstResponder]) {
        [_textField resignFirstResponder];
    }
}

-(void)onLabelClick:(id)sender{
    if (self.labelclick) {
        self.labelclick();
    }
}

-(void)refreshCell:(NSString *)strtitle{
    _textLabel.text = strtitle;
    switch (self.itag) {
        case 0:
            _textField.text = [confirmAddressDataSource shareInstance].name;
            break;
        case 1:{
            _textField.text = [confirmAddressDataSource shareInstance].phone;
        }
            break;
        case 3:{
            _textField.text = [confirmAddressDataSource shareInstance].address;
        }
            break;
        default:
            break;
    }
}

- (BOOL)textField:(UITextField*)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSString *text = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if ([CP shareInstance].deviceVersion < 7.0) {
        switch (self.itag) {
            case 0:
                [confirmAddressDataSource shareInstance].name = text;
                break;
            case 1:{
                [confirmAddressDataSource shareInstance].phone = text;
            }
                break;
            case 3:{
                [confirmAddressDataSource shareInstance].address = text;
            }
                break;
            default:
                break;
        }
    }
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (self.textclick) {
        self.textclick();
    }
    
    return YES;
}

- (void)editingChanged:(id)sender {
    if ([CP shareInstance].deviceVersion >= 7.0) {
        UITextField *tmpTextField = (UITextField *)sender;
        NSString *newString = [tmpTextField text];
        switch (self.itag) {
            case 0:
                [confirmAddressDataSource shareInstance].name = newString;
                break;
            case 1:{
                [confirmAddressDataSource shareInstance].phone = newString;
            }
                break;
            case 3:{
                [confirmAddressDataSource shareInstance].address = newString;
            }
                break;
            default:
                break;
        }
    }

}

@end
