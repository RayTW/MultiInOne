//
//  BackgroundNetWork.m
//  TestSimple
//
//  Created by Ray on 2015/12/23.
//  Copyright © 2015年 Ray. All rights reserved.
//

#import "BackgroundExecutor.h"

static BackgroundExecutor *instance;

@implementation BackgroundExecutor{
    NSThread *mThread;
}

+(BackgroundExecutor *) sharedinstance{
    if(instance == nil){
        @synchronized([BackgroundExecutor class]) {
            if(instance == nil){
                instance = [BackgroundExecutor new];
            }
        }
    }
    
    return instance;
}

-(instancetype)init{
    if(self = [super init]){
        mThread = [[NSThread alloc]initWithTarget:self selector:@selector(doBackgroundTask) object:nil];
        [mThread start];
    }
    
    return self;
}

-(void)doBackgroundTask{
    //NSLog(@"initBlocker 1");
    // [[EzTalkDb sharedObj] attatchThread];
    NSRunLoop *runloop = [NSRunLoop currentRunLoop];
    [runloop addPort:[NSMachPort port] forMode:NSDefaultRunLoopMode];
    
    while (YES) { // 'isAlive' is a variable that is used to control the thread existence...
        [runloop runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    }
}

-(void)submitAsync:(void (^)(void))task{
    if(task){
        [self performSelector:@selector(doSubmitTask:) onThread:mThread withObject:[task copy] waitUntilDone:NO];
    }
}

-(void)submitSync:(void (^)(void))task{
    if(task){
        [self performSelector:@selector(doSubmitTask:) onThread:mThread withObject:task waitUntilDone:YES];
    }
}

-(void)doSubmitTask:(void (^)(void))task{
    task();
}

@end
