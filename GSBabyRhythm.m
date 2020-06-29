//
//  GSBabyRhythm.m
//  GSNICE
//
//  Created by Gavin on 2020/6/12.
//  Copyright © 2020 GSNICE. All rights reserved.
//

#import "GSBabyRhythm.h"
#import "GSBabyDefine.h"

@implementation GSBabyRhythm {
    BOOL isOver;
    BBBeatsBreakBlock blockOnBeatBreak;
    BBBeatsOverBlock blockOnBeatOver;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        //beatsInterval
        _beatsInterval = KBABYRHYTHM_BEATS_DEFAULT_INTERVAL;
    }
    return  self;
}

- (void)beats {
    
    if (isOver) {
        BabyLog(@">>>beats isOver");
        return;
    }
    
    BabyLog(@">>>beats at :%@",[NSDate date]);
    if (self.beatsTimer) {
        [self.beatsTimer setFireDate: [[NSDate date]dateByAddingTimeInterval:self.beatsInterval]];
    }
    else {
       self.beatsTimer = [NSTimer timerWithTimeInterval:self.beatsInterval target:self selector:@selector(beatsBreak) userInfo:nil repeats:YES];
        [self.beatsTimer setFireDate: [[NSDate date]dateByAddingTimeInterval:self.beatsInterval]];
        [[NSRunLoop currentRunLoop] addTimer:self.beatsTimer forMode:NSRunLoopCommonModes];
    }
}

- (void)beatsBreak {
     BabyLog(@">>>beatsBreak :%@",[NSDate date]);
    [self.beatsTimer setFireDate:[NSDate distantFuture]];
    if (blockOnBeatBreak) {
        blockOnBeatBreak(self);
    }
}

- (void)beatsOver {
    BabyLog(@">>>beatsOver :%@",[NSDate date]);
    [self.beatsTimer setFireDate:[NSDate distantFuture]];
    isOver = YES;
    if (blockOnBeatOver) {
        blockOnBeatOver(self);
    }
    
}

- (void)beatsRestart {
    BabyLog(@">>>beatsRestart :%@",[NSDate date]);
    isOver = NO;
    [self beats];
}

- (void)setBlockOnBeatsBreak:(void(^)(GSBabyRhythm *bry))block {
    blockOnBeatBreak = block;
}

- (void)setBlockOnBeatsOver:(void(^)(GSBabyRhythm *bry))block {
    blockOnBeatOver = block;
}

@end