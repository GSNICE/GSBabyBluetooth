//
//  GSBabyCentralManager.h
//  GSNICE
//
//  Created by Gavin on 2020/6/12.
//  Copyright © 2020 GSNICE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import "GSBabyToy.h"
#import "GSBabySpeaker.h"
#import "GSBabyDefine.h"

@interface GSBabyCentralManager : NSObject<CBCentralManagerDelegate,CBPeripheralDelegate> {

@public

    //  方法是否处理
    BOOL needScanForPeripherals;    //  是否扫描 Peripherals
    BOOL needConnectPeripheral;     //  是否连接 Peripherals
    BOOL needDiscoverServices;      //  是否发现 Services
    BOOL needDiscoverCharacteristics;//  是否获取 Characteristics
    BOOL needReadValueForCharacteristic;//  是否获取（更新）Characteristics 的值
    BOOL needDiscoverDescriptorsForCharacteristic;//  是否获取 Characteristics 的描述
    BOOL needReadValueForDescriptors;//  是否获取 Descriptors 的值
    
    //  一次性处理
    BOOL oneReadValueForDescriptors;
    
    //  方法执行时间
    int executeTime;
    NSTimer *connectTimer;
    //  pocket
    NSMutableDictionary *pocket;

    //  主设备
    CBCentralManager *centralManager;
    //  回叫方法
    GSBabySpeaker *babySpeaker;
    
@private
    //  已经连接的设备
    NSMutableArray *connectedPeripherals;
    //  已经连接的设备
    NSMutableArray *discoverPeripherals;
    //  需要自动重连的外设
    NSMutableArray *reConnectPeripherals;
}

//  扫描 Peripherals
- (void)scanPeripherals;
//  连接 Peripherals
- (void)connectToPeripheral:(CBPeripheral *)peripheral;
//  断开设备连接
- (void)cancelPeripheralConnection:(CBPeripheral *)peripheral;
//  断开所有已连接的设备
- (void)cancelAllPeripheralsConnection;
//  停止扫描
- (void)cancelScan;

//  获取当前连接的 Peripherals
- (NSArray *)findConnectedPeripherals;

//  获取当前连接的 Peripheral
- (CBPeripheral *)findConnectedPeripheral:(NSString *)peripheralName;

/**
 sometimes ever，sometimes never.  相聚有时，后会无期
 
 this is center with peripheral's story
 **/

//  sometimes ever：添加断开重连接的设备
-  (void)sometimes_ever:(CBPeripheral *)peripheral ;
//  sometimes never：删除需要重连接的设备
-  (void)sometimes_never:(CBPeripheral *)peripheral ;

@end



