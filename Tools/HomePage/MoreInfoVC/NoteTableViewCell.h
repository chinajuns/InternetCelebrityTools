//
//  NoteTableViewCell.h
//  网红评估工具
//
//  Created by More on 16/10/8.
//  Copyright © 2016年 More. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NoteTableViewCell : UITableViewCell<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *noteTextfield;
@property (weak, nonatomic) IBOutlet UILabel *plLable;

@end
