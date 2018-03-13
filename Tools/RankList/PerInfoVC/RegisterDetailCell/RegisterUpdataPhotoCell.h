//
//  RegisterSexChooseCell.h
//  钱转转
//
//  Created by More on 16/11/3.
//  Copyright © 2016年 More. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterUpdataPhotoCell : UITableViewCell<UIImagePickerControllerDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
///类型名称
@property(nonatomic,strong)UILabel *typeLable;
///详细名称
@property(nonatomic,strong)UILabel *typeDetialLable;
///
@property(nonatomic,strong)UIButton *firstUPBtn;
@property(nonatomic,strong)UIButton *seconedUPBtn;


@property(nonatomic,assign)NSInteger flag;
@property (nonatomic, copy) void(^ChooseFirImage)(NSString *imageUrl);

@property (nonatomic, copy) void(^ChooseSecondImage)(NSString *imageUrl);
-(void)changeValue;
;
@end
