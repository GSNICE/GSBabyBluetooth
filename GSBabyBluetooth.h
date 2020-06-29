//
//  GSBabyBluetooth.h
//  GSNICE
//
//  Created by Gavin on 2020/6/12.
//  Copyright © 2020 GSNICE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import "GSBabyCentralManager.h"
#import "GSBabyPeripheralManager.h"
#import "GSBabyToy.h"
#import "GSBabySpeaker.h"
#import "GSBabyRhythm.h"
#import "GSBabyDefine.h"

@interface GSBabyBluetooth : NSObject

#pragma mark - babybluetooth的委托

//  默认频道的委托

/**
设备状态改变的 Block |  when CentralManager state changed
*/
- (void)setBlockOnCentralManagerDidUpdateState:(void (^)(CBCentralManager *central))block;

/**
 找到 Peripherals 的 Block |  when find peripheral
 */
- (void)setBlockOnDiscoverToPeripherals:(void (^)(CBCentralManager *central,CBPeripheral *peripheral,NSDictionary *advertisementData, NSNumber *RSSI))block;

/**
连接 Peripherals 成功的 Block
|  when connected peripheral
*/
- (void)setBlockOnConnected:(void (^)(CBCentralManager *central,CBPeripheral *peripheral))block;

/**
连接 Peripherals 失败的 Block
|  when fail to connect peripheral
*/
- (void)setBlockOnFailToConnect:(void (^)(CBCentralManager *central,CBPeripheral *peripheral,NSError *error))block;

/**
断开 Peripherals 的连接的 Block
|  when disconnected peripheral
*/
- (void)setBlockOnDisconnect:(void (^)(CBCentralManager *central,CBPeripheral *peripheral,NSError *error))block;

/**
设置查找服务的 Block
|  when discover services of peripheral
*/
- (void)setBlockOnDiscoverServices:(void (^)(CBPeripheral *peripheral,NSError *error))block;

/**
设置查找到 Characteristics 的 Block
|  when discovered Characteristics
*/
- (void)setBlockOnDiscoverCharacteristics:(void (^)(CBPeripheral *peripheral,CBService *service,NSError *error))block;

/**
设置获取到最新 Characteristics 值的 Block
|  when read new characteristics value  or notiy a characteristics value
*/
- (void)setBlockOnReadValueForCharacteristic:(void (^)(CBPeripheral *peripheral,CBCharacteristic *characteristic,NSError *error))block;

/**
设置查找到 Descriptors 名称的 Block
|  when discover descriptors for characteristic
*/
- (void)setBlockOnDiscoverDescriptorsForCharacteristic:(void (^)(CBPeripheral *peripheral,CBCharacteristic *characteristic,NSError *error))block;

/**
设置读取到 Descriptors 值的 Block
|  when read descriptors for characteristic
*/
- (void)setBlockOnReadValueForDescriptors:(void (^)(CBPeripheral *peripheral,CBDescriptor *descriptor,NSError *error))block;

/**
写 Characteristic 成功后的 Block
|  when did write value for characteristic successed
*/
- (void)setBlockOnDidWriteValueForCharacteristic:(void (^)(CBCharacteristic *characteristic,NSError *error))block;

/**
写 Descriptor 成功后的 Block
|  when did write value for descriptor successed
*/
- (void)setBlockOnDidWriteValueForDescriptor:(void (^)(CBDescriptor *descriptor,NSError *error))block;

/**
Characteristic 订阅状态改变的 Block
|  when characteristic notification state changed
*/
- (void)setBlockOnDidUpdateNotificationStateForCharacteristic:(void (^)(CBCharacteristic *characteristic,NSError *error))block;

/**
读取 RSSI 的委托
|  when did read RSSI
*/
- (void)setBlockOnDidReadRSSI:(void (^)(NSNumber *RSSI,NSError *error))block;

/**
DiscoverIncludedServices 的回调，暂时在 babybluetooth 中无作用
|  no used in babybluetooth
*/
- (void)setBlockOnDidDiscoverIncludedServicesForService:(void (^)(CBService *service,NSError *error))block;

/**
外设更新名字后的 Block
|  when peripheral update name
*/
- (void)setBlockOnDidUpdateName:(void (^)(CBPeripheral *peripheral))block;

/**
外设更新服务后的 Block
|  when peripheral update services
*/
- (void)setBlockOnDidModifyServices:(void (^)(CBPeripheral *peripheral,NSArray *invalidatedServices))block;



// channel的委托
/**
设备状态改变的 Block
|  when CentralManager state changed
*/
- (void)setBlockOnCentralManagerDidUpdateStateAtChannel:(NSString *)channel
                                                 block:(void (^)(CBCentralManager *central))block;
