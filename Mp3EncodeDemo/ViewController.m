//
//  ViewController.m
//  Mp3EncodeDemo
//
//  Created by hejinlai on 13-6-24.
//  Copyright (c) 2013年 yunzhisheng. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    
    sayBeginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sayBeginBtn.backgroundColor = [UIColor redColor];
    [sayBeginBtn setTitle:@"开始说话" forState:UIControlStateNormal];
    sayBeginBtn.frame = CGRectMake(10, screenRect.size.height-80, 300, 50);
    [sayBeginBtn addTarget:self action:@selector(buttonSayBegin:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sayBeginBtn];
    
    sayEndBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sayEndBtn.backgroundColor = [UIColor greenColor];
    [sayEndBtn setTitle:@"说完了" forState:UIControlStateNormal];
    sayEndBtn.frame = CGRectMake(10, screenRect.size.height-80, 300, 50);
    [sayEndBtn addTarget:self action:@selector(buttonSayEnd:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sayEndBtn];
    sayEndBtn.hidden = YES;

    mp3EncodeClient = [[Mp3EncodeClient alloc] init];
    
}


- (void)buttonSayBegin:(id)sender
{
    sayBeginBtn.hidden = YES;
    sayEndBtn.hidden = NO;
    
    [mp3EncodeClient start];
}

- (void)buttonSayEnd:(id)sender
{
    sayBeginBtn.hidden = NO;
    sayEndBtn.hidden = YES;
    
    [mp3EncodeClient stop];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [super dealloc];
    [mp3EncodeClient release];
}

@end
