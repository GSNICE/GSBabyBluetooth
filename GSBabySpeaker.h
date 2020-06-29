//
//  GSBabySpeaker.h
//  GSNICE
//
//  Created by Gavin on 2020/6/12.
//  Copyright © 2020 GSNICE. All rights reserved.
//

#import "GSBabyCallback.h"
#import <CoreBluetooth/CoreBluetooth.h>


@interface GSBabySpeaker : NSObject

- (GSBabyCallback *)callback;
- (GSBabyCallback *)callbackOnCurrChannel;
- (GSBabyCallback *)callbackOnChnnel:(NSString *)channel;
- (GSBabyCallback *)callbackOnChnnel:(NSString *)channel
               createWhenNotExist:(BOOL)createWhenNotExist;

//  切换频道
- (void)switchChannel:(NSString *)channel;

//  添加到 notify list
- (void)addNotifyCallback:(CBCharacteristic *)c
           withBlock:(void(^)(CBPeripheral *peripheral, CBCharacteristic *characteristics, NSError *error))block;

//  添加到 notify list
- (void)removeNotifyCallback:(CBCharacteristic *)c;

//  获取 notify list
- (NSMutableDictionary *)notifyCallBackList;

//  获取 notityBlock
- (void(^)(CBPeripheral *peripheral, CBCharacteristic *characteristics, NSError *error))notifyCallback:(CBCharacteristic *)c;

@end
