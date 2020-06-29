//
//  GSBabyRhythm.h
//  GSNICE
//
//  Created by Gavin on 2020/6/12.
//  Copyright © 2020 GSNICE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GSBabyDefine.h"

@interface GSBabyRhythm : NSObject

typedef void (^BBBeatsBreakBlock)(GSBabyRhythm *bry);
typedef void (^BBBeatsOverBlock)(GSBabyRhythm *bry);

//  timer for beats
@property (nonatomic, strong) NSTimer *beatsTimer;

//  beat interval
@property NSInteger beatsInterval;

#pragma mark beats
//  心跳
- (void)beats;
//  主动中断心跳
- (void)beatsBreak;
//  结束心跳，结束后会进入 BlockOnBeatOver，并且结束后再不会在触发 BlockOnBeatBreak
- (void)beatsOver;
//  恢复心跳，beatsOver 操作后可以使用 beatsRestart 恢复心跳，恢复后又可以进入 BlockOnBeatBreak 方法
- (void)beatsRestart;

//  心跳中断的委托
- (void)setBlockOnBeatsBreak:(void(^)(GSBabyRhythm *bry))block;
//  心跳结束的委托
- (void)setBlockOnBeatsOver:(void(^)(GSBabyRhythm *bry))block;

@end
