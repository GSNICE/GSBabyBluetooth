//
//  GSBabyCallback.h
//  GSNICE
//
//  Created by Gavin on 2020/6/12.
//  Copyright © 2020 GSNICE. All rights reserved.
//

#import <CoreBluetooth/CoreBluetooth.h>
#import "GSBabyOptions.h"

//  设备状态改变的委托
typedef void (^GSBBCentralManagerDidUpdateStateBlock)(CBCentralManager *central);
//  找到设备的委托
typedef void (^GSBBDiscoverPeripheralsBlock)(CBCentralManager *central,CBPeripheral *peripheral,NSDictionary *advertisementData, NSNumber *RSSI);
//  连接设备成功的 Block
typedef void (^GSBBConnectedPeripheralBlock)(CBCentralManager *central,CBPeripheral *peripheral);
//  连接设备失败的 Block
typedef void (^GSBBFailToConnectBlock)(CBCentralManager *central,CBPeripheral *peripheral,NSError *error);
//  断开设备连接的 Block
typedef void (^GSBBDisconnectBlock)(CBCentralManager *central,CBPeripheral *peripheral,NSError *error);
//  找到服务的 Block
typedef void (^GSBBDiscoverServicesBlock)(CBPeripheral *peripheral,NSError *error);
//  找到 Characteristics 的 Block
typedef void (^GSBBDiscoverCharacteristicsBlock)(CBPeripheral *peripheral,CBService *service,NSError *error);
//  更新（获取）Characteristics 的 value 的 Block
typedef void (^GSBBReadValueForCharacteristicBlock)(CBPeripheral *peripheral,CBCharacteristic *characteristic,NSError *error);
//  获取 Characteristics 的名称
typedef void (^GSBBDiscoverDescriptorsForCharacteristicBlock)(CBPeripheral *peripheral,CBCharacteristic *service,NSError *error);
//  获取Descriptors的值
typedef void (^GSBBReadValueForDescriptorsBlock)(CBPeripheral *peripheral,CBDescriptor *descriptor,NSError *error);

//  babyBluettooth cancelScanBlock 方法调用后的回调
typedef void (^GSBBCancelScanBlock)(CBCentralManager *centralManager);
//  babyBluettooth cancelAllPeripheralsConnection 方法调用后的 Block
typedef void (^GSBBCancelAllPeripheralsConnectionBlock)(CBCentralManager *centralManager);

typedef void (^GSBBDidWriteValueForCharacteristicBlock)(CBCharacteristic *characteristic,NSError *error);

typedef void (^GSBBDidWriteValueForDescriptorBlock)(CBDescriptor *descriptor,NSError *error);

typedef void (^GSBBDidUpdateNotificationStateForCharacteristicBlock)(CBCharacteristic *characteristic,NSError *error);

typedef void (^GSBBDidReadRSSIBlock)(NSNumber *RSSI,NSError *error);

typedef void (^GSBBDidDiscoverIncludedServicesForServiceBlock)(CBService *service,NSError *error);

typedef void (^GSBBDidUpdateNameBlock)(CBPeripheral *peripheral);

typedef void (^GSBBDidModifyServicesBlock)(CBPeripheral *peripheral,NSArray *invalidatedServices);

// peripheral model
typedef void (^GSBBPeripheralModelDidUpdateState)(CBPeripheralManager *peripheral);
typedef void (^GSBBPeripheralModelDidAddService)(CBPeripheralManager *peripheral,CBService *service,NSError *error);
typedef void (^GSBBPeripheralModelDidStartAdvertising)(CBPeripheralManager *peripheral,NSError *error);
typedef void (^GSBBPeripheralModelDidReceiveReadRequest)(CBPeripheralManager *peripheral,CBATTRequest *request);
typedef void (^GSBBPeripheralModelDidReceiveWriteRequests)(CBPeripheralManager *peripheral,NSArray *requests);
typedef void (^GSBBPeripheralModelDidSubscribeToCharacteristic)(CBPeripheralManager *peripheral,CBCentral *central,CBCharacteristic *characteristic);
typedef void (^GSBBPeripheralModelDidUnSubscribeToCharacteristic)(CBPeripheralManager *peripheral,CBCentral *central,CBCharacteristic *characteristic);

@interface GSBabyCallback : NSObject