/**
找到 Peripherals 的 Block
|  when find peripheral
*/
- (void)setBlockOnDiscoverToPeripheralsAtChannel:(NSString *)channel
                                          block:(void (^)(CBCentralManager *central,CBPeripheral *peripheral,NSDictionary *advertisementData, NSNumber *RSSI))block;

/**
连接 Peripherals 成功的 Block
|  when connected peripheral
*/
- (void)setBlockOnConnectedAtChannel:(NSString *)channel
                              block:(void (^)(CBCentralManager *central,CBPeripheral *peripheral))block;

/**
连接 Peripherals 失败的 Block
|  when fail to connect peripheral
*/
- (void)setBlockOnFailToConnectAtChannel:(NSString *)channel
                                  block:(void (^)(CBCentralManager *central,CBPeripheral *peripheral,NSError *error))block;

/**
断开 Peripherals 的连接的 Block
|  when disconnected peripheral
*/
- (void)setBlockOnDisconnectAtChannel:(NSString *)channel
                               block:(void (^)(CBCentralManager *central,CBPeripheral *peripheral,NSError *error))block;

/**
设置查找服务的 Block
|  when discover services of peripheral
*/
- (void)setBlockOnDiscoverServicesAtChannel:(NSString *)channel
                                     block:(void (^)(CBPeripheral *peripheral,NSError *error))block;

/**
设置查找到 Characteristics 的 Block
|  when discovered Characteristics
*/
- (void)setBlockOnDiscoverCharacteristicsAtChannel:(NSString *)channel
                                            block:(void (^)(CBPeripheral *peripheral,CBService *service,NSError *error))block;

/**
设置获取到最新 Characteristics 值的 Block
|  when read new characteristics value  or notiy a characteristics value
*/
- (void)setBlockOnReadValueForCharacteristicAtChannel:(NSString *)channel
                                               block:(void (^)(CBPeripheral *peripheral,CBCharacteristic *characteristic,NSError *error))block;

/**
设置查找到 Characteristics 描述的 Block
|  when discover descriptors for characteristic
*/
- (void)setBlockOnDiscoverDescriptorsForCharacteristicAtChannel:(NSString *)channel
                                                         block:(void (^)(CBPeripheral *peripheral,CBCharacteristic *service,NSError *error))block;

/**
设置读取到 Characteristics 描述的值的 Block
|  when read descriptors for characteristic
*/
- (void)setBlockOnReadValueForDescriptorsAtChannel:(NSString *)channel
                                            block:(void (^)(CBPeripheral *peripheral,CBDescriptor *descriptor,NSError *error))block;


/**
写 Characteristic 成功后的 Block
|  when did write value for characteristic successed
*/
- (void)setBlockOnDidWriteValueForCharacteristicAtChannel:(NSString *)channel
                                                   block:(void (^)(CBCharacteristic *characteristic,NSError *error))block;

/**
写 Descriptor 成功后的 Block
|  when did write value for descriptor successed
*/
- (void)setBlockOnDidWriteValueForDescriptorAtChannel:(NSString *)channel
                                               block:(void (^)(CBDescriptor *descriptor,NSError *error))block;


/**
Characteristic 订阅状态改变的 Block
|  when characteristic notification state changed
*/
- (void)setBlockOnDidUpdateNotificationStateForCharacteristicAtChannel:(NSString *)channel
                                                                block:(void (^)(CBCharacteristic *characteristic,NSError *error))block;

/**
读取 RSSI 的委托
|  when did read RSSI
*/
- (void)setBlockOnDidReadRSSIAtChannel:(NSString *)channel
                                block:(void (^)(NSNumber *RSSI,NSError *error))block;

/**
DiscoverIncludedServices 的回调，暂时在 babybluetooth 中无作用
|  no used in babybluetooth
*/
- (void)setBlockOnDidDiscoverIncludedServicesForServiceAtChannel:(NSString *)channel
                                                          block:(void (^)(CBService *service,NSError *error))block;

/**
外设更新名字后的 Block
|  when peripheral update name
*/
- (void)setBlockOnDidUpdateNameAtChannel:(NSString *)channel
                                  block:(void (^)(CBPeripheral *peripheral))block;

/**
外设更新服务后的 Block
|  when peripheral update services
*/
- (void)setBlockOnDidModifyServicesAtChannel:(NSString *)channel
                                      block:(void (^)(CBPeripheral *peripheral,NSArray *invalidatedServices))block;


#pragma mark - babybluetooth filter

/**
设置查找 Peripherals 的规则
|  filter of discover peripherals
*/
- (void)setFilterOnDiscoverPeripherals:(BOOL (^)(NSString *peripheralName, NSDictionary *advertisementData, NSNumber *RSSI))filter;

