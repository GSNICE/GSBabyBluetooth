//
//  GSBabyBluetooth.m
//  GSNICE
//
//  Created by Gavin on 2020/6/12.
//  Copyright © 2020 GSNICE. All rights reserved.
//

#import "GSBabyBluetooth.h"

@implementation GSBabyBluetooth{
    GSBabyCentralManager *babyCentralManager;
    GSBabyPeripheralManager *babyPeripheralManager;
    GSBabySpeaker *babySpeaker;
    int CENTRAL_MANAGER_INIT_WAIT_TIMES;
    NSTimer *timerForStop;
}
//  单例模式
+ (instancetype)shareBabyBluetooth {
    static GSBabyBluetooth *share = nil;
    static dispatch_once_t oneToken;
    dispatch_once(&oneToken, ^{
        share = [[GSBabyBluetooth alloc]init];
    });
   return share;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        //初始化对象
        babyCentralManager = [[GSBabyCentralManager alloc] init];
        babySpeaker = [[GSBabySpeaker alloc] init];
        babyCentralManager->babySpeaker = babySpeaker;
        
        babyPeripheralManager = [[GSBabyPeripheralManager alloc] init];
        babyPeripheralManager->babySpeaker = babySpeaker;
    }
    return self;
}

#pragma mark - babybluetooth的委托
/*
 默认频道的委托
 */
//  设备状态改变的委托
- (void)setBlockOnCentralManagerDidUpdateState:(void (^)(CBCentralManager *central))block {
    [[babySpeaker callback]setBlockOnCentralManagerDidUpdateState:block];
}
//  找到 Peripherals 的委托
- (void)setBlockOnDiscoverToPeripherals:(void (^)(CBCentralManager *central,CBPeripheral *peripheral,NSDictionary *advertisementData, NSNumber *RSSI))block{
    [[babySpeaker callback]setBlockOnDiscoverPeripherals:block];
}
//  连接 Peripherals 成功的委托
- (void)setBlockOnConnected:(void (^)(CBCentralManager *central,CBPeripheral *peripheral))block {
    [[babySpeaker callback]setBlockOnConnectedPeripheral:block];
}
//  连接 Peripherals 失败的委托
- (void)setBlockOnFailToConnect:(void (^)(CBCentralManager *central,CBPeripheral *peripheral,NSError *error))block {
    [[babySpeaker callback]setBlockOnFailToConnect:block];
}
//  断开 Peripherals 的连接
- (void)setBlockOnDisconnect:(void (^)(CBCentralManager *central,CBPeripheral *peripheral,NSError *error))block {
    [[babySpeaker callback]setBlockOnDisconnect:block];
}
//  设置查找服务回调
- (void)setBlockOnDiscoverServices:(void (^)(CBPeripheral *peripheral,NSError *error))block {
    [[babySpeaker callback]setBlockOnDiscoverServices:block];
}
//  设置查找到 Characteristics 的 Block
- (void)setBlockOnDiscoverCharacteristics:(void (^)(CBPeripheral *peripheral,CBService *service,NSError *error))block {
    [[babySpeaker callback]setBlockOnDiscoverCharacteristics:block];
}
//  设置获取到最新 Characteristics 值的 Block
- (void)setBlockOnReadValueForCharacteristic:(void (^)(CBPeripheral *peripheral,CBCharacteristic *characteristic,NSError *error))block {
    [[babySpeaker callback]setBlockOnReadValueForCharacteristic:block];
}
//  设置查找到 Characteristics 描述的 Block
- (void)setBlockOnDiscoverDescriptorsForCharacteristic:(void (^)(CBPeripheral *peripheral,CBCharacteristic *service,NSError *error))block {
    [[babySpeaker callback]setBlockOnDiscoverDescriptorsForCharacteristic:block];
}
//  设置读取到 Characteristics 描述的值的 Block
- (void)setBlockOnReadValueForDescriptors:(void (^)(CBPeripheral *peripheral,CBDescriptor *descriptor,NSError *error))block {
    [[babySpeaker callback]setBlockOnReadValueForDescriptors:block];
}

