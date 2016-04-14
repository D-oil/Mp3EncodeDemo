//
//  Recorder.h
//  PocketSphinxDemo
//
//  Created by hejinlai on 13-5-28.
//  Copyright (c) 2013年 yunzhisheng. All rights reserved.
//
#import <AudioToolbox/AudioToolbox.h>
#import <Foundation/Foundation.h>

#define kNumberAudioQueueBuffers 3
#define kBufferDurationSeconds 0.1f


@interface Recorder : NSObject
{
    AudioQueueRef				_audioQueue;
    AudioQueueBufferRef			_audioBuffers[kNumberAudioQueueBuffers];
    AudioStreamBasicDescription	_recordFormat;
    
}

@property (nonatomic, assign) BOOL isRecording;
@property (nonatomic, assign) NSMutableArray *recordQueue;


- (void) startRecording;
- (void) stopRecording;


@end
