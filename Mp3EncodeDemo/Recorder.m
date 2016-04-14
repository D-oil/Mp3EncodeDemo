//
//  Recorder.m
//  PocketSphinxDemo
//
//  Created by hejinlai on 13-5-28.
//  Copyright (c) 2013年 yunzhisheng. All rights reserved.
//

#import "Recorder.h"


static const int bufferByteSize = 1600;
static const int sampeleRate = 16000;
static const int bitsPerChannel = 16;


@implementation Recorder

@synthesize isRecording = _isRecording;
//@synthesize recordingData = _recordingData;
@synthesize recordQueue = _recordQueue;

- (id)init
{
    self = [super init];
    if (self) {
                        
        AudioSessionInitialize(NULL, NULL, NULL, self);
    }
    return self;
}


// 设置录音格式
- (void) setupAudioFormat:(UInt32) inFormatID SampleRate:(int) sampeleRate
{
    memset(&_recordFormat, 0, sizeof(_recordFormat));
    _recordFormat.mSampleRate = sampeleRate;
    
	UInt32 size = sizeof(_recordFormat.mChannelsPerFrame);
    AudioSessionGetProperty(kAudioSessionProperty_CurrentHardwareInputNumberChannels, &size, &_recordFormat.mChannelsPerFrame);
	_recordFormat.mFormatID = inFormatID;
	if (inFormatID == kAudioFormatLinearPCM){
		// if we want pcm, default to signed 16-bit little-endian
		_recordFormat.mFormatFlags = kLinearPCMFormatFlagIsSignedInteger | kLinearPCMFormatFlagIsPacked;
		_recordFormat.mBitsPerChannel = bitsPerChannel;
		_recordFormat.mBytesPerPacket = _recordFormat.mBytesPerFrame = (_recordFormat.mBitsPerChannel / 8) * _recordFormat.mChannelsPerFrame;
		_recordFormat.mFramesPerPacket = 1;
	}
}

// 回调函数
void inputBufferHandler(void *inUserData, AudioQueueRef inAQ, AudioQueueBufferRef inBuffer, const AudioTimeStamp *inStartTime,
                        UInt32 inNumPackets, const AudioStreamPacketDescription *inPacketDesc)
{
    Recorder *recorder = (Recorder *)inUserData;
    if (inNumPackets > 0 && recorder.isRecording){
        
        int pcmSize = inBuffer->mAudioDataByteSize;
        char *pcmData = (char *)inBuffer->mAudioData;
        NSData *data = [[NSData alloc] initWithBytes:pcmData length:pcmSize];
        [recorder.recordQueue addObject:data];
        [data release];
        
        AudioQueueEnqueueBuffer(inAQ, inBuffer, 0, NULL);
    }
}

// 开始录音
- (void) startRecording
{
    AudioSessionSetActive(true);
    
    // category
    UInt32 category = kAudioSessionCategory_PlayAndRecord;
    AudioSessionSetProperty(kAudioSessionProperty_AudioCategory, sizeof(category), &category);
        
    // format
    [self setupAudioFormat:kAudioFormatLinearPCM SampleRate:sampeleRate];
    
    // 设置回调函数
    AudioQueueNewInput(&_recordFormat, inputBufferHandler, self, NULL, NULL, 0, &_audioQueue);
    
    
    // 创建缓冲器
    for (int i = 0; i < kNumberAudioQueueBuffers; ++i){
        AudioQueueAllocateBuffer(_audioQueue, bufferByteSize, &_audioBuffers[i]);
        AudioQueueEnqueueBuffer(_audioQueue, _audioBuffers[i], 0, NULL);
    }
    
    // 开始录音
    AudioQueueStart(_audioQueue, NULL);
    _isRecording = YES;
   
}

// 停止录音
- (void) stopRecording
{
    if (_isRecording) {
        
        _isRecording = NO;
        AudioQueueStop(_audioQueue, true);
        AudioQueueDispose(_audioQueue, true);
    }
}


- (void)dealloc
{
    [super dealloc];
}

@end