/**
设置连接 Peripherals 的规则
|  setting filter of connect to peripherals  peripherals
*/
- (void)setFilterOnConnectToPeripherals:(BOOL (^)(NSString *peripheralName, NSDictionary *advertisementData, NSNumber *RSSI))filter;


/**
设置查找 Peripherals 的规则 AtChannel
|  filter of discover peripherals
*/
- (void)setFilterOnDiscoverPeripheralsAtChannel:(NSString *)channel
                                      filter:(BOOL (^)(NSString *peripheralName, NSDictionary *advertisementData, NSNumber *RSSI))filter;

/**
设置连接 Peripherals 的规则 AtChannel
|  setting filter of connect to peripherals  peripherals
*/
- (void)setFilterOnConnectToPeripheralsAtChannel:(NSString *)channel
                                     filter:(BOOL (^)(NSString *peripheralName, NSDictionary *advertisementData, NSNumber *RSSI))filter;


#pragma mark - babybluetooth Special

/**
babyBluettooth cancelScan 方法调用后的回调
|  when after call cancelScan
*/
- (void)setBlockOnCancelScanBlock:(void(^)(CBCentralManager *centralManager))block;

/**
babyBluettooth cancelAllPeripheralsConnectionBlock 方法执行后并且全部设备断开后的回调
|  when did all peripheral disConnect
*/
- (void)setBlockOnCancelAllPeripheralsConnectionBlock:(void(^)(CBCentralManager *centralManager))block;

/**
babyBluettooth cancelScan 方法调用后的回调
|  when after call cancelScan
*/
- (void)setBlockOnCancelScanBlockAtChannel:(NSString *)channel
                                         block:(void(^)(CBCentralManager *centralManager))block;

/**
babyBluettooth cancelAllPeripheralsConnectionBlock 方法执行后并且全部设备断开后的回调
|  when did all peripheral disConnect
*/
- (void)setBlockOnCancelAllPeripheralsConnectionBlockAtChannel:(NSString *)channel
                                                             block:(void(^)(CBCentralManager *centralManager))block;

/**
设置蓝牙运行时的参数
|  set ble runtime parameters
*/
- (void)setBabyOptionsWithScanForPeripheralsWithOptions:(NSDictionary *) scanForPeripheralsWithOptions
                          connectPeripheralWithOptions:(NSDictionary *) connectPeripheralWithOptions
                        scanForPeripheralsWithServices:(NSArray *)scanForPeripheralsWithServices
                                  discoverWithServices:(NSArray *)discoverWithServices
                           discoverWithCharacteristics:(NSArray *)discoverWithCharacteristics;

/**
设置蓝牙运行时的参数
|  set ble runtime parameters
*/
- (void)setBabyOptionsAtChannel:(NSString *)channel
 scanForPeripheralsWithOptions:(NSDictionary *) scanForPeripheralsWithOptions
  connectPeripheralWithOptions:(NSDictionary *) connectPeripheralWithOptions
scanForPeripheralsWithServices:(NSArray *)scanForPeripheralsWithServices
          discoverWithServices:(NSArray *)discoverWithServices
   discoverWithCharacteristics:(NSArray *)discoverWithCharacteristics;


#pragma mark - 链式函数
/**
查找 Peripherals
 */
- (GSBabyBluetooth *(^)(void)) scanForPeripherals;

/**
连接 Peripherals
 */
- (GSBabyBluetooth *(^)(void)) connectToPeripherals;

/**
发现 Services
 */
- (GSBabyBluetooth *(^)(void)) discoverServices;

/**
获取 Characteristics
 */
- (GSBabyBluetooth *(^)(void)) discoverCharacteristics;

/**
更新 Characteristics 的值
 */
- (GSBabyBluetooth *(^)(void)) readValueForCharacteristic;

/**
获取 Characteristics 的名称
 */
- (GSBabyBluetooth *(^)(void)) discoverDescriptorsForCharacteristic;

/**
获取 Descriptors 的值
 */
- (GSBabyBluetooth *(^)(void)) readValueForDescriptors;

/**
开始执行
 */
- (GSBabyBluetooth *(^)(void)) begin;

/**
sec 秒后停止
 */
- (GSBabyBluetooth *(^)(int sec)) stop;

/**
持有对象
 */
- (GSBabyBluetooth *(^)(id obj)) having;

/**
切换委托的频道
 */
- (GSBabyBluetooth *(^)(NSString *channel)) channel;

/**
谓词，返回 self
 */
- (GSBabyBluetooth *) and;
/**
谓词，返回 self
 */
- (GSBabyBluetooth *) then;
/**
谓词，返回 self
 */
- (GSBabyBluetooth *) with;

