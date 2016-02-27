# WAKeychain

[![Version](https://img.shields.io/cocoapods/v/WAKeychain.svg?style=flat)](http://cocoapods.org/pods/WAKeychain)
[![License](https://img.shields.io/cocoapods/l/WAKeychain.svg?style=flat)](http://cocoapods.org/pods/WAKeychain)
[![Platform](https://img.shields.io/cocoapods/p/WAKeychain.svg?style=flat)](http://cocoapods.org/pods/WAKeychain)

**Developed and Maintained by [ipodishima](https://github.com/ipodishima) Founder & CTO at [Wasappli Inc](http://wasapp.li).**

This class is a wrapper on top of [`SSKeychain`](https://github.com/soffes/sskeychain) which is already a wrapper for Apple Keychain.
This wrapper has been built to avoid requesting the keychain too frequently. I ran into issues with debugging and accessing the keychain very often, then I wrote this little piece of code.

 - It keeps the password on RAM
 - It can save it on `NSUserDefaults` not securely if needed. For example, a user password could not be save not securely, but an access token would
 
## Install and use
### Cocoapods
Use Cocoapods, this is the easiest way to install it.

`pod 'WAKeychain'`

`#import <WAKeychain/WAKeychain.h>` 

### Use any of the following method

`+ (NSString *)passwordForService:(NSString *)serviceName account:(NSString *)account;`

`+ (BOOL)setPassword:(NSString *)password forService:(NSString *)serviceName account:(NSString *)account;`

`+ (BOOL)setPassword:(NSString *)password forService:(NSString *)serviceName account:(NSString *)account canSaveNotSecurely:(BOOL)canSaveNotSecurely;`

`+ (BOOL)deletePasswordForService:(NSString *)serviceName account:(NSString *)account;`

#Contributing : Problems, Suggestions, Pull Requests?

Please open a new Issue [here](https://github.com/Wasappli/WAKeychain/issues) if you run into a problem specific to WAKeychain.

For new features pull requests are encouraged and greatly appreciated! Please try to maintain consistency with the existing code style. If you're considering taking on significant changes or additions to the project, please ask me before by opening a new issue to have a chance for a merge.
Please also run the tests before ;)

#That's all folks !

- If your are happy don't hesitate to send me a tweet [@ipodishima](http://twitter.com/ipodishima)!
- Distributed under MIT licence.
- Follow Wasappli on [facebook](https://www.facebook.com/wasappli)