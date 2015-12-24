//
//  ViewController.m
//  TestSimple
//
//  Created by Ray on 2015/12/23.
//  Copyright © 2015年 Ray. All rights reserved.
//

#import "ViewController.h"
#import "MultiInOneExecutor.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self testAsyncSubmitTadk];
    //    [self testSyncSubmitTadk];
    //    [self testHttpRequestGCD];//not work
    //    [self testHttpRequestMultiInOne];//work success
    [self testTimerGCD];//not work
    [self testTimer];//work success, NSTimer on background thread
}

-(void)testAsyncSubmitTadk{
    NSLog(@"testAsyncSubmitTadk,begin");
    for(int i = 0; i < 10; i++){
        [[MultiInOneExecutor sharedinstance] submitAsync:^{
            sleep(1);
            NSLog(@"%d", i);
        }];
    }
    NSLog(@"testAsyncSubmitTadk,end");
}

-(void)testSyncSubmitTadk{
    NSLog(@"testSyncSubmitTadk,begin");
    for(int i = 0; i < 10; i++){
        [[MultiInOneExecutor sharedinstance] submitSync:^{
            sleep(1);
            NSLog(@"%d", i);
        }];
    }
    NSLog(@"testSyncSubmitTadk,end");
}

-(void)testHttpRequestGCD{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //not work
        [self requestApple];
    });
}

-(void)testHttpRequestMultiInOne{
    [[MultiInOneExecutor sharedinstance] submitSync:^{
        //work success
        [self requestApple];
    }];
}

-(void)testTimerGCD{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerInterval) userInfo:nil repeats:YES];
    });
}

-(void)testTimer{
    [[MultiInOneExecutor sharedinstance] submitAsync:^{
        [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerInterval) userInfo:nil repeats:YES];
    }];
}

-(void)timerInterval{
    NSLog(@"timerInterval,currentThread=>%@",[NSThread currentThread]);
}

-(void)requestApple{
    NSLog(@"requestGoogle, current=>%@",[NSThread currentThread]);
    NSString *urlAsString = @"http://www.apple.com";
    NSURL *url = [NSURL URLWithString:urlAsString];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest new];
    [urlRequest setTimeoutInterval:30.0f];
    [urlRequest setURL:url];
    
    NSURLConnection *con = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:self startImmediately:YES];
    
    [con start];
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    NSLog(@"connectionDidFinishLoading,%@",connection);
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
