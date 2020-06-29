//
//  GSBabyToy.h
//  GSNICE
//
//  Created by Gavin on 2020/6/12.
//  Copyright © 2020 GSNICE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

@interface GSBabyToy : NSObject

/// 十六进制转换为普通字符串
/// @param hexString 十六进制字符串
+ (NSString *)ConvertHexStringToString:(NSString *)hexString;

/// 普通字符串转换为十六进制
/// @param string 普通字符串
+ (NSString *)ConvertStringToHexString:(NSString *)string;

/// int 转 data
/// @param i int
+ (NSData *)ConvertIntToData:(int)i;

/// data 转 int
/// @param data data
+ (int)ConvertDataToInt:(NSData *)data;

/// 十六进制转换为普通字符串的
/// @param hexString 十六进制字符串
+ (NSData *)ConvertHexStringToData:(NSString *)hexString;

/// 根据 UUIDString 查找 CBCharacteristic
/// @param services 服务数组
/// @param UUIDString UUID
+ (CBCharacteristic *)findCharacteristicFormServices:(NSMutableArray *)services
                                         UUIDString:(NSString *)UUIDString;
@end