#pragma mark - Callback block
//  设备状态改变的委托
@property (nonatomic, copy) GSBBCentralManagerDidUpdateStateBlock blockOnCentralManagerDidUpdateState;
//  发现 peripherals
@property (nonatomic, copy) GSBBDiscoverPeripheralsBlock blockOnDiscoverPeripherals;
//  连接设备成功 Block
@property (nonatomic, copy) GSBBConnectedPeripheralBlock blockOnConnectedPeripheral;
//  连接设备失败 Block
@property (nonatomic, copy) GSBBFailToConnectBlock blockOnFailToConnect;
//  断开设备连接 Block
@property (nonatomic, copy) GSBBDisconnectBlock blockOnDisconnect;
// 发现 services Block
@property (nonatomic, copy) GSBBDiscoverServicesBlock blockOnDiscoverServices;
// 发现 Characteristics Block
@property (nonatomic, copy) GSBBDiscoverCharacteristicsBlock blockOnDiscoverCharacteristics;
// 发现更新 Characteristics Block
@property (nonatomic, copy) GSBBReadValueForCharacteristicBlock blockOnReadValueForCharacteristic;
//  获取 Characteristics 的名称 Block
@property (nonatomic, copy) GSBBDiscoverDescriptorsForCharacteristicBlock blockOnDiscoverDescriptorsForCharacteristic;
//  获取 Descriptors 的值 Block
@property (nonatomic, copy) GSBBReadValueForDescriptorsBlock blockOnReadValueForDescriptors;

@property (nonatomic, copy) GSBBDidWriteValueForCharacteristicBlock blockOnDidWriteValueForCharacteristic;

@property (nonatomic, copy) GSBBDidWriteValueForDescriptorBlock blockOnDidWriteValueForDescriptor;

@property (nonatomic, copy) GSBBDidUpdateNotificationStateForCharacteristicBlock blockOnDidUpdateNotificationStateForCharacteristic;

@property (nonatomic, copy) GSBBDidReadRSSIBlock blockOnDidReadRSSI;

@property (nonatomic, copy) GSBBDidDiscoverIncludedServicesForServiceBlock blockOnDidDiscoverIncludedServicesForService;

@property (nonatomic, copy) GSBBDidUpdateNameBlock blockOnDidUpdateName;

@property (nonatomic, copy) GSBBDidModifyServicesBlock blockOnDidModifyServices;

//  babyBluettooth stopScan 方法调用后的回调
@property(nonatomic,copy) GSBBCancelScanBlock blockOnCancelScan;
//  babyBluettooth stopConnectAllPerihperals 方法调用后的回调
@property(nonatomic,copy) GSBBCancelAllPeripheralsConnectionBlock blockOnCancelAllPeripheralsConnection;
//  babyBluettooth 蓝牙使用的参数参数
@property(nonatomic,strong) GSBabyOptions *babyOptions;

#pragma mark - 过滤器 Filter
//  发现 peripherals 规则
@property (nonatomic, copy) BOOL (^filterOnDiscoverPeripherals)(NSString *peripheralName, NSDictionary *advertisementData, NSNumber *RSSI);
//  连接 peripherals 规则
@property (nonatomic, copy) BOOL (^filterOnconnectToPeripherals)(NSString *peripheralName, NSDictionary *advertisementData, NSNumber *RSSI);

#pragma mark - peripheral model
//  peripheral model
@property (nonatomic, copy) GSBBPeripheralModelDidUpdateState blockOnPeripheralModelDidUpdateState;
@property (nonatomic, copy) GSBBPeripheralModelDidAddService blockOnPeripheralModelDidAddService;
@property (nonatomic, copy) GSBBPeripheralModelDidStartAdvertising blockOnPeripheralModelDidStartAdvertising;
@property (nonatomic, copy) GSBBPeripheralModelDidReceiveReadRequest blockOnPeripheralModelDidReceiveReadRequest;
@property (nonatomic, copy) GSBBPeripheralModelDidReceiveWriteRequests blockOnPeripheralModelDidReceiveWriteRequests;
@property (nonatomic, copy) GSBBPeripheralModelDidSubscribeToCharacteristic blockOnPeripheralModelDidSubscribeToCharacteristic;
@property (nonatomic, copy) GSBBPeripheralModelDidUnSubscribeToCharacteristic blockOnPeripheralModelDidUnSubscribeToCharacteristic;

@end
