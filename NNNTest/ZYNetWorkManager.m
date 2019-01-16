//
//  ZYNetWorkManager.m
//  rac
//
//  Created by Mr.Z on 2019/1/14.
//  Copyright © 2019 lonch. All rights reserved.
//

#import "ZYNetWorkManager.h"
#import "SimplePing.h"

static ZYNetWorkManager *share = nil;
@interface ZYNetWorkManager () <SimplePingDelegate>
@property (nonatomic, strong)SimplePing *pinger;
@property (nonatomic, assign)BOOL keyi;
@end

@implementation ZYNetWorkManager
+ (void)netWorkManager {
    share = [[ZYNetWorkManager alloc] init];
}
-(instancetype)init {
    self = [super init];
    if (self) {
        _keyi = YES;
        NSString *host = @"https://www.baidu.com";
        SimplePing *pinger = [[SimplePing alloc] initWithHostName:host];
        pinger.delegate = self;
        pinger.addressStyle = SimplePingAddressStyleAny;
        self.pinger = pinger;
        [self.pinger start];
    }
    return self;
}


#pragma mark --------SimplePingDelegate--------
/**
 *  start成功，也就是准备工作做完后的回调
 */
- (void)simplePing:(SimplePing *)pinger didStartWithAddress:(NSData *)address
{
    // 发送测试报文数据
    [self.pinger sendPingWithData:nil];
    if (!_keyi) {
       [[NSNotificationCenter defaultCenter] postNotificationName:NetworkCanBeUsedNotification object:nil];
        _keyi = YES;
        [self.pinger stop];
    }
}

- (void)simplePing:(SimplePing *)pinger didFailWithError:(NSError *)error {
    [self.pinger stop];
    if (_keyi) {
        _keyi = NO;
        [[NSNotificationCenter defaultCenter] postNotificationName:NetworkCanNotUsedNotification object:nil];
    }
    
}

// 发送测试报文成功的回调方法
- (void)simplePing:(SimplePing *)pinger didSendPacket:(NSData *)packet sequenceNumber:(uint16_t)sequenceNumber
{
    NSLog(@"#%u sent", sequenceNumber);
}

//发送测试报文失败的回调方法
- (void)simplePing:(SimplePing *)pinger didFailToSendPacket:(NSData *)packet sequenceNumber:(uint16_t)sequenceNumber error:(NSError *)error
{
    NSLog(@"#%u send failed: %@", sequenceNumber, error);
}

// 接收到ping的地址所返回的数据报文回调方法
- (void)simplePing:(SimplePing *)pinger didReceivePingResponsePacket:(NSData *)packet sequenceNumber:(uint16_t)sequenceNumber
{
    NSLog(@"#%u received, size=%zu", sequenceNumber, packet.length);
}

- (void)simplePing:(SimplePing *)pinger didReceiveUnexpectedPacket:(NSData *)packet
{
    NSLog(@"#%s",__func__);
}

@end
