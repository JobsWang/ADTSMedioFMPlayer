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
    eAudioRunning   = 1,
    eAudioStop      = 2
}eAudioType;

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import "avcodec.h"
#import "avformat.h"
#import "swresample.h"
#import "SOFMPacketQueue.h"
@interface SOFMAudioPalyer : NSObject
{
    AVCodecContext *pAudioCodeCtx;
}
//defalut is KTCP
@property (nonatomic,assign) kNetworkWay networkWay;

-(void)playFFmpegAudioStreamURL:(NSString*)mmsURL withTransFerWay:(kNetworkWay)networkWay comeBackErrorBlock:(void(^)(NSString *error)) errorBlcok;

- (void)stopPlayAudio;
@end
