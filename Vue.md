- 文本绑定

- v-bind:指令

- v-on:事件监听器

  - ```
    <div id="app-5">
      <p>{{ message }}</p>
      <button v-on:click="reverseMessage">反转消息</button>
    </div>
    var app5 = new Vue({
      el: '#app-5',
      data: {
        message: 'Hello Vue.js!'
      },
      methods: {
        reverseMessage: function () {
          this.message = this.message.split('').reverse().join('')
        }
      }
    })
    ```

- 所有的 DOM 操作都由 Vue 来处理，你编写的代码只需要关注逻辑层面即可。

# 组件化引用构建

- 在 Vue 里，一个组件本质上是一个拥有预定义选项的一个 Vue 实例。
- 在一个大型应用中，有必要将整个应用程序划分为组件，以使开发更易管理。

# 1.Vue实例

## 1.1 创建一个Vue实例

- 一个 Vue 应用由一个通过 `new Vue` 创建的**根 Vue 实例**，以及可选的嵌套的、可复用的组件树组成。

  - 当创建一个 Vue 实例时，你可以传入一个**选项对象**。

  - ```
    根实例
    └─ TodoList
       ├─ TodoItem
       │  ├─ DeleteTodoButton
       │  └─ EditTodoButton
       └─ TodoListFooter
          ├─ ClearTodosButton
          └─ TodoListStatistics
    ```

## 1.2 数据与方法

- 当一个 Vue 实例被创建时，它将 `data` 对象中的**所有的属性**加入到 Vue 的**响应式系统**中。当这些属性的值发生改变时，视图将会产生“响应”，即匹配更新为新的值。

- 得注意的是只有**当实例被创建时就已经存在于 `data` 中的属性**才是**响应式**的。

- 这里唯一的例外是使用 `Object.freeze()`，这会阻止修改现有的属性，也意味着响应系统无法再*追踪*变化。

  - ```html
    var obj = {
      foo: 'bar'
    }
    
    Object.freeze(obj)
    
    new Vue({
      el: '#app',
      data: obj
    })
    <div id="app">
      <p>{{ foo }}</p>
      <!-- 这里的 `foo` 不会更新！ -->
      <button v-on:click="foo = 'baz'">Change it</button>
    </div>
    ```

- Vue 实例还暴露了一些有用的实例属性与方法。它们都有前缀 `$`，以便与用户定义的属性区分开来。

    - ```vue
        // $watch 是一个实例方法
        vm.$watch('a', function (newValue, oldValue) {
          // 这个回调将在 `vm.a` 改变后调用
        })
        ```

        

## 1.3 实例生命周期钩子

