//
//  SOFMPacketQueue.m
//  FMPlayerDemo
//
//  Created by FENGWANG on 15/8/11.
//  Copyright (c) 2015年 XIANFENGWANG. All rights reserved.
//

#import "SOFMPacketQueue.h"
@interface SOFMPacketQueue()
{
    NSMutableArray *queues;
    NSLock *pLock;
}
@end

@implementation SOFMPacketQueue
- (id)initWithQueue
{
    self = [super self];
    if (self) {
        queues = [[NSMutableArray alloc] init];
        pLock = [[NSLock alloc] init];
        _count = 0;
    }
    return self;
}

- (void)dealloc
{
    [self destroyQueue];
}

- (void)destroyQueue
{
    AVPacket vxPacket;
    NSMutableData *packetData = nil;
    [pLock lock];
    // Release all packet in the array
    while ([queues count] > 0) {
        packetData = [queues objectAtIndex:0];
        if (packetData != nil) {
            [packetData getBytes:&vxPacket length:sizeof(AVPacket)];
            av_free_packet(&vxPacket);
            packetData = nil;
            [queues removeObjectAtIndex:0];
            _count--;
        }
    }
    _count = 0;
    [pLock unlock];
    if (queues) {
        queues = nil;
    }
}

// Put packet
- (int)putAVPacket:(AVPacket *)packet
{
    // Protect if memory leakage
    if (av_dup_packet(packet) < 0) {
        NSLog(@"Error occurs when duplicating packet");
    }
    [pLock lock];
    NSMutableData *tmpData = [[NSMutableData alloc] initWithBytes:packet length:sizeof(*packet)];
    [queues addObject:tmpData];
    // Release packet
    tmpData = nil;
    _count++;
    [pLock unlock];
    return 1;
}

- (int)getAVPacket:(AVPacket *)packet
{
    NSMutableData *packetData = nil;
    
    [pLock lock];
    if ([queues count] > 0) {
        packetData = [queues objectAtIndex:0];
        if (packetData != nil) {
            //[packetData getBytes:packet];
            [packetData getBytes:packet length:sizeof(AVPacket)];
            packetData = nil;
            //
            [queues removeObjectAtIndex:0];
            _count--;
        }
        [pLock unlock];
        return 1;
    }
    
    [pLock unlock];
    return 0;
}

- (void)freeAVPacket:(AVPacket *)packet
{
    [pLock lock];
    av_free_packet(packet);
    [pLock unlock];
}

@end