//  写 Characteristic 成功后的 Block
- (void)setBlockOnDidWriteValueForCharacteristic:(void (^)(CBCharacteristic *characteristic,NSError *error))block {
    [[babySpeaker callback]setBlockOnDidWriteValueForCharacteristic:block];
}
//  写 Descriptor 成功后的 Block
- (void)setBlockOnDidWriteValueForDescriptor:(void (^)(CBDescriptor *descriptor,NSError *error))block {
    [[babySpeaker callback]setBlockOnDidWriteValueForDescriptor:block];
}
//  Characteristic 订阅状态改变的 Block
- (void)setBlockOnDidUpdateNotificationStateForCharacteristic:(void (^)(CBCharacteristic *characteristic,NSError *error))block {
    [[babySpeaker callback]setBlockOnDidUpdateNotificationStateForCharacteristic:block];
}
//  读取 RSSI 的委托
- (void)setBlockOnDidReadRSSI:(void (^)(NSNumber *RSSI,NSError *error))block {
    [[babySpeaker callback]setBlockOnDidReadRSSI:block];
}
//  DiscoverIncludedServices 的回调，暂时在 babybluetooth 中无作用
- (void)setBlockOnDidDiscoverIncludedServicesForService:(void (^)(CBService *service,NSError *error))block {
    [[babySpeaker callback]setBlockOnDidDiscoverIncludedServicesForService:block];
}
//  外设更新名字后的 Block
- (void)setBlockOnDidUpdateName:(void (^)(CBPeripheral *peripheral))block {
    [[babySpeaker callback]setBlockOnDidUpdateName:block];
}
//  外设更新服务后的 Block
- (void)setBlockOnDidModifyServices:(void (^)(CBPeripheral *peripheral,NSArray *invalidatedServices))block {
    [[babySpeaker callback]setBlockOnDidModifyServices:block];
}

//  设置蓝牙使用的参数参数
- (void)setBabyOptionsWithScanForPeripheralsWithOptions:(NSDictionary *) scanForPeripheralsWithOptions
                          connectPeripheralWithOptions:(NSDictionary *) connectPeripheralWithOptions
                        scanForPeripheralsWithServices:(NSArray *)scanForPeripheralsWithServices
                                  discoverWithServices:(NSArray *)discoverWithServices
                           discoverWithCharacteristics:(NSArray *)discoverWithCharacteristics {
    GSBabyOptions *option = [[GSBabyOptions alloc]initWithscanForPeripheralsWithOptions:scanForPeripheralsWithOptions connectPeripheralWithOptions:connectPeripheralWithOptions scanForPeripheralsWithServices:scanForPeripheralsWithServices discoverWithServices:discoverWithServices discoverWithCharacteristics:discoverWithCharacteristics];
    [[babySpeaker callback]setBabyOptions:option];
}

/*
 channel 的委托
 */
//  设备状态改变的委托 AtChannel
- (void)setBlockOnCentralManagerDidUpdateStateAtChannel:(NSString *)channel
                                                 block:(void (^)(CBCentralManager *central))block {
    [[babySpeaker callbackOnChnnel:channel createWhenNotExist:YES] setBlockOnCentralManagerDidUpdateState:block];
}
//  找到 Peripherals 的委托 AtChannel
- (void)setBlockOnDiscoverToPeripheralsAtChannel:(NSString *)channel
                                          block:(void (^)(CBCentralManager *central,CBPeripheral *peripheral,NSDictionary *advertisementData, NSNumber *RSSI))block {
    [[babySpeaker callbackOnChnnel:channel createWhenNotExist:YES] setBlockOnDiscoverPeripherals:block];
}

//  连接 Peripherals 成功的委托 AtChannel
- (void)setBlockOnConnectedAtChannel:(NSString *)channel
                              block:(void (^)(CBCentralManager *central,CBPeripheral *peripheral))block {
    [[babySpeaker callbackOnChnnel:channel createWhenNotExist:YES] setBlockOnConnectedPeripheral:block];
}

//  连接 Peripherals 失败的委托 AtChannel
- (void)setBlockOnFailToConnectAtChannel:(NSString *)channel
                                  block:(void (^)(CBCentralManager *central,CBPeripheral *peripheral,NSError *error))block {
    [[babySpeaker callbackOnChnnel:channel createWhenNotExist:YES] setBlockOnFailToConnect:block];
}

//  断开 Peripherals 的连接 AtChannel
- (void)setBlockOnDisconnectAtChannel:(NSString *)channel
                               block:(void (^)(CBCentralManager *central,CBPeripheral *peripheral,NSError *error))block {
    [[babySpeaker callbackOnChnnel:channel createWhenNotExist:YES] setBlockOnDisconnect:block];
}

