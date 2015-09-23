//
//  SOFMAudioPalyer.h
//  FMPlayerDemo
//
//  Created by FENGWANG on 15/8/11.
//  Copyright (c) 2015年 XIANFENGWANG. All rights reserved.
//
typedef enum {
    kTCP = 0,
    kUDP
}kNetworkWay;

typedef enum {
    eAudioTransiting   = 1,
    eAudioStop      = 2,
    eAudioPlaying   = 3
}eAudioType;

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import "avcodec.h"
#import "avformat.h"
#import "swresample.h"
#import "SOFMPacketQueue.h"
#import "SOFMMPEGUtilities.h"

static NSString *noticeExitThread = @"EXIT_THREAD_For_New_Thread";
@interface SOFMAudioPalyer : NSObject
{
    AVFormatContext *pFormatCtx;
    AVCodecContext *pAudioCodeCtx;
    int    audioStream;
    BOOL isLocalFile;
    BOOL  isStop;
}
//defalut is KTCP
@property (nonatomic,assign) kNetworkWay networkWay;
@property (nonatomic,assign) eAudioType  playState;


-(void)playFFmpegAudioStreamURL:(NSString*)mmsURL withTransFerWay:(kNetworkWay)networkWay comeBackErrorBlock:(void(^)(NSString *error)) errorBlcok;

- (void)stopPlayAudio;
- (void) setVolume:(float)vVolume;

@end
