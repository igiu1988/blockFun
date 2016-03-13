//
//  block.cpp
//  test
//
//  Created by wangyang on 16/3/13.
//  Copyright © 2016年 北京更美互动信息科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

struct __block_impl {
    void *isa;
    int Flags;      // see more on http://clang.llvm.org/docs/Block-ABI-Apple.html
    int Reserved;
    void *FuncPtr;
};

struct __Block_byref_i_0 {
    void *__isa;
    struct __Block_byref_i_0 *__forwarding;
    int __flags;    //refcount, see more on http://www.idryman.org/blog/2012/09/29/c-objc-block-byref-internals/
    int __size;
    int i;
};

struct __main_block_impl_0 {
    struct __block_impl impl;
    struct __main_block_desc_0* Desc;

    // 这是C++ 的数据结构初始化，i(_i->__forwarding)意思就是 i = _i->__forwarding
    __main_block_impl_0(void *fp, struct __main_block_desc_0 *desc, struct __Block_byref_i_0 *_i, int flags=0) : i(_i->__forwarding)  {
        impl.isa = &_NSConcreteStackBlock;
        impl.Flags = flags;
        impl.FuncPtr = fp;
        Desc = desc;
    };

    struct __Block_byref_i_0 *i; // by ref
};

static void __main_block_func_0(struct __main_block_impl_0 *__cself) {
    struct __Block_byref_i_0 *i = __cself->i; // bound by ref

    printf("callBlock3: %d\n", (i->__forwarding->i));
    (i->__forwarding->i) = 1023;
}

static void __main_block_copy_0(struct __main_block_impl_0*dst, struct __main_block_impl_0*src) {_Block_object_assign((void*)&dst->i, (void*)src->i, 8/*BLOCK_FIELD_IS_BYREF*/);}

static void __main_block_dispose_0(struct __main_block_impl_0*src) {_Block_object_dispose((void*)src->i, 8/*BLOCK_FIELD_IS_BYREF*/);}

static struct __main_block_desc_0 {
    size_t reserved;
    size_t Block_size;
    void (*copy)(struct __main_block_impl_0*, struct __main_block_impl_0*);
    void (*dispose)(struct __main_block_impl_0*);
} __main_block_desc_0_DATA = { 0, sizeof(struct __main_block_impl_0), __main_block_copy_0, __main_block_dispose_0};


int callBlock3()
{
    // 原代码
//    __block int i = 1024;
//    void (^block1)(void) = ^{
//        printf("callBlock3: %d\n", i);
//        i = 1023;
//    };
//    block1();

    /* 翻译 __block int i = 1024;
     也可以这么写
     struct _block_byref_i {
         void *isa;
         struct _block_byref_i *forwarding;
         int flags;
         int size;
         int i;
     } i = { NULL, &i, 0, sizeof(struct _block_byref_i), 1024 };
     */

    __attribute__((__blocks__(byref))) __Block_byref_i_0 i = {(void*)0,(__Block_byref_i_0 *)&i, 0, sizeof(__Block_byref_i_0), 1024};


    /*
     翻译
     void (^block1)(void) = ^{
         printf("%d\n", i);
         i = 1023;
     };

     直接翻译为如下，但是我发现在Xcode里显示有问题，上网查了一下，的确有人遇到类似问题，于是换了一种写法.http://stackoverflow.com/questions/2280688/taking-the-address-of-a-temporary-object
     void (*block1)(void) = ((void (*)() &   __main_block_impl_0((void *)__main_block_func_0, &__main_block_desc_0_DATA, (__Block_byref_i_0 *)&i, 570425344));

     • block1 是 __main_block_impl_0 的指针
     */


    struct __main_block_impl_0 blockStruct = __main_block_impl_0((void *)__main_block_func_0, &__main_block_desc_0_DATA, (__Block_byref_i_0 *)&i, 570425344);
    void (*block1)(void) = ((void (*)()) &blockStruct );

    /* 以下写法都是正确的
    void *funcPtr1 = blockStruct.impl.FuncPtr;
    void *funcPtr2 = ((__main_block_impl_0 *)block1)->impl.FuncPtr;
    void *funcPtr3 = ((__block_impl *)block1)->FuncPtr;
     */


    /* 翻译 block1();
     
     首先肯定：指针 (__block_impl *) 和指针（__main_block_impl_0 *）所指向的内存是一样的，所以
     • 取 FuncPtr 的方式也没有错
     • 参数类型没有错

     */

    // __main_block_impl_0->__block_impl->(void *)FuncPtr(struct __main_block_impl_0)

    //  想要调用的方法类型及参数     | 这部分取出一个__block_impl-> 方法名  |   参数
    ( (void(*)(__block_impl *))  ((__block_impl *)block1)->FuncPtr )  ((__block_impl *)block1);




    return 0;
}