//  设置查找服务回调 AtChannel
- (void)setBlockOnDiscoverServicesAtChannel:(NSString *)channel
                                     block:(void (^)(CBPeripheral *peripheral,NSError *error))block {
    [[babySpeaker callbackOnChnnel:channel createWhenNotExist:YES] setBlockOnDiscoverServices:block];
}

//  设置查找到 Characteristics 的 Block
- (void)setBlockOnDiscoverCharacteristicsAtChannel:(NSString *)channel
                                            block:(void (^)(CBPeripheral *peripheral,CBService *service,NSError *error))block {
    [[babySpeaker callbackOnChnnel:channel createWhenNotExist:YES] setBlockOnDiscoverCharacteristics:block];
}
//  设置获取到最新 Characteristics 值的 Block
- (void)setBlockOnReadValueForCharacteristicAtChannel:(NSString *)channel
                                               block:(void (^)(CBPeripheral *peripheral,CBCharacteristic *characteristic,NSError *error))block {
    [[babySpeaker callbackOnChnnel:channel createWhenNotExist:YES] setBlockOnReadValueForCharacteristic:block];
}
//  设置查找到 Characteristics 描述的 Block
- (void)setBlockOnDiscoverDescriptorsForCharacteristicAtChannel:(NSString *)channel
                                                         block:(void (^)(CBPeripheral *peripheral,CBCharacteristic *service,NSError *error))block {
    [[babySpeaker callbackOnChnnel:channel createWhenNotExist:YES] setBlockOnDiscoverDescriptorsForCharacteristic:block];
}
//  设置读取到 Characteristics 描述的值的 Block
- (void)setBlockOnReadValueForDescriptorsAtChannel:(NSString *)channel
                                            block:(void (^)(CBPeripheral *peripheral,CBDescriptor *descriptor,NSError *error))block {
    [[babySpeaker callbackOnChnnel:channel createWhenNotExist:YES] setBlockOnReadValueForDescriptors:block];
}

//  写 Characteristic 成功后的 Block
- (void)setBlockOnDidWriteValueForCharacteristicAtChannel:(NSString *)channel
                                                        block:(void (^)(CBCharacteristic *characteristic,NSError *error))block {
    [[babySpeaker callbackOnChnnel:channel createWhenNotExist:YES]setBlockOnDidWriteValueForCharacteristic:block];
}
//  写 Descriptor 成功后的 Block
- (void)setBlockOnDidWriteValueForDescriptorAtChannel:(NSString *)channel
                                      block:(void (^)(CBDescriptor *descriptor,NSError *error))block {
    [[babySpeaker callbackOnChnnel:channel createWhenNotExist:YES]setBlockOnDidWriteValueForDescriptor:block];
}
//  Characteristic 订阅状态改变的 Block
- (void)setBlockOnDidUpdateNotificationStateForCharacteristicAtChannel:(NSString *)channel
                                                                     block:(void (^)(CBCharacteristic *characteristic,NSError *error))block {
    [[babySpeaker callbackOnChnnel:channel createWhenNotExist:YES]setBlockOnDidUpdateNotificationStateForCharacteristic:block];
}
//  读取 RSSI 的委托
- (void)setBlockOnDidReadRSSIAtChannel:(NSString *)channel
                                block:(void (^)(NSNumber *RSSI,NSError *error))block {
    [[babySpeaker callbackOnChnnel:channel createWhenNotExist:YES]setBlockOnDidReadRSSI:block];
}
//  DiscoverIncludedServices 的回调，暂时在 babybluetooth 中无作用
- (void)setBlockOnDidDiscoverIncludedServicesForServiceAtChannel:(NSString *)channel
                                                          block:(void (^)(CBService *service,NSError *error))block {
    [[babySpeaker callbackOnChnnel:channel createWhenNotExist:YES]setBlockOnDidDiscoverIncludedServicesForService:block];
}
//  外设更新名字后的 Block
- (void)setBlockOnDidUpdateNameAtChannel:(NSString *)channel
                                  block:(void (^)(CBPeripheral *peripheral))block {
    [[babySpeaker callbackOnChnnel:channel createWhenNotExist:YES]setBlockOnDidUpdateName:block];
}
//  外设更新服务后的 Block
- (void)setBlockOnDidModifyServicesAtChannel:(NSString *)channel
                                      block:(void (^)(CBPeripheral *peripheral,NSArray *invalidatedServices))block {
    [[babySpeaker callbackOnChnnel:channel createWhenNotExist:YES]setBlockOnDidModifyServices:block];
}


