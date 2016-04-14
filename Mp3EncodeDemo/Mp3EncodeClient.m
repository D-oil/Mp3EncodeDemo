//
//  Mp3EncodeClient.m
//  Mp3EncodeDemo
//
//  Created by hejinlai on 13-6-24.
//  Copyright (c) 2013年 yunzhisheng. All rights reserved.
//

#import "Mp3EncodeClient.h"

@implementation Mp3EncodeClient

- (id)init
{
    self = [super init];
    if (self) {
        
        recordingQueue = [[NSMutableArray alloc] init];
        opetaionQueue = [[NSOperationQueue alloc] init];
        
        recorder = [[Recorder alloc] init];
        recorder.recordQueue = recordingQueue;
        
    }
    return self;
}


- (void)start
{
    [recordingQueue removeAllObjects];
    
    [recorder startRecording];
    
    if (mp3EncodeOperation) {
        [mp3EncodeOperation release];
        mp3EncodeOperation = nil;
    }
    
    mp3EncodeOperation = [[Mp3EncodeOperation alloc] init];
    mp3EncodeOperation.recordQueue = recordingQueue;
    [opetaionQueue addOperation:mp3EncodeOperation];
}

- (void)stop
{
    [recorder stopRecording];
    mp3EncodeOperation.setToStopped = YES;
}



- (void)dealloc
{
    [super dealloc];
    [recorder release];
    [mp3EncodeOperation release];
    [recordingQueue release];
    [opetaionQueue release];
}


@end