/**
 * enjoy 祝你使用愉快，
 *
 *   说明：enjoy是蓝牙全套串行方法的简写（发现服务，发现特征，读取特征，读取特征描述），前面可以必须有scanForPeripherals或having方法，channel可以选择添加。
     
    enjoy() 等同于 connectToPeripherals().discoverServices().discoverCharacteristics().readValueForCharacteristic().discoverDescriptorsForCharacteristic().readValueForDescriptors().begin();
    
    它可以让你少敲很多代码
 
     ## 例子：
     - 扫描后来个全套（发现服务，发现特征，读取特征，读取特征描述）
     
     ` baby.scanForPeripherals().connectToPeripherals().discoverServices().discoverCharacteristics()
     .readValueForCharacteristic().discoverDescriptorsForCharacteristic().readValueForDescriptors().begin();
     `
     
     - 直接使用已有的外设连接后全套（发现服务，发现特征，读取特征，读取特征描述）

     ` baby.having(self.peripheral).connectToPeripherals().discoverServices().discoverCharacteristics()
     .readValueForCharacteristic().discoverDescriptorsForCharacteristic().readValueForDescriptors().begin();
 `
 enjoy后面也可以加stop()方法
 */
- (GSBabyBluetooth *(^)(int sec)) enjoy;

#pragma mark - 工具方法

/**
 * 单例构造方法
 * @return BabyBluetooth 共享实例
 */
+ (instancetype)shareBabyBluetooth;

/**
断开连接
 */
- (void)cancelPeripheralConnection:(CBPeripheral *)peripheral;

/**
断开所有连接
 */
- (void)cancelAllPeripheralsConnection;

/**
停止扫描
 */
- (void)cancelScan;

/**
更新 Characteristics 的值
 */
- (GSBabyBluetooth *(^)(CBPeripheral *peripheral,CBCharacteristic *characteristic)) characteristicDetails;

/**
设置 Characteristic 的 notify
 */
- (void)notify:(CBPeripheral *)peripheral
characteristic:(CBCharacteristic *)characteristic
         block:(void(^)(CBPeripheral *peripheral, CBCharacteristic *characteristics, NSError *error))block;

/**
取消 Characteristic 的 notify
 */
- (void)cancelNotify:(CBPeripheral *)peripheral
     characteristic:(CBCharacteristic *)characteristic;

/**
获取当前连接的 Peripherals
 */
- (NSArray *)findConnectedPeripherals;

/**
获取当前连接的 Peripheral
 */
- (CBPeripheral *)findConnectedPeripheral:(NSString *)peripheralName;

/**
获取当前 corebluetooth 的 centralManager 对象
 */
- (CBCentralManager *)centralManager;

/**
 添加断开自动重连的外设
 */
- (void)AutoReconnect:(CBPeripheral *)peripheral;

/**
 删除断开自动重连的外设
 */
- (void)AutoReconnectCancel:(CBPeripheral *)peripheral;

/**
 根据外设 UUID 对应的 string 获取已配对的外设
 
 通过方法获取外设后可以直接连接外设，跳过扫描过程
 */
- (CBPeripheral *)retrievePeripheralWithUUIDString:(NSString *)UUIDString;


#pragma mark - peripheral model

//  进入外设模式
- (GSBabyPeripheralManager *(^)(void)) bePeripheral;
- (GSBabyPeripheralManager *(^)(NSString *localName)) bePeripheralWithName;

@property (nonatomic, readonly) CBPeripheralManager *peripheralManager;

//  peripheral model block

/**
 PeripheralManager did update state block
 */
- (void)peripheralModelBlockOnPeripheralManagerDidUpdateState:(void(^)(CBPeripheralManager *peripheral))block;
/**
 PeripheralManager did add service block
 */
- (void)peripheralModelBlockOnDidAddService:(void(^)(CBPeripheralManager *peripheral,CBService *service,NSError *error))block;
/**
 PeripheralManager did start advertising block
 */
- (void)peripheralModelBlockOnDidStartAdvertising:(void(^)(CBPeripheralManager *peripheral,NSError *error))block;
/**
 peripheralManager did receive read request block
 */
- (void)peripheralModelBlockOnDidReceiveReadRequest:(void(^)(CBPeripheralManager *peripheral,CBATTRequest *request))block;
/**
 peripheralManager did receive write request block
 */
- (void)peripheralModelBlockOnDidReceiveWriteRequests:(void(^)(CBPeripheralManager *peripheral,NSArray *requests))block;
/**
 peripheralManager did subscribe to characteristic block
 */
- (void)peripheralModelBlockOnDidSubscribeToCharacteristic:(void(^)(CBPeripheralManager *peripheral,CBCentral *central,CBCharacteristic *characteristic))block;
/**
peripheralManager did subscribe to characteristic block
*/
- (void)peripheralModelBlockOnDidUnSubscribeToCharacteristic:(void(^)(CBPeripheralManager *peripheral,CBCentral *central,CBCharacteristic *characteristic))block;

@end
