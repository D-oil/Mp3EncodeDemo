//
//  ViewController.h
//  Mp3EncodeDemo
//
//  Created by hejinlai on 13-6-24.
//  Copyright (c) 2013年 yunzhisheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Mp3EncodeClient.h"

@interface ViewController : UIViewController
{
    UIButton *sayBeginBtn;
    UIButton *sayEndBtn;
    
    Mp3EncodeClient *mp3EncodeClient;
}


@end