- 每个 Vue 实例在被创建时都要经过一系列的初始化过程，同时在这个过程中也会运行一些叫做**生命周期钩子**的函数，如 [`mounted`](https://cn.vuejs.org/v2/api/#mounted)、[`updated`](https://cn.vuejs.org/v2/api/#updated) 和 [`destroyed`](https://cn.vuejs.org/v2/api/#destroyed)。

  - ```
    new Vue({
      data: {
        a: 1
      },
      created: function () {
        // `this` 指向 vm 实例
        console.log('a is: ' + this.a)
      }
    })
    // => "a is: 1"
    ```

    :warning:

  - ```javascript
    不要在选项属性或回调上使用箭头函数
    
    比如 created: () => console.log(this.a) 
    	或 vm.$watch('a', newValue => this.myMethod())
    
    因为**箭头函数并没有** this，this 会作为变量一直向上级词法作用域查找，直至找到为止，经常导致 Uncaught TypeError: Cannot read property of undefined 或 Uncaught TypeError: this.myMethod is not a function 之类的错误。
    ```

## 1.4 生命周期图示

- ![Vue 实例生命周期](https://cn.vuejs.org/images/lifecycle.png)

# 2. 模板语法

## 2.1 插值

在底层的实现上，Vue 将模板编译成虚拟 DOM 渲染函数。结合响应系统，Vue 能够智能地计算出最少需要重新渲染多少组件，并把 DOM 操作次数减到最少。

- 文本

    - ```
        <span>Message: {{ msg }}</span>
        <span v-once>这个将不会改变: {{ msg }}</span> 
        //通过使用 v-once 指令，你也能执行一次性地插值，当数据改变时，插值处的内容不会更新。但请留心这会影响到该节点上的其它数据绑定
        ```

- 原始HTML：

    - ```
        <p>Using v-html directive: <span v-html="rawHtml"></span></p>
        //这个 span 的内容将会被替换成为属性值 rawHtml，直接作为 HTML——会忽略解析属性值中的数据绑定。
        //你的站点上动态渲染的任意 HTML 可能会非常危险，因为它很容易导致 XSS 攻击。请只对可信内容使用 HTML 插值，绝不要对用户提供的内容使用插值。
        ```

- Attribute

    - Mustache 语法不能作用在 HTML attribute 上，遇到这种情况应该使用 [`v-bind` 指令](https://cn.vuejs.org/v2/api/#v-bind)：

        ```
        <div v-bind:id="dynamicId"></div>
        ```

- 使用JS表达式

    - ```
        {{ ok ? 'YES' : 'NO' }}
        <div v-bind:id="'list-' + id"></div>
        ```

    - 有个限制就是，每个绑定都只能包含**单个表达式**

    - 模板表达式只能访问[全局变量的一个白名单](https://github.com/vuejs/vue/blob/v2.6.10/src/core/instance/proxy.js#L9)，如 `Math` 和 `Date` 。你不应该在模板表达式中试图访问用户定义的全局变量。

## 2.2 指令

- 指令的职责是，当表达式的值改变时，将其产生的连带影响，响应式地作用于 DOM

- 参数：

    - 一些指令能够接收一个“参数”，在指令名称之后以冒号表示。

    - ```
        <a v-bind:href="url">...</a>
        //在这里 href 是参数
        ```

- 动态参数：

    - 以用方括号括起来的 JavaScript 表达式作为一个指令的参数

    - ```
        <!--
        注意，参数表达式的写法存在一些约束，如之后的“对动态参数表达式的约束”章节所述。
        -->
        <a v-bind:[attributeName]="url"> ... </a>
        //这里的 attributeName 会被作为一个 JavaScript 表达式进行动态求值，求得的值将会作为最终的参数来使用。例如，如果你的 Vue 实例有一个 data 属性 attributeName，其值为 "href"，那么这个绑定将等价于 v-bind:href。
        ```

    - 约束：

        - 动态参数表达式有一些语法约束，因为某些字符，**如空格和引号**，放在 HTML attribute 名里是无效的。
        - 在 DOM 中使用模板时 (直接在一个 HTML 文件里撰写模板)，还需要**避免使用大写字符来命名键名**，因为浏览器会把 attribute 名全部强制转为小写。

- 修饰符：

    - 修饰符 (modifier) 是以半角句号 `.` 指明的特殊后缀，用于指出一个指令应该以特殊方式绑定。

    - ```
        <form v-on:submit.prevent="onSubmit">...</form>
        // .prevent 修饰符告诉 v-on 指令对于触发的事件调用 event.preventDefault()
        ```

## 2.3 缩写

- `v-bind` 缩写

    ```
    <!-- 完整语法 -->
    <a v-bind:href="url">...</a>
    
    <!-- 缩写 -->
    <a :href="url">...</a>
    
    <!-- 动态参数的缩写 (2.6.0+) -->
    <a :[key]="url"> ... </a>
    ```

- `v-on` 缩写

    ```
    <!-- 完整语法 -->
    <a v-on:click="doSomething">...</a>
    
    <!-- 缩写 -->
    <a @click="doSomething">...</a>
    
    <!-- 动态参数的缩写 (2.6.0+) -->
    <a @[event]="doSomething"> ... </a>
    ```

# 3. 计算属性和侦听器

