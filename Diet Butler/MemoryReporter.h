//
//  MemoryReporter.h
//  Diet Butler
//
//  Created by Sam Walker on 9/5/15.
//  Copyright © 2015 Samuel Walker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MemoryReporter : NSObject

+ (void)reportMemory;
+ (double)getMemoryUsageInMB;
@end
