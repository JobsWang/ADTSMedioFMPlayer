//
//  SOFMPacketQueue.h
//  FMPlayerDemo
//
//  Created by FENGWANG on 15/8/11.
//  Copyright (c) 2015年 XIANFENGWANG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "avformat.h"
@interface SOFMPacketQueue : NSObject

@property (nonatomic,assign)  int count;

- (id)  initWithQueue;
- (void)destroyQueue;
- (int) putAVPacket:(AVPacket *)packet;
- (int) getAVPacket:(AVPacket *)packet;
- (void)freeAVPacket:(AVPacket *)packet;

@end
