//
//  MessageViewController.m
//  网红评估工具
//
//  Created by More on 16/9/28.
//  Copyright © 2016年 More. All rights reserved.
//

#import "MessageViewController.h"
#import "MessageNet.h"

@interface MessageViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray<MessageModel *> *dataArr;

}
@property (nonatomic, strong) NSMutableArray *resultArray;

@end

@implementation MessageViewController


- (void)scrollViewToBottom:(BOOL)animated{
//    if (self.tabView.contentSize.height > self.tabView.frame.size.height)
//    {
//        CGPoint offset = CGPointMake(0, self.tabView.contentSize.height - self.tabView.frame.size.height);
//        [self.tabView setContentOffset:offset animated:NO];
//    }
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
      if (!DEF_PERSISTENT_GET_OBJECT(@"message")) {
          [SVProgressHUD show];
      }
    [self.tabBarController.tabBar hideBadgeOnItemIndex:2];
    [ MessageNet getallMessagePar:nil success:^(NSArray<MessageModel *> *arr) {
        dataArr = arr;
        NSMutableArray *defArr = [[NSMutableArray alloc]init];
        for (NSDictionary *con  in arr) {
            [defArr addObject:[MYObjectToNsDictionary getObjectData:con]];
        }
        
        DEF_PERSISTENT_SET_OBJECT(defArr, @"message");

        [_tabView reloadData];
        [  self scrollViewToBottom:YES];
        [SVProgressHUD dismiss];
  }];

    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
}

-(void)viewWillDisappear:(BOOL)animated{

}
- (void)viewDidLoad {
    [super viewDidLoad];

    [self.navigationController.navigationBar setTitleTextAttributes:
     
  @{NSFontAttributeName:[UIFont systemFontOfSize:19],
    
    NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    
    if (DEF_PERSISTENT_GET_OBJECT(@"message")) {
        
        NSError *err;
        NSMutableArray *arr = [[NSMutableArray alloc]init];
        NSLog(@"%@",DEF_PERSISTENT_GET_OBJECT(@"message"));
        for (NSDictionary *dic in DEF_PERSISTENT_GET_OBJECT(@"message")) {
            
            [arr addObject: [[MessageModel alloc]initWithDictionary:dic error:&err]];
        }
        dataArr = arr;
        [_tabView reloadData];
        [  self scrollViewToBottom:YES];

    }
    
    
    [self ZJ_CustomNaviRightButton:nil];
    [self.navigationItem setHidesBackButton:YES animated:NO];
    self.title = @"消息";
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tabView.delegate =self;
    _tabView.dataSource =self;
    _resultArray = (NSMutableArray *)DEF_PERSISTENT_GET_OBJECT(@"Message");
    
   [ MessageNet getallMessagePar:@{@"page":@"1"} success:^(NSArray *arr) {
        
    }];
}
//泡泡文本
- (UIView *)bubbleView:(NSString *)text  time:(NSString *)time withPosition:(int)position{
    
    //计算大小
    UIFont *font = [UIFont systemFontOfSize:14];
    CGSize size = [text sizeWithFont:font constrainedToSize:CGSizeMake(SCREEN_WIDTH-100, 20000.0f) lineBreakMode:NSLineBreakByWordWrapping];
    
    // build single chat bubble cell with given text
    UIView *returnView = [[UIView alloc] initWithFrame:CGRectZero];
    returnView.backgroundColor = [UIColor clearColor];
    
    //背影图片
    UIImage *bubble = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"矩形气泡 (1)" ofType:@"png"]];
    
    UIImageView *bubbleImageView = [[UIImageView alloc] initWithImage:[bubble stretchableImageWithLeftCapWidth:floorf(bubble.size.width/2) topCapHeight:floorf(bubble.size.height/3*2)]];
    
    
    CGSize timesize = [time sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:CGSizeMake(1000.f, 20000.0f) lineBreakMode:NSLineBreakByWordWrapping];
    UILabel *timeLable = [[UILabel alloc]initWithFrame:CGRectMake(40, 10, timesize.width, timesize.height)];
    timeLable.textColor = [UIColor lightGrayColor];
    timeLable.text =time;
    timeLable.font  = [UIFont systemFontOfSize:12];
    
    [returnView addSubview:timeLable];

    //添加文本信息
    UILabel *bubbleText = [[UILabel alloc] initWithFrame:CGRectMake(20, timesize.height+15, size.width+10, size.height+10)];
    bubbleText.backgroundColor = [UIColor clearColor];
    bubbleText.font = font;
    bubbleText.numberOfLines = 0;
    bubbleText.lineBreakMode = NSLineBreakByWordWrapping;
    
 
    
    bubbleText.text = text;
    bubbleText.textColor = [UIColor whiteColor];
    bubbleImageView.frame = CGRectMake(0,timesize.height+10, bubbleText.frame.size.width+20.0f, bubbleText.frame.size.height+10.0f);

    returnView.frame = CGRectMake(70, 0 , bubbleText.frame.size.width+10.0f,timesize.height +10 + bubbleText.frame.size.height+10.0f);
    
    [returnView addSubview:bubbleImageView];
    [returnView addSubview:bubbleText];
//    returnView.backgroundColor = [UIColor redColor];
    return returnView;
}

#pragma UITableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSDictionary *content = [_resultArray objectAtIndex:indexPath.row];
        NSString *content = dataArr [indexPath.row].content;

    UIFont *font = [UIFont systemFontOfSize:14];
    CGSize size = [content sizeWithFont:font constrainedToSize:CGSizeMake(SCREEN_WIDTH-100, 20000.0f) lineBreakMode:NSLineBreakByWordWrapping];

    if ( 25 +size.height+10.0f < 60) {
        return 60   ;
    }
    return 25 +size.height+10.0f +10 ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }else{
        for (UIView *cellView in cell.subviews){
            [cellView removeFromSuperview];
        }
    }
    cell.backgroundColor = [UIColor clearColor];
//    NSDictionary *dict = [_resultArray objectAtIndex:indexPath.row];

    //创建头像
    UIImageView *photo ;
        photo = [[UIImageView alloc]initWithFrame:CGRectMake(10, 20, 50, 50)];
        [cell addSubview:photo];
        photo.image = [UIImage imageNamed:@"矢量智能对象"];
        photo.layer.cornerRadius = 25;
        photo.clipsToBounds =YES;
    NSString *bir = [self formateDateNum:[dataArr[indexPath.row].create_time integerValue]  withFormateStr:@"yyyy-MM-dd HH:mm:ss"];

    [cell addSubview:[self bubbleView:dataArr[indexPath.row].content time:bir   withPosition:65]];

//        [cell addSubview:[self bubbleView:dict.allValues[0] time:dict.allKeys[0]   withPosition:65]];
    
    return cell;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSString *)formateDateNum:(NSInteger) dateNum withFormateStr:(NSString *)formatstr
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:dateNum];
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:formatstr];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/chongqing"];
    [formater setTimeZone:timeZone];
    NSString *dateStr = [formater stringFromDate:date];
    
    
    return dateStr;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
