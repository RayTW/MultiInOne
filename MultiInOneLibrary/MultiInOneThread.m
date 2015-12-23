//
//  BackgroundThread.m
//
//  Created by Ray on 2015/12/23.
//  Copyright © 2015年 Ray. All rights reserved.
//

#import "MultiInOneThread.h"

@implementation MultiInOneThread{
    NSThread *mThread;
}

-(void)main{
    NSRunLoop *runloop = [NSRunLoop currentRunLoop];
    [runloop addPort:[NSMachPort port] forMode:NSDefaultRunLoopMode];
    
    while (![self isCancelled]) {
        [runloop runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    }
}
@end
