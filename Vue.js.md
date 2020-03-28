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

## 2.1 