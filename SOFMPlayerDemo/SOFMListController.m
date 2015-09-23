//
//  SOFMListController.m
//  FMPlayerDemo
//
//  Created by FENGWANG on 15/8/14.
//  Copyright (c) 2015年 XIANFENGWANG. All rights reserved.
//

#import "SOFMListController.h"
#import "SOFMAudioPalyer.h"
#import "SONetWorkAuidoPlayer.h"
@interface SOFMListController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *navTitleLable;
@property (weak, nonatomic) IBOutlet UITableView *fmListTableView;

@property(nonatomic,strong) NSArray *fmListArray;
@property(nonatomic,strong) NSArray *fmsectionArray;

@property (strong,nonatomic) NSDictionary *curFmDict;
@property (nonatomic,assign) int playIndex;
@property (nonatomic,strong) SOFMAudioPalyer *fmPlayer;

@property (nonatomic,strong) NSThread *playFmThread;

@end

@implementation SOFMListController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"hinet_radio_json" ofType:@"json"];
    NSString *jsonStr = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    
    NSData *JSONData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableContainers error:nil];
    
    NSMutableArray *fmlistArray = [NSMutableArray array];
    NSMutableArray *fmsectionArray = [NSMutableArray array];
    
    NSDictionary *twFmsdict = responseJSON[@"url_list_tw"];
    NSDictionary*testFmsDict = responseJSON[@"url_list_test"];
    NSDictionary*monacoFmsDict = responseJSON[@"url_list_monaco"];
    NSDictionary*amricFmsDict = responseJSON[@"url_list_Amaric"];


    if ([twFmsdict isKindOfClass:[NSDictionary class]]) {
        [fmlistArray addObject:twFmsdict[@"data"]];
        [fmsectionArray addObject:twFmsdict[@"fmTitle"]];
    }
    if ([testFmsDict isKindOfClass:[NSDictionary class]]) {
        [fmlistArray addObject:testFmsDict[@"data"]];
        [fmsectionArray addObject:testFmsDict[@"fmTitle"]];
    }
    if ([monacoFmsDict isKindOfClass:[NSDictionary class]]) {
        [fmlistArray addObject:monacoFmsDict[@"data"]];
        [fmsectionArray addObject:monacoFmsDict[@"fmTitle"]];
    }
    if ([amricFmsDict isKindOfClass:[NSDictionary class]]) {
        [fmlistArray addObject:amricFmsDict[@"data"]];
        [fmsectionArray addObject:amricFmsDict[@"fmTitle"]];
    }
    self.fmListArray = fmlistArray;
    self.fmsectionArray = fmsectionArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark--
#pragma mark-- UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
     return _fmListArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *fmArray =  _fmListArray[section];
    return fmArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    NSDictionary *fmdict =  _fmListArray[indexPath.section][indexPath.row];
    cell.textLabel.text = fmdict[@"title"];
    cell.detailTextLabel.text = fmdict[@"url"];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44.0;
}
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return self.fmsectionArray[section];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *fmdict =  _fmListArray[indexPath.section][indexPath.row];
    /*
    SONetWorkAuidoPlayer *mp3 = [[SONetWorkAuidoPlayer alloc] init];
    NSString *fmURL = nil;
    if (fmdict.count>0) {
        fmURL = fmdict[@"url"];
    }
    [mp3 playForNetWorkURL:fmURL];
    return;*/

    
    if (_playFmThread) {
            [_playFmThread cancel];
            _playFmThread = nil;
    }
    _playFmThread = [[NSThread alloc] initWithTarget:self selector:@selector(playingStart:) object:fmdict];
    [_playFmThread start];
}

-(void)playingStart:(id )thread{
    @autoreleasepool {
        NSDictionary *fmdict = thread;
        NSString *fmURL = nil;
        if (fmdict.count>0) {
            fmURL =  fmdict[@"url"];
        }
        self.curFmDict = fmdict;
        [self playerFm:fmURL];
    }
}

-(void)playerFm:(NSString*)fmURL{
 
    if ( _fmPlayer.playState == eAudioTransiting) {
        NSLog(@"不能频繁点击");
        return;
    }
    if (_fmPlayer.playState == eAudioPlaying) {
        NSLog(@">>>> Stop");
        [_fmPlayer stopPlayAudio];
        _fmPlayer = nil;
    }
    
    NSLog(@">>>> Playing");
    if (!_fmPlayer) {
        _fmPlayer = [[SOFMAudioPalyer alloc] init];
    }
  
    [_fmPlayer playFFmpegAudioStreamURL:fmURL withTransFerWay:kTCP comeBackErrorBlock:^(NSString *error) {
        if (error) {
            NSLog(@"播放失败！");
            [_fmPlayer stopPlayAudio];
        } else {
            NSLog(@"播放OK");
        }
    }];

}
@end
