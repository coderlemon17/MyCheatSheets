[#](#) KOA学习草稿

## [入门指南](https://chenshenhai.github.io/koa2-note/)

- 源代码

  - ```
    ├── lib
    │   ├── application.js
    │   ├── context.js
    │   ├── request.js
    │   └── response.js
    └── package.json
    ```

    这个就是 `GitHub` [https://github.com/koajs/koa](https://github.com/koajs/koa/)上开源的koa2源码的源文件结构，核心代码就是lib目录下的四个文件

    - application.js 是整个koa2 的入口文件，封装了context，request，response，以及最核心的中间件处理流程。
    - context.js 处理应用上下文，里面直接封装部分request.js和response.js的方法
    - request.js 处理http请求
    - response.js 处理http响应



- 
