//
//  BackgroundNetWork.m
//  TestSimple
//
//  Created by Ray on 2015/12/23.
//  Copyright © 2015年 Ray. All rights reserved.
//

#import "MultiInOneExecutor.h"
#import "MultiInOneThread.h"

static MultiInOneExecutor *instance;

@implementation MultiInOneExecutor{
    MultiInOneThread *mDefaultGlobalThread;
}

+(instancetype) sharedinstance{
    if(instance == nil){
        @synchronized([MultiInOneExecutor class]) {
            if(instance == nil){
                instance = [MultiInOneExecutor new];
            }
        }
    }
    
    return instance;
}

-(instancetype)init{
    if(self = [super init]){
        mDefaultGlobalThread = [[MultiInOneThread alloc]init];
        [mDefaultGlobalThread start];
    }
    
    return self;
}

-(void)submitAsync:(void (^)(void))task{
    if(task){
        [self performSelector:@selector(doSubmitTask:) onThread:mDefaultGlobalThread withObject:[task copy] waitUntilDone:NO];
    }
}

-(void)submitSync:(void (^)(void))task{
    if(task){
        [self performSelector:@selector(doSubmitTask:) onThread:mDefaultGlobalThread withObject:task waitUntilDone:YES];
    }
}

-(void)doSubmitTask:(void (^)(void))task{
    task();
}

@end