//  设置蓝牙运行时的参数
- (void)setBabyOptionsAtChannel:(NSString *)channel
 scanForPeripheralsWithOptions:(NSDictionary *) scanForPeripheralsWithOptions
  connectPeripheralWithOptions:(NSDictionary *) connectPeripheralWithOptions
    scanForPeripheralsWithServices:(NSArray *)scanForPeripheralsWithServices
          discoverWithServices:(NSArray *)discoverWithServices
   discoverWithCharacteristics:(NSArray *)discoverWithCharacteristics {
    
    GSBabyOptions *option = [[GSBabyOptions alloc]initWithscanForPeripheralsWithOptions:scanForPeripheralsWithOptions connectPeripheralWithOptions:connectPeripheralWithOptions scanForPeripheralsWithServices:scanForPeripheralsWithServices discoverWithServices:discoverWithServices discoverWithCharacteristics:discoverWithCharacteristics];
     [[babySpeaker callbackOnChnnel:channel createWhenNotExist:YES]setBabyOptions:option];
}

#pragma mark - babybluetooth filter 委托
//  设置查找 Peripherals 的规则
- (void)setFilterOnDiscoverPeripherals:(BOOL (^)(NSString *peripheralName, NSDictionary *advertisementData, NSNumber *RSSI))filter {
    [[babySpeaker callback]setFilterOnDiscoverPeripherals:filter];
}
//  设置连接 Peripherals 的规则
- (void)setFilterOnConnectToPeripherals:(BOOL (^)(NSString *peripheralName, NSDictionary *advertisementData, NSNumber *RSSI))filter {
    [[babySpeaker callback]setFilterOnconnectToPeripherals:filter];
}
//  设置查找 Peripherals 的规则
- (void)setFilterOnDiscoverPeripheralsAtChannel:(NSString *)channel
                                      filter:(BOOL (^)(NSString *peripheralName, NSDictionary *advertisementData, NSNumber *RSSI))filter {
    [[babySpeaker callbackOnChnnel:channel createWhenNotExist:YES] setFilterOnDiscoverPeripherals:filter];
}
//  设置连接 Peripherals 的规则
- (void)setFilterOnConnectToPeripheralsAtChannel:(NSString *)channel
                                     filter:(BOOL (^)(NSString *peripheralName, NSDictionary *advertisementData, NSNumber *RSSI))filter {
    [[babySpeaker callbackOnChnnel:channel createWhenNotExist:YES] setFilterOnconnectToPeripherals:filter];
}

#pragma mark - babybluetooth Special
//  babyBluettooth cancelScan 方法调用后的回调
- (void)setBlockOnCancelScanBlock:(void(^)(CBCentralManager *centralManager))block {
    [[babySpeaker callback]setBlockOnCancelScan:block];
}
//  babyBluettooth cancelAllPeripheralsConnectionBlock 方法调用后的回调
- (void)setBlockOnCancelAllPeripheralsConnectionBlock:(void(^)(CBCentralManager *centralManager))block{
    [[babySpeaker callback]setBlockOnCancelAllPeripheralsConnection:block];
}
//  babyBluettooth cancelScan 方法调用后的回调
- (void)setBlockOnCancelScanBlockAtChannel:(NSString *)channel
                                    block:(void(^)(CBCentralManager *centralManager))block {
    [[babySpeaker callbackOnChnnel:channel createWhenNotExist:YES] setBlockOnCancelScan:block];
}
//  babyBluettooth cancelAllPeripheralsConnectionBlock 方法调用后的回调
- (void)setBlockOnCancelAllPeripheralsConnectionBlockAtChannel:(NSString *)channel
                                                        block:(void(^)(CBCentralManager *centralManager))block {
    [[babySpeaker callbackOnChnnel:channel createWhenNotExist:YES] setBlockOnCancelAllPeripheralsConnection:block];
}

#pragma mark - 链式函数
//  查找 Peripherals
- (GSBabyBluetooth *(^)(void)) scanForPeripherals {
    return ^GSBabyBluetooth *() {
        [self->babyCentralManager->pocket setObject:@"YES" forKey:@"needScanForPeripherals"];
        return self;
    };
}

