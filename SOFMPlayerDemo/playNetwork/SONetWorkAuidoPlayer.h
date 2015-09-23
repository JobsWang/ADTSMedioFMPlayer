//
//  SONetWorkAuidoPlayer.h
//  FMPlayerDemo
//
//  Created by FENGWANG on 15/9/6.
//  Copyright (c) 2015年 XIANFENGWANG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AudioStreamer.h"
@interface SONetWorkAuidoPlayer : NSObject
@property (nonatomic,strong) AudioStreamer *streamer;


-(void)playForNetWorkURL:(NSString*)URL;

-(void)stopPlayForNewWork;

- (void)createStreamerWithURL:(NSString*)playURL;

- (void)destroyStreamer;
@end
