//
//  block1.c
//  test
//
//  Created by wangyang on 16/3/13.
//  Copyright © 2016年 北京更美互动信息科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

struct __block_impl {
    void *isa;
    int Flags;     
    int Reserved;
    void *FuncPtr;
};

struct __main_block_impl_0 {
    struct __block_impl impl;
    struct __main_block_desc_0* Desc;
    __main_block_impl_0(void *fp, struct __main_block_desc_0 *desc, int flags=0) {
        impl.isa = &_NSConcreteGlobalBlock;
        impl.Flags = flags;
        impl.FuncPtr = fp;
        Desc = desc;
    }
};

static void __main_block_func_0(struct __main_block_impl_0 *__cself) {
    printf("callBlock1: Hello, World!\n");
}

static struct __main_block_desc_0 {
    size_t reserved;
    size_t Block_size;
} __main_block_desc_0_DATA = { 0, sizeof(struct __main_block_impl_0) };

int callBlock1()
{
    /*直接翻译为
     (void (*)())&__main_block_impl_0((void *)__main_block_func_0, &__main_block_desc_0_DATA) ();
     */

    struct __main_block_impl_0 blockStruct = __main_block_impl_0((void *)__main_block_func_0, &__main_block_desc_0_DATA);
    void (*block)(void) = ((void (*)()) &blockStruct );
    (  (void(*)(__block_impl *))   ((__block_impl *)block)->FuncPtr  )  ((__block_impl *)block);

    return 0;
}