//  连接 Peripherals
- (GSBabyBluetooth *(^)(void)) connectToPeripherals {
    return ^GSBabyBluetooth *() {
        [self->babyCentralManager->pocket setObject:@"YES" forKey:@"needConnectPeripheral"];
        return self;
    };
}

//  发现 Services
- (GSBabyBluetooth *(^)(void)) discoverServices {
    return ^GSBabyBluetooth *() {
        [self->babyCentralManager->pocket setObject:@"YES" forKey:@"needDiscoverServices"];
        return self;
    };
}

//  获取 Characteristics
- (GSBabyBluetooth *(^)(void)) discoverCharacteristics {
    return ^GSBabyBluetooth *() {
        [self->babyCentralManager->pocket setObject:@"YES" forKey:@"needDiscoverCharacteristics"];
        return self;
    };
}

//  更新 Characteristics 的值
- (GSBabyBluetooth *(^)(void)) readValueForCharacteristic {
    return ^GSBabyBluetooth *() {
        [self->babyCentralManager->pocket setObject:@"YES" forKey:@"needReadValueForCharacteristic"];
        return self;
    };
}

//  设置查找到 Descriptors 名称的 Block
- (GSBabyBluetooth *(^)(void)) discoverDescriptorsForCharacteristic {
    return ^GSBabyBluetooth *() {
        [self->babyCentralManager->pocket setObject:@"YES" forKey:@"needDiscoverDescriptorsForCharacteristic"];
        return self;
    };
}

//  设置读取到 Descriptors 值的 Block
- (GSBabyBluetooth *(^)(void)) readValueForDescriptors {
    return ^GSBabyBluetooth *() {
        [self->babyCentralManager->pocket setObject:@"YES" forKey:@"needReadValueForDescriptors"];
        return self;
    };
}

//  开始并执行
- (GSBabyBluetooth *(^)(void)) begin {
    return ^GSBabyBluetooth *() {
        //  取消未执行的 stop 定时任务
        [self->timerForStop invalidate];
        dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [self resetSeriseParmeter];
            //  处理链式函数缓存的数据
            if ([[self->babyCentralManager->pocket valueForKey:@"needScanForPeripherals"] isEqualToString:@"YES"]) {
                self->babyCentralManager->needScanForPeripherals = YES;
            }
            if ([[self->babyCentralManager->pocket valueForKey:@"needConnectPeripheral"] isEqualToString:@"YES"]) {
                self->babyCentralManager->needConnectPeripheral = YES;
            }
            if ([[self->babyCentralManager->pocket valueForKey:@"needDiscoverServices"] isEqualToString:@"YES"]) {
                self->babyCentralManager->needDiscoverServices = YES;
            }
            if ([[self->babyCentralManager->pocket valueForKey:@"needDiscoverCharacteristics"] isEqualToString:@"YES"]) {
                self->babyCentralManager->needDiscoverCharacteristics = YES;
            }
            if ([[self->babyCentralManager->pocket valueForKey:@"needReadValueForCharacteristic"] isEqualToString:@"YES"]) {
                self->babyCentralManager->needReadValueForCharacteristic = YES;
            }
            if ([[self->babyCentralManager->pocket valueForKey:@"needDiscoverDescriptorsForCharacteristic"] isEqualToString:@"YES"]) {
                self->babyCentralManager->needDiscoverDescriptorsForCharacteristic = YES;
            }
            if ([[self->babyCentralManager->pocket valueForKey:@"needReadValueForDescriptors"] isEqualToString:@"YES"]) {
                self->babyCentralManager->needReadValueForDescriptors = YES;
            }
            //  调整委托方法的 channel，如果没设置默认为缺省频道
            NSString *channel = [self->babyCentralManager->pocket valueForKey:@"channel"];
            [self->babySpeaker switchChannel:channel];
            //  缓存的peripheral
            CBPeripheral *cachedPeripheral = [self->babyCentralManager->pocket valueForKey:NSStringFromClass([CBPeripheral class])];
            //  校验 series 合法性
            [self validateProcess];
            //  清空 pocjet
            self->babyCentralManager->pocket = [[NSMutableDictionary alloc]init];
            //  开始扫描或连接设备
            [self start:cachedPeripheral];
        });
        return self;
    };
}


