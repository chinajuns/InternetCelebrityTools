//
//  WMZHeightActionSheet.m
//  网红评估工具
//
//  Created by More on 16/10/18.
//  Copyright © 2016年 More. All rights reserved.
//

#import "WMZHeightActionSheet.h"
static CGFloat MainScreenHeight = 0;
static CGFloat MainScreenWidth = 0;

@interface WMZHeightActionSheet ()<UIPickerViewDataSource,UIPickerViewDelegate>{
    NSString *resultStr;
    
}

@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, strong) UIButton *btnDone;
@property (nonatomic, strong) UIButton *btnCancel;

@property (strong, nonatomic)  UIPickerView *pickerView;
@property(nonatomic,strong)NSMutableArray *dataArr;

@end
@implementation WMZHeightActionSheet
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        MainScreenHeight = [UIScreen mainScreen].bounds.size.height;
        MainScreenWidth = [UIScreen mainScreen].bounds.size.width;
        [self setBackgroundColor:[UIColor colorWithWhite:0.5 alpha:0.5]];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickEmpty:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}
- (void)makeUI {
    _containerView = [[UIView alloc] initWithFrame:CGRectMake(0, MainScreenHeight - 250 , MainScreenWidth , 290)];
    _containerView.backgroundColor = [UIColor colorWithHexString:@"1C1C1C"];
    _containerView.layer.cornerRadius = 3;
    _containerView.layer.masksToBounds = YES;
    
    _pickerView = [[UIPickerView   alloc]initWithFrame:CGRectMake(0, 50, MainScreenWidth , 150)];
    _pickerView.backgroundColor = [UIColor colorWithHexString:@"f5f5f5"];
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    _pickerView.showsSelectionIndicator = YES;
    [_containerView addSubview:_pickerView];
    //是否要显示选中的指示器(默认值是NO)
    
    _label = [[UILabel alloc]initWithFrame:CGRectMake(16, 0, 200, 50)];
    _label.text = _titleStr;
    _label.textColor = [UIColor whiteColor];
    [_containerView addSubview:_label];
    _dataArr = [[NSMutableArray alloc]init];
    if ([_titleStr isEqualToString:@"身高(cm)"]) {
        int height = 120;
        for (int i =0; i<100; i++) {
            [_dataArr addObject:[NSString stringWithFormat:@"%d",height+i]];
        }
    }else{
        int weight = 30;
        for (int i =0; i<100; i++) {
            [_dataArr addObject:[NSString stringWithFormat:@"%d",weight+i]];
        }
    }
    
    resultStr = _dataArr[0];
    _btnDone = [UIButton buttonWithType:UIButtonTypeCustom];
    _btnDone.frame = CGRectMake(SCREEN_WIDTH-66, 0, 50, 50);
    _btnDone.titleLabel.font = [UIFont systemFontOfSize:20];
    [_btnDone setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [_btnDone setTitle:@"确定" forState:UIControlStateNormal];
    [_btnDone addTarget:self action:@selector(doneAction:) forControlEvents:UIControlEventTouchUpInside];
    [_containerView addSubview:_btnDone];
    
    _btnCancel = [UIButton buttonWithType:UIButtonTypeCustom];
    _btnCancel.frame =   CGRectMake(SCREEN_WIDTH-66-66, 0, 50 , 50) ;
    _btnCancel.titleLabel.font = [UIFont systemFontOfSize:20];
    
    [_btnCancel setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [_btnCancel setTitle:@"取消" forState:UIControlStateNormal];
    [_btnCancel addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
    [_containerView addSubview:_btnCancel];
    
    
    [self addSubview:_containerView];
}


-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
//    if (component==0) {
//        return 3;
//    }
    NSInteger rows =_dataArr.count;
    return rows;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return _dataArr[row];
}
//设置组件中每行的高度
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
  return 30;
}
//选中时回调的委托方法，在此方法中实现省份和城市间的联动
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
//    if ([self.pickerView selectedRowInComponent:0] ==0 ) {
//        resultStr = [NSString stringWithFormat:@"%ld%ld",(long)[self.pickerView selectedRowInComponent:1],(long)[self.pickerView selectedRowInComponent:2]];
//    }else{
//        resultStr = [NSString stringWithFormat:@"%ld%ld%ld",(long)[self.pickerView selectedRowInComponent:0],(long)[self.pickerView selectedRowInComponent:1],(long)[self.pickerView selectedRowInComponent:2]];
//    }
    resultStr = _dataArr[row];
   }

-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont boldSystemFontOfSize:20]];
    }
    // Fill the label text here
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}
#pragma mark - private method
- (void)clickEmpty:(UITapGestureRecognizer *)tap {
    [self removeFromSuperview];
}
#pragma mark - Action
- (void)doneAction:(UIButton *)btn {
    if (self.GetSelectStr) {
        _GetSelectStr(resultStr);
        [self removeFromSuperview];
    }
}

- (void)cancelAction:(UIButton *)btn {
    [self removeFromSuperview];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
