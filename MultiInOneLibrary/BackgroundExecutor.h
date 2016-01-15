//
//  BackgroundNetWork.h
//  此類別可取得在background 執行的thread來網路、讀寫db等操作，特性為FIFO
//
//  Created by Ray on 2015/12/23.
//  Copyright © 2015年 Ray. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BackgroundExecutor : NSObject

+(BackgroundExecutor *) sharedinstance;

-(void)submitAsync:(void (^)(void))task;
-(void)submitSync:(void (^)(void))task;
@end