//  私有方法，扫描或连接设备
- (void)start:(CBPeripheral *)cachedPeripheral {
    if (babyCentralManager->centralManager.state == CBManagerStatePoweredOn) {
        CENTRAL_MANAGER_INIT_WAIT_TIMES = 0;
        //  扫描后连接
        if (babyCentralManager->needScanForPeripherals) {
            //  开始扫描peripherals
            [babyCentralManager scanPeripherals];
        }
        //  直接连接
        else {
            if (cachedPeripheral) {
                [babyCentralManager connectToPeripheral:cachedPeripheral];
            }
        }
        return;
    }
    //  尝试重新等待 CBCentralManager 打开
    CENTRAL_MANAGER_INIT_WAIT_TIMES ++;
    if (CENTRAL_MANAGER_INIT_WAIT_TIMES >= KBABY_CENTRAL_MANAGER_INIT_WAIT_TIMES ) {
        BabyLog(@">>> 第%d次等待CBCentralManager 打开任然失败，请检查你蓝牙使用权限或检查设备问题。",CENTRAL_MANAGER_INIT_WAIT_TIMES);
        return;
        //  [NSException raise:@"CBCentralManager打开异常" format:@"尝试等待打开CBCentralManager5次，但任未能打开"];
    }
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, KBABY_CENTRAL_MANAGER_INIT_WAIT_SECOND * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self start:cachedPeripheral];
    });
    BabyLog(@">>> 第%d次等待CBCentralManager打开",CENTRAL_MANAGER_INIT_WAIT_TIMES);
}

//  sec 秒后停止
- (GSBabyBluetooth *(^)(int sec)) stop {
    
    return ^GSBabyBluetooth *(int sec) {
        BabyLog(@">>> stop in %d sec",sec);
        
        //  听见定时器执行babyStop
        self->timerForStop = [NSTimer timerWithTimeInterval:sec target:self selector:@selector(babyStop) userInfo:nil repeats:NO];
        [self->timerForStop setFireDate: [[NSDate date]dateByAddingTimeInterval:sec]];
        [[NSRunLoop currentRunLoop] addTimer:self->timerForStop forMode:NSRunLoopCommonModes];
        
        return self;
    };
}

//  私有方法，停止扫描和断开连接，清空 pocket
- (void)babyStop {
    BabyLog(@">>>did stop");
    [timerForStop invalidate];
    [self resetSeriseParmeter];
    babyCentralManager->pocket = [[NSMutableDictionary alloc]init];
    //  停止扫描，断开连接
    [babyCentralManager cancelScan];
    [babyCentralManager cancelAllPeripheralsConnection];
}

//  重置串行方法参数
- (void)resetSeriseParmeter {
    babyCentralManager->needScanForPeripherals = NO;
    babyCentralManager->needConnectPeripheral = NO;
    babyCentralManager->needDiscoverServices = NO;
    babyCentralManager->needDiscoverCharacteristics = NO;
    babyCentralManager->needReadValueForCharacteristic = NO;
    babyCentralManager->needDiscoverDescriptorsForCharacteristic = NO;
    babyCentralManager->needReadValueForDescriptors = NO;
}

//  持有对象
- (GSBabyBluetooth *(^)(id obj)) having {
    return ^(id obj) {
        [self->babyCentralManager->pocket setObject:obj forKey:NSStringFromClass([obj class])];
        return self;
    };
}


//  切换委托频道
- (GSBabyBluetooth *(^)(NSString *channel)) channel {
    return ^GSBabyBluetooth *(NSString *channel) {
        //  先缓存数据，到 begin 方法统一处理
        [self->babyCentralManager->pocket setValue:channel forKey:@"channel"];
        return self;
    };
}

