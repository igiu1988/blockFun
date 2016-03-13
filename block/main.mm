//
//  main.m
//  block
//
//  Created by wangyang on 16/3/13.
//  Copyright © 2016年 北京更美互动信息科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "block1.h"
#include "block3.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        callBlock1();
        callBlock3();
        getchar();
    }
    return 0;
}
