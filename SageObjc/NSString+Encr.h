//
//  NSString+Encr.h
//  SageObjc
//
//  Created by EGReddy on 24/03/17.
//  Copyright © 2017 EGReddy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSData+Encryption.h"

@interface NSString (Encr)

- (NSString *)AES256EncryptWithKey:(NSString *)key;
- (NSString *)AES256DecryptWithKey:(NSString *)key;

@end