- (void)validateProcess {
    
    NSMutableArray *faildReason = [[NSMutableArray alloc]init];
    
    //  规则：不执行 discoverDescriptorsForCharacteristic() 时，不能执行 readValueForDescriptors()
    if (!self->babyCentralManager->needDiscoverDescriptorsForCharacteristic) {
        if (self->babyCentralManager->needReadValueForDescriptors) {
            [faildReason addObject:@"未执行 discoverDescriptorsForCharacteristic() 不能执行 readValueForDescriptors()"];
        }
    }
    
    //  规则：不执行discoverCharacteristics() 时，不能执行 readValueForCharacteristic() 或者是 discoverDescriptorsForCharacteristic()
    if (!self->babyCentralManager->needDiscoverCharacteristics) {
        if (self->babyCentralManager->needReadValueForCharacteristic||self->babyCentralManager->needDiscoverDescriptorsForCharacteristic) {
            [faildReason addObject:@"未执行 discoverCharacteristics() 不能执行 readValueForCharacteristic()或discoverDescriptorsForCharacteristic()"];
        }
    }
    
    //  规则： 不执行 discoverServices() 不能执行 discoverCharacteristics()、readValueForCharacteristic()、discoverDescriptorsForCharacteristic()、readValueForDescriptors()
    if (!self->babyCentralManager->needDiscoverServices) {
        if (self->babyCentralManager->needDiscoverCharacteristics||self->babyCentralManager->needDiscoverDescriptorsForCharacteristic ||self->babyCentralManager->needReadValueForCharacteristic ||self->babyCentralManager->needReadValueForDescriptors) {
             [faildReason addObject:@"未执行 discoverServices() 不能执行 discoverCharacteristics()、readValueForCharacteristic()、discoverDescriptorsForCharacteristic()、readValueForDescriptors()"];
        }
        
    }

    //  规则：不执行 connectToPeripherals() 时，不能执行 discoverServices()
    if(!self->babyCentralManager->needConnectPeripheral) {
        if (self->babyCentralManager->needDiscoverServices) {
             [faildReason addObject:@"未执行 connectToPeripherals() 不能执行 discoverServices()"];
        }
    }
    
    //  规则：不执行needScanForPeripherals()，那么执行connectToPeripheral()方法时必须用having(peripheral)传入peripheral实例
    if (!self->babyCentralManager->needScanForPeripherals) {
        CBPeripheral *peripheral = [self->babyCentralManager->pocket valueForKey:NSStringFromClass([CBPeripheral class])];
        if (!peripheral) {
            [faildReason addObject:@"若不执行 scanForPeripherals() 方法，则必须执行 connectToPeripheral 方法并且需要传入参数 (CBPeripheral *)peripheral"];
        }
    }
    
    //  抛出异常
    if ([faildReason lastObject]) {
        NSException *e = [NSException exceptionWithName:@"BadyBluetooth usage exception" reason:[faildReason lastObject]  userInfo:nil];
        @throw e;
    }
  
}

- (GSBabyBluetooth *) and {
    return self;
}
- (GSBabyBluetooth *) then {
    return self;
}
- (GSBabyBluetooth *) with {
    return self;
}

- (GSBabyBluetooth *(^)(int sec)) enjoy {
    return ^GSBabyBluetooth *(int sec) {
        self.connectToPeripherals().discoverServices().discoverCharacteristics()
        .readValueForCharacteristic().discoverDescriptorsForCharacteristic().readValueForDescriptors().begin();
        return self;
    };
}

#pragma mark - 工具方法
//  断开连接
- (void)cancelPeripheralConnection:(CBPeripheral *)peripheral {
    [babyCentralManager cancelPeripheralConnection:peripheral];
}
//  断开所有连接
- (void)cancelAllPeripheralsConnection {
    [babyCentralManager cancelAllPeripheralsConnection];
}
//  停止扫描
- (void)cancelScan{
    [babyCentralManager cancelScan];
}
//  读取 Characteristic 的详细信息
- (GSBabyBluetooth *(^)(CBPeripheral *peripheral,CBCharacteristic *characteristic)) characteristicDetails {
    //  切换频道
    [babySpeaker switchChannel:[babyCentralManager->pocket valueForKey:@"channel"]];
    babyCentralManager->pocket = [[NSMutableDictionary alloc]init];
    
    return ^(CBPeripheral *peripheral,CBCharacteristic *characteristic) {
        //  判断连接状态
        if (peripheral.state == CBPeripheralStateConnected) {
            self->babyCentralManager->oneReadValueForDescriptors = YES;
            [peripheral readValueForCharacteristic:characteristic];
            [peripheral discoverDescriptorsForCharacteristic:characteristic];
        }
        else {
            BabyLog(@"!!!设备当前处于非连接状态");
        }
        
        return self;
    };
}

