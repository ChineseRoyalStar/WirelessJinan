//
//  SpeechSynthesizer.m
//  AMapNaviKit
//
//  Created by 刘博 on 16/4/1.
//  Copyright © 2016年 AutoNavi. All rights reserved.
//

#import "SpeechSynthesizer.h"

@interface SpeechSynthesizer () <AVSpeechSynthesizerDelegate>

@property (nonatomic, strong, readwrite) AVSpeechSynthesizer *speechSynthesizer;

@end

@implementation SpeechSynthesizer

+ (instancetype)sharedSpeechSynthesizer
{
    static id sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[SpeechSynthesizer alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init
{
    if (self = [super init])
    {
        [self buildSpeechSynthesizer];
    }
    return self;
}

- (void)buildSpeechSynthesizer
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0)
    {
        return;
    }
    
    self.speechSynthesizer = [[AVSpeechSynthesizer alloc] init];
    [self.speechSynthesizer setDelegate:self];
}

- (void)speakString:(NSString *)string
{
    if (self.speechSynthesizer)
    {
        AVSpeechUtterance *aUtterance = [AVSpeechUtterance speechUtteranceWithString:string];
        [aUtterance setVoice:[AVSpeechSynthesisVoice voiceWithLanguage:@"zh-CN"]];
        
        if ([self.speechSynthesizer isSpeaking])
        {
            [self.speechSynthesizer stopSpeakingAtBoundary:AVSpeechBoundaryWord];
        }
        
        [self.speechSynthesizer speakUtterance:aUtterance];
    }
}

- (void)stopSpeak
{
    if (self.speechSynthesizer)
    {
        [self.speechSynthesizer stopSpeakingAtBoundary:AVSpeechBoundaryImmediate];
    }
}


@end
