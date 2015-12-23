//
//  BackgroundNetWork.h
//  此類別可取得在background 執行的thread來網路、讀寫db等操作，特性為FIFO
//  可將多執行緒轉為單一執行緒處理
//
//  Created by Ray on 2015/12/23.
//  Copyright © 2015年 Ray. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MultiInOneExecutor : NSObject

+(MultiInOneExecutor *) sharedinstance;
-(void)submitAsync:(void (^)(void))task;
-(void)submitSync:(void (^)(void))task;
@end
