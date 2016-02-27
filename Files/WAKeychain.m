//
//  WAKeychain.m
//  WAKeychain
//
//  Created by Marian Paul on 16-02-27.
//  Copyright © 2016 Wasappli. All rights reserved.
//

#import "WAKeychain.h"
#import <SSKeychain/SSKeychain.h>

static NSMutableDictionary *_passwords = nil;

@implementation WAKeychain

+ (void)initialize {
    [super initialize];
    _passwords = [NSMutableDictionary new];
}

+ (NSString *)passwordOnRAMForService:(NSString *)serviceName account:(NSString *)account {
    NSMutableDictionary *accountDic = _passwords[account];
    if (!accountDic && account) {
        accountDic = [NSMutableDictionary new];
        _passwords[account] = accountDic;
    }
    
    NSString *password = accountDic[serviceName];
    return password;
}

+ (void)setPasswordOnRAM:(NSString *)password forService:(NSString *)serviceName account:(NSString *)account {
    NSMutableDictionary *accountDic = _passwords[account];
    if (!accountDic && account) {
        accountDic = [NSMutableDictionary new];
        _passwords[account] = accountDic;
    }
    
    if (password) {
        accountDic[serviceName] = password;
    }
    else {
        [accountDic removeObjectForKey:serviceName];
    }
}

+ (NSString *)passwordForService:(NSString *)serviceName account:(NSString *)account {
    NSParameterAssert(account);
    // Retrieving password serviceName and account
    // First, retrieve it from RAM
    NSString *password = [self passwordOnRAMForService:serviceName account:account];
    if (!password) {
        // No password in RAM, retrieving it from keychain
        NSError *error = nil;
        password = [SSKeychain passwordForService:serviceName
                                          account:account
                                            error:&error];
        
        if (error) {
            // Got error: try to get from user defaults
            password = [[NSUserDefaults standardUserDefaults] objectForKey:serviceName];
        }
        else {
            // Retrieved password, set on RAM for future access
            [self setPasswordOnRAM:password forService:serviceName account:account];
        }
    }
    else {
        // Got password from RAM
    }
    
    return password;
}

+ (BOOL)setPassword:(NSString *)password forService:(NSString *)serviceName account:(NSString *)account  {
    return [self setPassword:password forService:serviceName account:account canSaveNotSecurely:NO];
}

+ (BOOL)setPassword:(NSString *)password forService:(NSString *)serviceName account:(NSString *)account canSaveNotSecurely:(BOOL)canSaveNotSecurely {
    NSParameterAssert(account);
    
    // Setting password
    BOOL success = NO;
    
    NSString *oldPassword = [self passwordOnRAMForService:serviceName account:account];
    if (![oldPassword isEqualToString:password]) {
        [self setPasswordOnRAM:password forService:serviceName account:account];
        
        NSError *error = nil;
        success = [SSKeychain setPassword:password
                               forService:serviceName
                                  account:account
                                    error:&error];
        
        if (canSaveNotSecurely) {
            [[NSUserDefaults standardUserDefaults] setObject:password forKey:serviceName];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
    }
    else {
        success = YES;
    }
    
    return success;
}

+ (BOOL)deletePasswordForService:(NSString *)serviceName account:(NSString *)account {
    NSParameterAssert(account);
    
    // Deleting password
    [self setPasswordOnRAM:nil forService:serviceName account:account];
    
    NSError *error = nil;
    BOOL success = [SSKeychain deletePasswordForService:serviceName
                                                account:account
                                                  error:&error];
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:serviceName];
    
    return success;
}

@end