- (void)notify:(CBPeripheral *)peripheral
characteristic:(CBCharacteristic *)characteristic
        block:(void(^)(CBPeripheral *peripheral, CBCharacteristic *characteristics, NSError *error))block {
    //  设置通知
    [peripheral setNotifyValue:YES forCharacteristic:characteristic];
    [babySpeaker addNotifyCallback:characteristic withBlock:block];
}

- (void)cancelNotify:(CBPeripheral *)peripheral
     characteristic:(CBCharacteristic *)characteristic {
    [peripheral setNotifyValue:NO forCharacteristic:characteristic];
    [babySpeaker removeNotifyCallback:characteristic];
}

//  获取当前连接的 Peripherals
- (NSArray *)findConnectedPeripherals {
     return [babyCentralManager findConnectedPeripherals];
}

//  获取当前连接的 Peripheral
- (CBPeripheral *)findConnectedPeripheral:(NSString *)peripheralName {
     return [babyCentralManager findConnectedPeripheral:peripheralName];
}

//  获取当前 corebluetooth 的 centralManager 对象
- (CBCentralManager *)centralManager {
    return babyCentralManager->centralManager;
}

/**
 添加断开自动重连的外设
 */
- (void)AutoReconnect:(CBPeripheral *)peripheral{
    [babyCentralManager sometimes_ever:peripheral];
}

/**
 删除断开自动重连的外设
 */
- (void)AutoReconnectCancel:(CBPeripheral *)peripheral{
    [babyCentralManager sometimes_never:peripheral];
}
 
- (CBPeripheral *)retrievePeripheralWithUUIDString:(NSString *)UUIDString {
    CBPeripheral *p = nil;
    @try {
        NSUUID *uuid = [[NSUUID alloc]initWithUUIDString:UUIDString];
        p = [self.centralManager retrievePeripheralsWithIdentifiers:@[uuid]][0];
    } @catch (NSException *exception) {
        BabyLog(@">>> retrievePeripheralWithUUIDString error:%@",exception)
    } @finally {
    }
    return p;
}

#pragma mark - peripheral model

//  进入外设模式
- (CBPeripheralManager *)peripheralManager {
    return babyPeripheralManager.peripheralManager;
}

- (GSBabyPeripheralManager *(^)(void)) bePeripheral {
    return ^GSBabyPeripheralManager* () {
        return self->babyPeripheralManager;
    };
}
- (GSBabyPeripheralManager *(^)(NSString *localName)) bePeripheralWithName {
    return ^GSBabyPeripheralManager* (NSString *localName) {
        self->babyPeripheralManager.localName = localName;
        return self->babyPeripheralManager;
    };
}

- (void)peripheralModelBlockOnPeripheralManagerDidUpdateState:(void(^)(CBPeripheralManager *peripheral))block {
    [[babySpeaker callback]setBlockOnPeripheralModelDidUpdateState:block];
}
- (void)peripheralModelBlockOnDidAddService:(void(^)(CBPeripheralManager *peripheral,CBService *service,NSError *error))block {
    [[babySpeaker callback]setBlockOnPeripheralModelDidAddService:block];
}
- (void)peripheralModelBlockOnDidStartAdvertising:(void(^)(CBPeripheralManager *peripheral,NSError *error))block {
    [[babySpeaker callback]setBlockOnPeripheralModelDidStartAdvertising:block];
}
- (void)peripheralModelBlockOnDidReceiveReadRequest:(void(^)(CBPeripheralManager *peripheral,CBATTRequest *request))block {
    [[babySpeaker callback]setBlockOnPeripheralModelDidReceiveReadRequest:block];
}
- (void)peripheralModelBlockOnDidReceiveWriteRequests:(void(^)(CBPeripheralManager *peripheral,NSArray *requests))block {
    [[babySpeaker callback]setBlockOnPeripheralModelDidReceiveWriteRequests:block];
}
- (void)peripheralModelBlockOnDidSubscribeToCharacteristic:(void(^)(CBPeripheralManager *peripheral,CBCentral *central,CBCharacteristic *characteristic))block {
    [[babySpeaker callback]setBlockOnPeripheralModelDidSubscribeToCharacteristic:block];
}
- (void)peripheralModelBlockOnDidUnSubscribeToCharacteristic:(void(^)(CBPeripheralManager *peripheral,CBCentral *central,CBCharacteristic *characteristic))block {
    [[babySpeaker callback]setBlockOnPeripheralModelDidUnSubscribeToCharacteristic:block];
}

@end
