//
//  SOFMMPEGUtilities.h
//  MMSwithFFmpeg
//
//  Created by xianfeng on 13/8/18.
//  Copyright (c) 2015年 xianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>
#include "avformat.h"
#include "opt.h"
#include "swresample.h"

@class SOFMPacketQueue;

typedef struct AACADTSHeaderInfo {
    // ADTS fixed header
    uint16_t syncword;                  // 12 bslbf
    uint8_t  ID;                        // 1 bslbf
    uint8_t  layer;                     // 2 uimsbf
    uint8_t  protection_absent;         // 1 bslbf
    uint8_t  profile;                   // 2 uimsbf
    uint8_t  sampling_frequency_index;  // 4 uimsbf
    uint8_t  private_bit;               // 1 bslbf
    uint8_t  channel_configuration;     // 3 uimsbf
    uint8_t  original_copy;             // 1 bslbf
    uint8_t  home;                      // 1 bslbf
    
    // ADTS variable header
    uint8_t copyright_identification_bit;       // 1 bslbf
    uint8_t copyright_identification_start;     // 1 bslbf
    uint16_t frame_length;                      // 13 bslbf
    uint16_t adts_buffer_fullness;              // 11 bslbf
    uint8_t number_of_raw_data_blocks_in_frame; // 2 uimsfb
    
} tAACADTSHeaderInfo;

@interface SOFMMPEGUtilities : NSObject

+ (BOOL)parseAACADTSHeader:(uint8_t *)input toHeader:(tAACADTSHeaderInfo *)ADTSHeader;
+ (int)getMPEG4AudioSampleRates:(uint8_t)vSamplingIndex;
+ (id)initForDecodeAudioFile:(NSString *)filePathIn toPCMFile:(NSString *)filePathOutput;
+ (void)printFileStreamBasicDescription: (AudioStreamBasicDescription *)dataFormat;
+ (void)printFileStreamBasicDescriptionFromFile:(NSString *)filePath;
+ (void)writeWAVHeaderWithCodecCtx:(AVCodecContext *)pAudioCodecCtx withFormatCtx:(AVFormatContext *)pFormatCtx toFile:(FILE *)wavFile;

@end
