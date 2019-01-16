//
//  ZYNetWorkManager.h
//  rac
//
//  Created by Mr.Z on 2019/1/14.
//  Copyright © 2019 lonch. All rights reserved.
//

#import <Foundation/Foundation.h>
#define NetworkCanBeUsedNotification @"NetworkCanBeUsedNotification" //网络可用通知
#define NetworkCanNotUsedNotification @"NetworkCanNotUsedNotification" //网络不可用通知

@interface ZYNetWorkManager : NSObject
+(void)netWorkManager;

@end

