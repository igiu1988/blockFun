# blockFun

看了block的实现？这个还是能运行的呢~！

###驱动力：我为什么想看一下Block的实现
无参数的block对应的NSMethodSiguature有一个参数，而这个参数是什么呢？我没有搞懂。。。这决定让我去看看实现

###学习了 Block 的实现，我们能知道什么？

- 知道了 block 是怎么捕获外部变量的
- 复习一下C++下的结构体（将大结构体拆分成几个小结构体，这两种写法在内存上没有任何变化；结构体的初始化方法）
- 理解一下编译器读代码与人读代码的感觉是不一样的：每一步的类型确认
- clang -rewrite-objc block.c

###看完这些代码，你的感觉是？？？
我的代码世界观都要变了

###所以，最一开始驱动我的问题的结果是？
- 猜测：应该是block结构体实例的地址。
- 验证：继续debug Aspect，看能否找到这个参数的地址，把这个地址与block实例的地址相比较，看能验证
- 结论：(待补充)

###画一个图，需要吗？
照这个重画一个，把isa,flag, reserved, invoke抽取出来，就像我们代码里一样
（待补充）

###Block的小问题
http://blog.parse.com/learn/engineering/objective-c-blocks-quiz/

###这几个小问题与以上研究的内容有什么关系
