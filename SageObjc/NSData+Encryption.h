//
//  NSData+Encryption.h
//  SageObjc
//
//  Created by EGReddy on 24/03/17.
//  Copyright © 2017 EGReddy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (Encryption)

- (NSData *)AES256EncryptWithKey:(NSString *)key;
- (NSData *)AES256DecryptWithKey:(NSString *)key;
+ (NSData *)base64DataFromString: (NSString *)string;

+ (NSData *)dataWithBase64EncodedString:(NSString *)string;
- (id)initWithBase64EncodedString:(NSString *)string;

- (NSString *)base64Encoding;
- (NSString *)base64EncodingWithLineLength:(NSUInteger)lineLength;

- (BOOL)hasPrefixBytes:(const void *)prefix length:(NSUInteger)length;
- (BOOL)hasSuffixBytes:(const void *)suffix length:(NSUInteger)length;
//- (NSData *)AES256EncryptWithKey:(NSString *)key;
//- (NSData *)AES256DecryptWithKey:(NSString *)key;

@end
