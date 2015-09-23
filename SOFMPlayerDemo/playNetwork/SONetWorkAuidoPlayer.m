//
//  SONetWorkAuidoPlayer.m
//  FMPlayerDemo
//
//  Created by FENGWANG on 15/9/6.
//  Copyright (c) 2015年 XIANFENGWANG. All rights reserved.
//

#import "SONetWorkAuidoPlayer.h"

@implementation SONetWorkAuidoPlayer
-(void)playForNetWorkURL:(NSString*)URL
{
        if (!_streamer) {
            [self createStreamerWithURL:URL];
        }
        [_streamer start];
   
}
-(void)stopPlayForNewWork{
    [_streamer pause];
}

- (void)createStreamerWithURL:(NSString*)playURL
{
    [self destroyStreamer];
    
    NSString *escapedValue =
    ( NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
                                                                           nil,
                                                                           (CFStringRef)playURL,
                                                                           NULL,
                                                                           NULL,
                                                                           kCFStringEncodingUTF8)) ;
    ;
    NSURL *url = [NSURL URLWithString:escapedValue];
    _streamer = [[AudioStreamer alloc] initWithURL:url];
    
    
}

- (void)destroyStreamer
{
    if (_streamer)
    {
        [[NSNotificationCenter defaultCenter]
         removeObserver:self
         name:ASStatusChangedNotification
         object:_streamer];
        
        [_streamer stop];
        _streamer = nil;
    }
}

@end
