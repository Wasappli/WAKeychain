//
//  WAKeychain.h
//  WAKeychain
//
//  Created by Marian Paul on 16-02-27.
//  Copyright © 2016 Wasappli. All rights reserved.
//

@import Foundation;

/**
 *  This class is a wrapper on top of SSKeychain which is already a wrapper for Apple Keychain.
 *  This wrapper has been built to avoid requesting the keychain too frequently.
 *   - It keeps the password on RAM
 *   - It can save it on NSUserDefaults not securely if needed. For example, a user password could not be save not securely, but an access token would
 */
@interface WAKeychain : NSObject

/**
 *  Get the password for a service name
 *
 *  @param serviceName the service name. For example `app_identifier.user.password`
 *  @param account     the account. For example `user@email.com`
 *
 *  @return the password associated and stored in the keychain
 */
+ (NSString *)passwordForService:(NSString *)serviceName account:(NSString *)account;

/**
 *  Save a password securely
 *
 *  @param password    the password to save
 *  @param serviceName the service name. For example `app_identifier.user.password`
 *  @param account     the account. For example `user@email.com`
 *
 *  @return a boolean value. `YES` if save succeeded, `NO` otherwise.
 */
+ (BOOL)setPassword:(NSString *)password forService:(NSString *)serviceName account:(NSString *)account;

/**
 *  Save a password securely
 *
 *  @param password           the password to save
 *  @param serviceName        the service name. For example `app_identifier.user.password`
 *  @param account            the account. For example `user@email.com`
 *  @param canSaveNotSecurely `YES` if you can save it on user defaults
 
 *  @return a boolean value. `YES` if save succeeded, `NO` otherwise.
 */
+ (BOOL)setPassword:(NSString *)password forService:(NSString *)serviceName account:(NSString *)account canSaveNotSecurely:(BOOL)canSaveNotSecurely;

/**
 *  Delete the password for a service
 *
 *  @param serviceName the service name. For example `app_identifier.user.password`
 *  @param account     the account. For example `user@email.com`
 *
 *  @return a boolean value. `YES` if save succeeded, `NO` otherwise.
 */
+ (BOOL)deletePasswordForService:(NSString *)serviceName account:(NSString *)account;

@end

