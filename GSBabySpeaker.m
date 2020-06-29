//
//  GSBabySpeaker.m
//  GSNICE
//
//  Created by Gavin on 2020/6/12.
//  Copyright © 2020 GSNICE. All rights reserved.
//

#import "GSBabySpeaker.h"
#import "GSBabyDefine.h"

typedef NS_ENUM(NSUInteger, BabySpeakerType) {
    BabySpeakerTypeDiscoverPeripherals,
    BabySpeakerTypeConnectedPeripheral,
    BabySpeakerTypeDiscoverPeripheralsFailToConnect,
    BabySpeakerTypeDiscoverPeripheralsDisconnect,
    BabySpeakerTypeDiscoverPeripheralsDiscoverServices,
    BabySpeakerTypeDiscoverPeripheralsDiscoverCharacteristics,
    BabySpeakerTypeDiscoverPeripheralsReadValueForCharacteristic,
    BabySpeakerTypeDiscoverPeripheralsDiscoverDescriptorsForCharacteristic,
    BabySpeakerTypeDiscoverPeripheralsReadValueForDescriptorsBlock
};

@implementation GSBabySpeaker {
    //  所有委托频道
    NSMutableDictionary *channels;
    //  当前委托频道
    NSString *currChannel;
    //  notifyList
    NSMutableDictionary *notifyList;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        GSBabyCallback *defaultCallback = [[GSBabyCallback alloc]init];
        notifyList = [[NSMutableDictionary alloc]init];
        channels = [[NSMutableDictionary alloc]init];
        currChannel = KBABY_DETAULT_CHANNEL;
        [channels setObject:defaultCallback forKey:KBABY_DETAULT_CHANNEL];
    }
    return self;
}

- (GSBabyCallback *)callback {
    return [channels objectForKey:KBABY_DETAULT_CHANNEL];
}

- (GSBabyCallback *)callbackOnCurrChannel {
    return [self callbackOnChnnel:currChannel];
}

- (GSBabyCallback *)callbackOnChnnel:(NSString *)channel {
    if (!channel) {
        [self callback];
    }
    return [channels objectForKey:channel];
}

- (GSBabyCallback *)callbackOnChnnel:(NSString *)channel
               createWhenNotExist:(BOOL)createWhenNotExist {
    
    GSBabyCallback *callback = [channels objectForKey:channel];
    if (!callback && createWhenNotExist) {
        callback = [[GSBabyCallback alloc]init];
        [channels setObject:callback forKey:channel];
    }
    
    return callback;
}

- (void)switchChannel:(NSString *)channel {
    if (channel) {
        if ([self callbackOnChnnel:channel]) {
            currChannel = channel;
            BabyLog(@">>>已切换到%@",channel);
        }
        else {
            BabyLog(@">>>所要切换的channel不存在");
        }
    }
    else {
        currChannel = KBABY_DETAULT_CHANNEL;
            BabyLog(@">>>已切换到默认频道");
    }
}

//  添加到 notify list
- (void)addNotifyCallback:(CBCharacteristic *)c
           withBlock:(void(^)(CBPeripheral *peripheral, CBCharacteristic *characteristics, NSError *error))block {
    [notifyList setObject:block forKey:c.UUID.description];
}

//  添加到 notify list
- (void)removeNotifyCallback:(CBCharacteristic *)c {
    [notifyList removeObjectForKey:c.UUID.description];
}

//  获取 notify list
- (NSMutableDictionary *)notifyCallBackList {
    return notifyList;
}

//  获取 notityBlock
- (void(^)(CBPeripheral *peripheral, CBCharacteristic *characteristics, NSError *error))notifyCallback:(CBCharacteristic *)c {
    return [notifyList objectForKey:c.UUID.description];
}
@end
