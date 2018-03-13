//
//  NoteTableViewCell.m
//  网红评估工具
//
//  Created by More on 16/10/8.
//  Copyright © 2016年 More. All rights reserved.
//

#import "NoteTableViewCell.h"

@implementation NoteTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
//    _noteTextfield.layer.cornerRadius=5;
//    _noteTextfield.clipsToBounds = YES;
////    _noteTextfield.layer.borderColor =[UIColor lightGrayColor].CGColor;
//    _noteTextfield.layer.borderWidth =1;
    // Initialization code
    _noteTextfield.delegate =self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)textViewDidBeginEditing:(UITextView *)textView{
    _plLable.hidden=YES;
}
-(void)textViewDidEndEditing:(UITextView *)textView{
    if (!(textView.text.length>0)) {
        _plLable.hidden = NO;
    }
}
@end
