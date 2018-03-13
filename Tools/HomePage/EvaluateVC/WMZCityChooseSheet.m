//
//  WMZCityChooseSheet.m
//  网红评估工具
//
//  Created by More on 16/9/30.
//  Copyright © 2016年 More. All rights reserved.
//

#import "WMZCityChooseSheet.h"
static CGFloat MainScreenHeight = 0;
static CGFloat MainScreenWidth = 0;

@interface WMZCityChooseSheet ()<UIPickerViewDataSource,UIPickerViewDelegate>{
    NSString *city;

}

@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, strong) UIButton *btnDone;
@property (nonatomic, strong) UIButton *btnCancel;

@property (strong, nonatomic)  UIPickerView *pickerView;
@property (nonatomic,strong)NSArray * provinces;//展示省份
@property (nonatomic,strong)NSArray * cities;//展示城市
@end
@implementation WMZCityChooseSheet

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        MainScreenHeight = [UIScreen mainScreen].bounds.size.height;
        MainScreenWidth = [UIScreen mainScreen].bounds.size.width;
        [self setBackgroundColor:[UIColor colorWithWhite:0.5 alpha:0.5]];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickEmpty:)];
        [self addGestureRecognizer:tap];
        city  = @"北京市 东城区";
        NSString * path = [[NSBundle mainBundle]pathForResource:@"area" ofType:@"plist"];
        self.provinces = [NSArray arrayWithContentsOfFile:path];
        self.cities = [NSArray arrayWithArray:self.provinces[0][@"Cities"]];
    
        [self makeUI];
    }
    return self;
}
- (void)makeUI {
    
    _containerView = [[UIView alloc] initWithFrame:CGRectMake(0, MainScreenHeight - 250 , MainScreenWidth , 290)];
    _containerView.backgroundColor = [UIColor colorWithHexString:@"1C1C1C"];
    _containerView.layer.cornerRadius = 3;
    _containerView.layer.masksToBounds = YES;
    
    _pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 50, MainScreenWidth, 150)];
    _pickerView.backgroundColor = [UIColor colorWithHexString:@"ffffff"];
    _pickerView.showsSelectionIndicator = YES;

    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    [_containerView addSubview:_pickerView];

    
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(16, 0, 200, 50)];
    label.text = @"城市";
    label.textColor = [UIColor whiteColor];
    [_containerView addSubview:label];
    
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
        return 2;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    NSInteger rows = 0;
        switch (component) {
            case 0:
                rows = self.provinces.count;
                break;
            case 1:
                rows = self.cities.count;
                break;
            default:
                break;
        }
    
    
    return rows;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSString * title = nil;
        switch (component) {
            case 0:
                title = self.provinces[row][@"State"];
                break;
            case 1:
                title = self.cities[row][@"city"];
                break;
            default:
                break;
        }
    
    
    return title;
}

//选中时回调的委托方法，在此方法中实现省份和城市间的联动
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
        switch (component) {
            case 0://选中省份表盘时，根据row的值改变城市数组，刷新城市数组
                self.cities = self.provinces[row][@"Cities"];
                [self.pickerView reloadComponent:1];
                city =  [NSString stringWithFormat:@"%@ %@",self.provinces[[self.pickerView selectedRowInComponent:0]][@"State"],self.cities[[self.pickerView selectedRowInComponent:1]][@"city"]];
                
                break;
            case 1:
                city =  [NSString stringWithFormat:@"%@ %@",self.provinces[[self.pickerView selectedRowInComponent:0]][@"State"],self.cities[[self.pickerView selectedRowInComponent:1]][@"city"]];
                //            NSLog(@"当前选择目的地为：%@%@",self.provinces[[self.pickerView selectedRowInComponent:0]][@"State"],self.cities[[self.pickerView selectedRowInComponent:1]][@"city"]);
                //            self.label.text = [NSString stringWithFormat:@"%@%@",self.provinces[[self.pickerView selectedRowInComponent:0]][@"State"],self.cities[[self.pickerView selectedRowInComponent:1]][@"city"]];
                break;
                
            default:
                break;
        }
//        [cityCell.typeBtn setTitle:city forState:UIControlStateNormal];
        NSLog(@"%@",city    );
    
    
}
//设置组件中每行的高度
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 30;
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
    if (self.GetSelectCity) {
        _GetSelectCity(city);
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
