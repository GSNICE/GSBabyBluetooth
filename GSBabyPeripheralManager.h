//
//  GSBabyPeripheralManager.h
//  GSNICE
//
//  Created by Gavin on 2020/6/12.
//  Copyright © 2020 GSNICE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import "GSBabyToy.h"
#import "GSBabySpeaker.h"

@interface GSBabyPeripheralManager : NSObject<CBPeripheralManagerDelegate> {

@public
    // 回叫方法
    GSBabySpeaker *babySpeaker;
}

/**
 添加服务
 */
- (GSBabyPeripheralManager *(^)(NSArray *array))addServices;

/**
启动广播
 */
- (GSBabyPeripheralManager *(^)(void))startAdvertising;

//外设管理器
@property (nonatomic, strong) CBPeripheralManager *peripheralManager;
@property (nonatomic, copy) NSString *localName;
@property (nonatomic, strong) NSMutableArray *services;

@end


/**
 *  构造 Characteristic，并加入 service
 *  service:CBService
 
 *  param`ter for properties ：option 'r' | 'w' | 'n' or combination
 *	r                       CBCharacteristicPropertyRead
 *	w                       CBCharacteristicPropertyWrite
 *	n                       CBCharacteristicPropertyNotify
 *  default value is rw     Read-Write

 *  paramter for descriptor：be uesd descriptor for characteristic
 */

void makeCharacteristicToService(CBMutableService *service,NSString *UUID,NSString *properties,NSString *descriptor);

/**
 *  构造一个包含初始值的Characteristic，并加入service,包含了初值的characteristic必须设置permissions和properties都为只读
 *  make characteristic then add to service, a static characteristic mean it has a initial value .according apple rule, it must set properties and permissions to CBCharacteristicPropertyRead and CBAttributePermissionsReadable
*/
void makeStaticCharacteristicToService(CBMutableService *service,NSString *UUID,NSString *descriptor,NSData *data);
/**
 生成 CBService
 */
CBMutableService* makeCBService(NSString *UUID);

/**
 生成 UUID
 */
NSString* genUUID(void);
