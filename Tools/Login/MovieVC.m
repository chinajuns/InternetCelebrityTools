//
//  MovieVC.m
//  网红评估工具
//
//  Created by More on 16/11/16.
//  Copyright © 2016年 More. All rights reserved.
//

#import "MovieVC.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
@interface MovieVC ()
@property(nonatomic ,strong)AVAudioSession *avaudioSession;

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property(nonatomic,strong)MPMoviePlayerController *moviePlayer;
@end

@implementation MovieVC
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _loginBtn.layer.cornerRadius=8;
    _loginBtn.clipsToBounds = YES;
    _loginBtn.layer.borderColor = [UIColor colorWithHexString:@"F56A6B"].CGColor;
    _loginBtn.layer.borderWidth=1;
    [self PlayVideo];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)PlayVideo{
    /**
     *  设置其他音乐软件播放的音乐不被打断
     */
    
    self.avaudioSession = [AVAudioSession sharedInstance];
    NSError *error = nil;
    [self.avaudioSession setCategory:AVAudioSessionCategoryAmbient error:&error];
    
    
    
    NSString *urlStr = [[NSBundle mainBundle]pathForResource:@"序列 01.mp4" ofType:nil];
    
    NSURL *url = [NSURL fileURLWithPath:urlStr];
    
    _moviePlayer = [[MPMoviePlayerController alloc]initWithContentURL:url];
    [_moviePlayer setScalingMode:MPMovieScalingModeAspectFill];
    [_moviePlayer setControlStyle:MPMovieControlStyleFullscreen];
    //    _moviePlayer.controlStyle = MPMovieControlStyleDefault;
    [_moviePlayer play];
    [_moviePlayer.view setFrame:self.view.bounds];
    
    [self.view insertSubview:_moviePlayer.view atIndex:0 ];
    _moviePlayer.shouldAutoplay = YES;
    [_moviePlayer setControlStyle:MPMovieControlStyleNone];
    [_moviePlayer setFullscreen:YES];
    
    [_moviePlayer setRepeatMode:MPMovieRepeatModeOne];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playbackStateChanged)
                                                 name:MPMoviePlayerPlaybackStateDidChangeNotification
                                               object:_moviePlayer];
    
}

-(void)playbackStateChanged{
    
    
    //取得目前状态
    MPMoviePlaybackState playbackState = [_moviePlayer playbackState];
    
    //状态类型
    switch (playbackState) {
        case MPMoviePlaybackStateStopped:
            [_moviePlayer play];
            break;
            
        case MPMoviePlaybackStatePlaying:
            //            NSLog(@"播放中");
            break;
            
        case MPMoviePlaybackStatePaused:
            [_moviePlayer play];
            break;
            
        case MPMoviePlaybackStateInterrupted:
            //            NSLog(@"播放被中断");
            break;
            
        case MPMoviePlaybackStateSeekingForward:
            //            NSLog(@"往前快转");
            break;
            
        case MPMoviePlaybackStateSeekingBackward:
            //            NSLog(@"往后快转");
            break;
            
        default:
            //            NSLog(@"无法辨识的状态");
            break;
    }
}
- (IBAction)gotologin:(id)sender {
    [MobClick event:@"enterLogin"];
    [self performSegueWithIdentifier:@"gotoLoginNow" sender:self];

//    [self performSegueWithIdentifier:@"gotoLoginNow" sender:self];
}
-(void)viewWillDisappear:(BOOL)animated{
//    [_moviePlayer stop];
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
