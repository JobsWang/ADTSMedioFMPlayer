//
//  ViewController.m
//  FMPlayerDemo
//
//  Created by FENGWANG on 15/8/11.
//  Copyright (c) 2015年 XIANFENGWANG. All rights reserved.
//

#import "ViewController.h"
#import "SOFMAudioPalyer.h"
@interface ViewController ()

@property (strong,nonatomic) NSMutableDictionary *fmDict;
@property (nonatomic,assign) int playIndex;
@property (nonatomic,strong) SOFMAudioPalyer *fmPlayer;

@property (weak, nonatomic) IBOutlet UILabel *fmNameLable;
@property (weak, nonatomic) IBOutlet UILabel *fmURLLable;
@property (weak, nonatomic) IBOutlet UILabel *fmStateLable;
- (IBAction)playButtonClick:(id)sender;
- (IBAction)stopButtonClick:(id)sender;
- (IBAction)nextFmButtonClick:(id)sender;
- (IBAction)upFmButtonClick:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    /*
     中国国际广播电台环球资讯广播 mms://media.crinewsradio.cn/crinewsradio
     2CCC Coast 96.3 FM	mms://wma1.viastreaming.net/stream963
     2GOS Star 104.5	http://117.53.175.113:15016
     */
    _fmDict = [NSMutableDictionary dictionary];
    [_fmDict setObject:@"中国国际广播电台环球资讯广播" forKey:@"mms://media.crinewsradio.cn/crinewsradio"];
    [_fmDict setObject:@"2CCC Coast 96.3 FM" forKey:@"mms://wma1.viastreaming.net/stream963"];
    [_fmDict setObject:@"2GOS Star 104.5" forKey:@"http://117.53.175.113:15016"];
    

    _fmNameLable.text = [NSString stringWithFormat:@"电台名称:%@",_fmDict[@"mms://media.crinewsradio.cn/crinewsradio"]];
    _fmURLLable.text = [NSString stringWithFormat:@"电台URL:mms://media.crinewsradio.cn/crinewsradio"];
    _fmStateLable.text =[NSString stringWithFormat:@"播放State:%@", @"没有播放"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark--
#pragma mark-- xibs 功能方法
- (IBAction)playButtonClick:(id)sender {
    if (!_fmPlayer) {
        _fmPlayer = [[SOFMAudioPalyer alloc] init];
        
    }
    NSArray *dicts = [_fmDict allKeys];
    NSString *fmURL = nil;
    NSString *fmName = nil;
    if (dicts.count>0) {
        fmName = dicts[_playIndex];
        fmURL = _fmDict[fmName];
        _fmNameLable.text = fmName;
        _fmURLLable.text = fmURL;
    }
    
    [_fmPlayer playFFmpegAudioStreamURL:fmURL withTransFerWay:kTCP comeBackErrorBlock:^(NSString *error) {
        if (error) {
            NSLog(@"播放失败！");
        }
    }];
}

- (IBAction)stopButtonClick:(id)sender {
    [_fmPlayer stopPlayAudio];
}

- (IBAction)nextFmButtonClick:(id)sender {
    _playIndex++;
    if (_playIndex>=_fmDict.count) {
        _playIndex = 0;
    }
    [self playButtonClick:nil];
}

- (IBAction)upFmButtonClick:(id)sender {
    _playIndex--;
    if (_playIndex<0) {
        _playIndex = (int)_fmDict.count-1;
    }
    [self playButtonClick:nil];
}
@end
