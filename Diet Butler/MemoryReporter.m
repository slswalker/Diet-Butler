//
//  MemoryReporter.m
//  Diet Butler
//
//  Created by Sam Walker on 9/5/15.
//  Copyright © 2015 Samuel Walker. All rights reserved.
//

#import "MemoryReporter.h"
#import <mach/mach.h>

@implementation MemoryReporter

+ (void)reportMemory
{
#if defined(DEBUG)
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"MEMORY Usage: %.3f MB", [MemoryReporter getMemoryUsageInMB]);
    });
    
#endif
}

+ (double)getMemoryUsageInMB
{
    double result = 0;
    struct task_basic_info info;
    mach_msg_type_number_t size = sizeof(info);
    kern_return_t kerr = task_info(mach_task_self(),
                                   TASK_BASIC_INFO,
                                   (task_info_t)&info,
                                   &size);
    if( kerr == KERN_SUCCESS )
    {
        result = info.resident_size/(double)(1024*1024);
        
#if TARGET_IPHONE_SIMULATOR
        result = result / 2.0f;
#endif
    }
    
    return result;
}

@end
