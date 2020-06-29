//
//  GSBabyToy.m
//  GSNICE
//
//  Created by Gavin on 2020/6/12.
//  Copyright © 2020 GSNICE. All rights reserved.
//

#import "GSBabyToy.h"

@implementation GSBabyToy

#pragma mark - 十六进制转换为普通字符串
+ (NSString *)ConvertHexStringToString:(NSString *)hexString {
    char *myBuffer = (char *)malloc((int)[hexString length] / 2 + 1);
    bzero(myBuffer, [hexString length] / 2 + 1);
    for (int i = 0; i < [hexString length] - 1; i += 2) {
        unsigned int anInt;
        NSString * hexCharStr = [hexString substringWithRange:NSMakeRange(i, 2)];
        NSScanner *scanner = [[NSScanner alloc] initWithString:hexCharStr];
        [scanner scanHexInt:&anInt];
        myBuffer[i / 2] = (char)anInt;
    }
    NSString *unicodeString = [NSString stringWithCString:myBuffer encoding:4];
    return unicodeString;
}

#pragma mark - 普通字符串转换为十六进制
+ (NSString *)ConvertStringToHexString:(NSString *)string {
    NSData *myD = [string dataUsingEncoding:NSUTF8StringEncoding];
    Byte *bytes = (Byte *)[myD bytes];
    //  下面是 Byte 转换为 16 进制。
    NSString *hexStr = @"";
    for (int i = 0;i < [myD length];i++) {
        NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i]&0xff];///16进制数
        
        if ([newHexStr length] == 1) {
           hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
        }
        else{
            hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr];
        }
    } 
    return hexStr; 
}

#pragma mark - int 转 data
+ (NSData *)ConvertIntToData:(int)i {
    NSData *data = [NSData dataWithBytes:&i length: sizeof(i)];
    return data;
}

#pragma mark - data 转 int
+ (int)ConvertDataToInt:(NSData *)data {
    int i;
    [data getBytes:&i length:sizeof(i)];
    return i;
}

#pragma mark - 十六进制转换为普通字符串的
+ (NSData *)ConvertHexStringToData:(NSString *)hexString {
    NSData *data = [[GSBabyToy ConvertHexStringToString:hexString] dataUsingEncoding:NSUTF8StringEncoding];
    return data;
}

#pragma mark - 根据 UUIDString 查找 CBCharacteristic
+ (CBCharacteristic *)findCharacteristicFormServices:(NSMutableArray <CBService *>*)services
                                         UUIDString:(NSString *)UUIDString {
    for (CBService *s in services) {
        for (CBCharacteristic *c in s.characteristics) {
            if ([c.UUID.UUIDString isEqualToString:UUIDString]) {
                return c;
            }
        }
    }
    return nil;
}

@end


