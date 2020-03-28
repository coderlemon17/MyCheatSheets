# EE快速入门

## JS代码使用方式：

- 直接使用

  ```
  <script>
  	alert('Hello, world');
  </script>
  ```

- 插入文件：`/static/js/abc.js`就会被浏览器执行

  ```
  <head>
    <script src="/static/js/abc.js"></script>
  </head>
  ```

## 数据类型：

#### 比较运算符

- 要特别注意相等运算符`==`。JavaScript在设计时，有两种比较运算符：

- 第一种是`==`比较，它会自动转换数据类型再比较，很多时候，会得到非常诡异的结果；
- 第二种是`===`比较，它不会自动转换数据类型，如果数据类型不一致，返回`false`，如果一致，再比较。
- 由于JavaScript这个设计缺陷，*不要*使用`==`比较，始终坚持使用`===`比较。

- 另一个例外是`NaN`这个特殊的Number与所有其他值都不相等，包括它自己：
      ```
  NaN === NaN; // false
      ```
  
- 唯一能判断`NaN`的方法是通过`isNaN()`函数：
      ```
  isNaN(NaN); // true
      ```

#### 对象：（键-值组成的无序集合）

- ```
  var person = {
      name: 'Bob',
      age: 20,
      tags: ['js', 'web', 'mobile'],
      city: 'Beijing',
      hasCar: true,
      zipcode: null
  };
  ```

#### JavaScript是动态语言：

- ```
  var a = 123; // a的值是整数123
  a = 'ABC'; // a变为字符串
  ```

#### strict模式

- JavaScript在设计之初，为了方便初学者学习，并不强制要求用`var`申明变量。这个设计错误带来了严重的后果：**如果一个变量没有通过`var`申明就被使用，那么该变量就自动被申明为全局变量**：

  ```
  i = 10; // i现在是全局变量
  ```

- 在同一个页面的不同的JavaScript文件中，如果都不用`var`申明，恰好都使用了变量`i`，将造成变量`i`互相影响，产生难以调试的错误结果。

- 使用`var`申明的变量则不是全局变量，它的范围被限制在该变量被申明的函数体内（函数的概念将稍后讲解），同名变量在不同的函数体内互不冲突。

- 为了修补JavaScript这一严重设计缺陷，ECMA在后续规范中推出了**strict**模式，在strict模式下运行的JavaScript代码，强制通过`var`申明变量，未使用`var`申明变量就使用的，将导致运行错误。

  启用strict模式的方法是在JavaScript代码的第一行写上：

  ```
  'use strict';
  ```

  这是一个字符串，不支持strict模式的浏览器会把它当做一个字符串语句执行，支持strict模式的浏览器将开启strict模式运行JavaScript。

#### 多行字符串

- 由于多行字符串用`\n`写起来比较费事，所以最新的ES6标准新增了一种多行字符串的表示方法，用反引号 `` 表示：

  ```
  `这是一个
  多行
  字符串`;
  ```

#### 数组：

- *请注意*，如果通过索引赋值时，索引超过了范围，同样会引起`Array`大小的变化：

  ```
  var arr = [1, 2, 3];
  arr[5] = 'x';
  arr; // arr变为[1, 2, 3, undefined, undefined, 'x']
  ```

- slice:

  - ```
    var arr = ['A', 'B', 'C', 'D', 'E', 'F', 'G'];
    arr.slice(0, 3); // 从索引0开始，到索引3结束，但不包括索引3: ['A', 'B', 'C']
    arr.slice(3); // 从索引3开始到结束: ['D', 'E', 'F', 'G']
    ```

- unshift和shift

  - ```
    var arr = [1, 2];
    arr.unshift('A', 'B'); // 返回Array新的长度: 4
    arr; // ['A', 'B', 1, 2]
    arr.shift(); // 'A'
    arr; // ['B', 1, 2]
    arr.shift(); arr.shift(); arr.shift(); // 连续shift 3次
    arr; // []
    arr.shift(); // 空数组继续shift不会报错，而是返回undefined
    arr; // []
    ```

- splice:

  - ```
    var arr = ['Microsoft', 'Apple', 'Yahoo', 'AOL', 'Excite', 'Oracle'];
    // 从索引2开始删除3个元素,然后再添加两个元素:
    arr.splice(2, 3, 'Google', 'Facebook'); // 返回删除的元素 ['Yahoo', 'AOL', 'Excite']
    arr; // ['Microsoft', 'Apple', 'Google', 'Facebook', 'Oracle']
    // 只删除,不添加:
    arr.splice(2, 2); // ['Google', 'Facebook']
    arr; // ['Microsoft', 'Apple', 'Oracle']
    // 只添加,不删除:
    arr.splice(2, 0, 'Google', 'Facebook'); // 返回[],因为没有删除任何元素
    										// 注意插入的位置在'Google'之前
    arr; // ['Microsoft', 'Apple', 'Google', 'Facebook', 'Oracle']
    ```

- concat

  - *请注意*，`concat()`方法并没有修改当前`Array`，而是返回了一个新的`Array`。

  - ```
    var arr = ['A', 'B', 'C'];
    arr.concat(1, 2, [3, 4]); // ['A', 'B', 'C', 1, 2, 3, 4]
    // 实际上，concat()方法可以接收任意个元素和Array，并且自动把Array拆开，然后全部添加到新的Array里：
    ```

#### 对象

- 访问属性是通过`.`操作符完成的，但这要求属性名必须是一个有效的变量名。如果属性名包含特殊字符，就必须用`''`括起来：

  ```
  var xiaohong = {
      name: '小红',
      'middle-school': 'No.1 Middle School'
  };
  ```

  `xiaohong`的属性名`middle-school`不是一个有效的变量，就需要用`''`括起来。访问这个属性也无法使用`.`操作符，必须用`['xxx']`来访问：

  ```
  xiaohong['middle-school']; // 'No.1 Middle School'
  xiaohong['name']; // '小红'
  xiaohong.name; // '小红'
  ```

- 动态增删属性：

  - ```jinja2
    var xiaoming = {
        name: '小明'
    };
    xiaoming.age; // undefined
    xiaoming.age = 18; // 新增一个age属性
    xiaoming.age; // 18
    delete xiaoming.age; // 删除age属性
    xiaoming.age; // undefined
    delete xiaoming['name']; // 删除name属性
    xiaoming.name; // undefined
    delete xiaoming.school; // 删除一个不存在的school属性也不会报错
    ```

- 如果我们要检测`xiaoming`是否拥有某一属性，可以用`in`操作符：

  - ```
    'name' in xiaoming; // true
    ```

- 要判断一个属性是否是`xiaoming`自身拥有的，而不是继承得到的，可以用`hasOwnProperty()`方法：

  ```
  var xiaoming = {
      name: '小明'
  };
  xiaoming.hasOwnProperty('name'); // true
  xiaoming.hasOwnProperty('toString'); // false
  ```

#### 逻辑值：

- JavaScript把`null`、`undefined`、`0`、`NaN`和空字符串`''`视为`false`，其他值一概视为`true`

#### 循环

- `for`循环的一个变体是`for ... in`循环，它可以把一个对象的所有属性依次循环出来：

  ```
  var o = {
      name: 'Jack',
      age: 20,
      city: 'Beijing'
  };
  for (var key in o) {
      console.log(key); // 'name', 'age', 'city'
  }
  ```

- 由于`Array`也是对象，而它的每个元素的索引被视为对象的属性，因此，`for ... in`循环可以直接循环出`Array`的索引：

  ```
  var a = ['A', 'B', 'C'];
  for (var i in a) {
      console.log(i); // '0', '1', '2'
      console.log(a[i]); // 'A', 'B', 'C'
  }
  ```

  *请注意*，`for ... in`对`Array`的循环得到的是`String`而不是`Number`。

#### Map和Set

- JavaScript的对象有个小问题，就是键必须是字符串。

#### Iterate

- 具有`iterable`类型的集合可以通过新的`for ... of`循环来遍历。

- `for ... of`循环和`for ... in`循环有何区别？

  - 前者遍历的是元素，后者遍历的是**属性**（少用为妙）

- 当我们手动给`Array`对象添加了额外的属性后，`for ... in`循环将带来意想不到的意外效果：

  ```
  var a = ['A', 'B', 'C'];
  a.name = 'Hello';
  for (var x in a) {
      console.log(x); // '0', '1', '2', 'name'
  }
  ```

  ```
  var a = ['A', 'B', 'C'];
  a.name = 'Hello';
  for (var x of a) {
      console.log(x); // 'A', 'B', 'C'
  }
  ```

- 更好的方式是直接使用`iterable`内置的`forEach`方法

  - ```
    var a = ['A', 'B', 'C'];
    a.forEach(function (element, index, array) {
        // element: 指向当前元素的值
        // index: 指向当前索引
        // array: 指向Array对象本身
        console.log(element + ', index = ' + index);
    });
    /*
    A, index = 0
    B, index = 1
    C, index = 2
    */
    ```

  - ```
    var s = new Set(['A', 'B', 'C']);
    s.forEach(function (element, sameElement, set) {
        console.log(element);
    });
    //但Set没有索引，因此回调函数的前两个参数都是元素本身
    ```

  - ```
    var m = new Map([[1, 'x'], [2, 'y'], [3, 'z']]);
    m.forEach(function (value, key, map) {
        console.log(value);
    });
    ```

  - **!!!如果对某些参数不感兴趣，由于JavaScript的函数调用不要求参数必须一致，因此可以忽略它们**

    - ```
      var a = ['A', 'B', 'C'];
      a.forEach(function (element) {
          console.log(element);
      });
      //参数这里看的是位置，而不是参数的名称
      //应该类似java中函数的重载，你不需要的参数可以不填写，但是位置必须一一对应。
      //如果只要index还是得function(element, index)
      ```

## 函数

#### 定义与调用

- ```
  function abs(x) {
      if (x >= 0) {
          return x;
      } else {
          return -x;
      }
  }
  
  var abs = function (x) {
      if (x >= 0) {
          return x;
      } else {
          return -x;
      }
  };
  ```

  - 上述两种定义*完全等价*，注意第二种方式按照完整语法需要在函数体末尾加一个`;`，表示赋值语句结束。

- 参数

  - 由于JavaScript允许传入任意个参数而不影响调用，因此传入的参数比定义的参数多/少也没有问题

    - JavaScript还有一个免费赠送的关键字`arguments`，它只在函数内部起作用，并且永远指向当前函数的调用者传入的所有参数。`arguments`类似`Array`但它不是一个`Array`：

    - ```
      function foo(x) {
          console.log('x = ' + x); // 10
          for (var i=0; i<arguments.length; i++) {
              console.log('arg ' + i + ' = ' + arguments[i]); // 10, 20, 30
          }
      }
      foo(10, 20, 30);
      ```

  - 为了获取除了定义的参数之外传入的参数：

    - rest参数只能写在最后，前面用`...`标识，从运行结果可知，传入的参数先绑定`a`、`b`，多余的参数以数组形式交给变量`rest`

    - ```
      function foo(a, b, ...rest) {
          console.log('a = ' + a);
          console.log('b = ' + b);
          console.log(rest);
      }
      
      foo(1, 2, 3, 4, 5);
      // 结果:
      // a = 1
      // b = 2
      // Array [ 3, 4, 5 ]
      ```

- 关于返回值：

  - **JavaScript引擎有一个在行末自动添加分号的机制**

    - 对于return语句：

      - ```
        //如果把return语句拆成两行：
        function foo() {
            return
                { name: 'foo' };
        }
        
        foo(); // undefined
        ```

    - *要小心了*，由于JavaScript引擎在行末自动添加分号的机制，上面的代码实际上变成了：

    - ```
      function foo() {
          return; // 自动添加了分号，相当于return undefined;
              { name: 'foo' }; // 这行语句已经没法执行到了
      }
      ```

    - 所以正确的多行写法是：

      ```
      function foo() {
          return { // 这里不会自动加分号，因为{表示语句尚未结束
              name: 'foo'
          };
      }
      ```

#### 变量作用域与解构赋值

- 变量变量提升提升

  - JavaScript的函数定义有个特点，它会先扫描整个函数体的语句，把所有申明的变量“提升”到函数顶部

  - #### [变量提升只针对var声明的全局变量，let声明的不会]

  - ```
    function foo() {
        var x = 'Hello, ' + y;
        console.log(x);
        var y = 'Bob';
    }
    ```

  - 由于JavaScript的这一怪异的“特性”，我们在函数内部定义变量时，请严格遵守“在函数内部首先申明所有变量”这一规则。

- 全局作用域

  - 不在任何函数内定义的变量就具有全局作用域。实际上，JavaScript默认有一个全局对象`window`，全局作用域的变量实际上被绑定到`window`的一个属性：

  - 以变量方式`var foo = function () {}`定义的函数实际上也是一个全局变量

    - 顶层函数的定义也被视为一个全局变量，并绑定到`window`对象：

    - ```
      'use strict';
      
      function foo() {
          alert('foo');
      }
      
      foo(); // 直接调用foo()
      window.foo(); // 通过window.foo()调用
      ```

- 名字空间

  - 全局变量会绑定到`window`上，不同的JavaScript文件如果使用了相同的全局变量，或者定义了相同名字的顶层函数，都会造成命名冲突，并且很难被发现。

  - 减少冲突的一个方法是**把自己的所有变量和函数全部绑定到一个全局变量中**。例如：

  - ```
    // 唯一的全局变量MYAPP:
    var MYAPP = {};
    
    // 其他变量:
    MYAPP.name = 'myapp';
    MYAPP.version = 1.0;
    
    // 其他函数:
    MYAPP.foo = function () {
        return 'foo';
    };
    ```

- 局部作用域

  - **我们在`for`循环等语句块中是无法定义具有局部作用域的变量的**

  - 为了解决块级作用域，ES6引入了新的关键字`let`，用`let`替代`var`可以申明一个块级作用域的变量：

    - ```
      function foo() {
          for (var i=0; i<100; i++) {
              //
          }
          i += 100; // 仍然可以引用变量i
      }
      
      function foo() {
          var sum = 0;
          for (let i=0; i<100; i++) {
              sum += i;
          }
          // SyntaxError:
          i += 1;
      }
      ```

- 解构赋值

  - 可以同时对一组变量进行赋值

    - ```
      var [x, y, z] = ['hello', 'JavaScript', 'ES6'];
      ```

  - 解构赋值还可以忽略某些元素：

    ```
    let [, , z] = ['hello', 'JavaScript', 'ES6']; // 忽略前两个元素，只对z赋值第三个元素
    ```

  - 如果需要从一个对象中取出若干属性，也可以使用解构赋值，便于快速获取对象的指定属性：

    - ```
      var person = {
          name: '小明',
          age: 20,
          gender: 'male',
          passport: 'G-12345678',
          school: 'No.4 middle school'
      };
      var {name, age, passport} = person;
      // name = 小明, age = 20, passport = G-12345678
      
      //如果要使用的变量名和属性名不一致，可以用下面的语法获取：
      let {name, passport:id} = person;
      // 注意: passport不是变量，而是为了让变量id获得passport属性
      ```

  - 解构赋值还可以使用默认值，这样就避免了不存在的属性返回`undefined`的问题：

    - ```
      // 如果person对象没有single属性，默认赋值为true:
      var {name, single=true} = person;
      ```

  - ```
    {x, y} = { name: '小明', x: 100, y: 200};
    // 语法错误: Uncaught SyntaxError: Unexpected token =
    ```

    这是因为JavaScript引擎把`{`开头的语句当作了块处理，于是`=`不再合法。解决方法是用小括号括起来：

    ```
    ({x, y} = { name: '小明', x: 100, y: 200});
    ```

  - 一个使用案例：

    - 如果一个函数接收一个对象作为参数，那么，可以使用解构直接把对象的属性绑定到变量中。例如，下面的函数可以快速创建一个`Date`对象：

      ```
      function buildDate({year, month, day, hour=0, minute=0, second=0}) {
          return new Date(year + '-' + month + '-' + day + ' ' + hour + ':' + minute + ':' + second);
      }
      ```

      它的方便之处在于传入的对象只需要`year`、`month`和`day`这三个属性：

      ```
      buildDate({ year: 2017, month: 1, day: 1 });
      // Sun Jan 01 2017 00:00:00 GMT+0800 (CST)
      ```

      也可以传入`hour`、`minute`和`second`属性：

      ```
      buildDate({ year: 2017, month: 1, day: 1, hour: 20, minute: 15 });
      // Sun Jan 01 2017 20:15:00 GMT+0800 (CST)
      ```

#### 方法

- 绑定到对象上的函数称为方法，绑定了`this`

  - ```
    var xiaoming = {
        name: '小明',
        birth: 1990,
        age: function () {
            var y = new Date().getFullYear();
            return y - this.birth;
        }
    };
    ```

- 关于this的一个大坑：

  - JavaScript的函数内部如果调用了`this`，那么这个`this`到底指向谁？--> 视情况而定

    - ```
      function getAge() {
          var y = new Date().getFullYear();
          return y - this.birth;
      }
      
      var xiaoming = {
          name: '小明',
          birth: 1990,
          age: getAge
      };
      
      xiaoming.age(); // 25, 正常结果
      getAge(); // NaN
      //如果单独调用函数，比如getAge()，此时，该函数的this指向全局对象，也就是window。
      ```

    - 更坑爹的是，如果这么写：

      ```
      var fn = xiaoming.age; // 先拿到xiaoming的age函数
      fn(); // NaN
      ```

      也是不行的！要保证`this`指向正确，必须用`obj.xxx()`的形式调用！

    - ```
        var xiaoming = {
            name: '小明',
            birth: 1990,
            age: function () {
                function getAgeFromBirth() {
                    var y = new Date().getFullYear();
                    return y - this.birth;
                }
                return getAgeFromBirth();
            }
        };

        xiaoming.age(); // Uncaught TypeError: Cannot read property 'birth' of undefined
        //在函数内部定义的函数，this又指向undefined了！（在非strict模式下，它重新指向全局对象window！）
      ```

  - 解决方法（之一）：
  
    - ```
      var xiaoming = {
          name: '小明',
          birth: 1990,
          age: function () {
              var that = this; // 在方法内部一开始就捕获this
              function getAgeFromBirth() {
                  var y = new Date().getFullYear();
                  return y - that.birth; // 用that而不是this
              }
              return getAgeFromBirth();
          }
      };
      ```

- apply与call：

  - 要指定函数的`this`指向哪个对象，可以用函数本身的`apply`方法，它接收两个参数，第一个参数就是需要绑定的`this`变量，第二个参数是`Array`，表示函数本身的参数。

  - 另一个与`apply()`类似的方法是`call()`，唯一区别是：

    - `apply()`把参数打包成`Array`再传入；
    - `call()`把参数按顺序传入。

  - 比如调用`Math.max(3, 5, 4)`，分别用`apply()`和`call()`实现如下：

    ```
    Math.max.apply(null, [3, 5, 4]); // 5
    Math.max.call(null, 3, 5, 4); // 5
    ```

- 使用apply/call可以对系统定义的函数作出修改（例如统计此函数使用的次数）（装饰器）

  - ```
    var count = 0;
    var oldParseInt = parseInt; // 保存原函数
    
    window.parseInt = function () {
        count += 1;
        return oldParseInt.apply(null, arguments); // 调用原函数
    };
    //对普通函数调用，我们通常把this绑定为null。
    //虽然在一个独立的函数调用中，根据是否是strict模式，this指向undefined或window
    ```

  - nodejs全局对象是global不是window

#### 高阶函数：

- map:

  - ```
    function pow(x) {
        return x * x;
    }
    var arr = [1, 2, 3, 4, 5, 6, 7, 8, 9];
    var results = arr.map(pow); // [1, 4, 9, 16, 25, 36, 49, 64, 81]
    ```

- reduce

  - `reduce()`把结果继续和序列的下一个元素做累积计算

  - 要把`[1, 3, 5, 7, 9]`变换成整数13579，`reduce()`也能派上用场：

    ```
    var arr = [1, 3, 5, 7, 9];
    arr.reduce(function (x, y) {
        return x * 10 + y;
    }); // 13579
    ```

- filter

  - `filter()`把传入的函数依次作用于每个元素，然后根据返回值是`true`还是`false`决定保留还是丢弃该元素。

  - ```
    var arr = ['A', '', 'B', null, undefined, 'C', '  '];
    var r = arr.filter(function (s) {
        return s && s.trim(); // 注意：IE9以下的版本没有trim()方法
    });
    r; // ['A', 'B', 'C']
    ```

  - 利用`filter`，可以巧妙地去除`Array`的重复元素：

    - ```
      r = arr.filter(function (element, index, self) {
          return self.indexOf(element) === index;
      });
      //去除重复元素依靠的是indexOf总是返回第一个元素的位置，后续的重复元素位置与indexOf返回的位置不相等，因此被filter滤掉了。
      ```

- sort

  - 如果要倒序排序，我们可以把大的数放前面：

    - ```
      var arr = [10, 20, 1, 2];
      arr.sort(function (x, y) {
          if (x < y) {
              return 1; //记忆方法，return 1表示需要把y放到前面
          }
          if (x > y) {
              return -1;
          }
          return 0;
      }); // [20, 10, 2, 1]
      ```

  - 最后友情提示，`sort()`方法会直接对`Array`进行修改，它返回的结果仍是当前`Array`

- every

  - ​	`every()`方法可以判断数组的所有元素是否满足测试条件。

    - ```
      var arr = ['Apple', 'pear', 'orange'];
      console.log(arr.every(function (s) {
          return s.length > 0;
      })); // true, 因为每个元素都满足s.length>0
      ```

- find

  - `find()`方法用于查找符合条件的第一个元素，如果找到了，返回这个元素，否则，返回`undefined`

    - ```
      var arr = ['Apple', 'pear', 'orange'];
      console.log(arr.find(function (s) {
          return s.toLowerCase() === s;
      })); // 'pear', 因为pear全部是小写
      
      ```

- findIndex

  - `findIndex()`和`find()`类似，也是查找符合条件的第一个元素，不同之处在于`findIndex()`会返回这个元素的索引，如果没有找到，返回`-1`
  
- forEach

  - `forEach()`和`map()`类似，它也把每个元素依次作用于传入的函数，但不会返回新的数组。`forEach()`常用于遍历数组，因此，传入的函数不需要返回值

  - ```
    var arr = ['Apple', 'pear', 'orange'];
    arr.forEach(console.log); // 依次打印每个元素
    ```

#### 闭包

- ```
  function lazy_sum(arr) {
      var sum = function () {
          return arr.reduce(function (x, y) {
              return x + y;
          });
      }
      return sum;
  }
  ```
  - 当我们调用`lazy_sum()`时，返回的并不是求和结果，而是求和函数：

    ```
    var f = lazy_sum([1, 2, 3, 4, 5]); // function sum()
    ```

    调用函数`f`时，才真正计算求和的结果：

    ```
    f(); // 15
    ```

  - 请再注意一点，当我们调用`lazy_sum()`时，每次调用都会返回一个新的函数，即使传入相同的参数

- 当`lazy_sum`返回函数`sum`时，**相关参数和变量都保存在返回的函数中**，这种称为“闭包（Closure）”的程序结构拥有极大的威力。(**通过引用保存**)

  - ```
    function count() {
        var arr = [];
        for (var i=1; i<=3; i++) {
            arr.push(function () {
                return i * i;
            });
        }
        return arr;
    }
    
    var results = count();
    var f1 = results[0];
    var f2 = results[1];
    var f3 = results[2];
    
    f1(); // 16
    f2(); // 16
    f3(); // 16
    ```

  - 全部都是`16`！原因就在于返回的函数引用了变量`i`，但它并非立刻执行。等到3个函数都返回时，它们所引用的变量`i`已经变成了`4`，因此最终结果为`16`。

  - 返回闭包时牢记的一点就是：返回函数不要引用任何循环变量，或者后续会发生变化的变量。

  - 如果一定要引用循环变量怎么办？**方法是再创建一个函数，用该函数的参数绑定循环变量当前的值**，无论该循环变量后续如何更改，已绑定到函数参数的值不变：

    - ```
      function count() {
          var arr = [];
          for (var i=1; i<=3; i++) {
              arr.push((function (n) {
                  return function () {
                      return n * n;
                  }
              })(i));
          }
          return arr;
      }
      
      var results = count();
      var f1 = results[0];
      var f2 = results[1];
      var f3 = results[2];
      
      f1(); // 1
      f2(); // 4
      f3(); // 9
      ```

    - 注意这里用了一个“创建一个匿名函数并立刻执行”的语法：

      ```
      (function (x) {
          return x * x;
      })(3); // 9
      ```

      - 理论上讲，创建一个匿名函数并立刻执行可以这么写：

        ```
        function (x) { return x * x } (3);
        ```

        但是由于JavaScript语法解析的问题，会报SyntaxError错误，因此需要用括号把整个函数定义括起来：

        ```
        (function (x) { return x * x }) (3);
        ```

        通常，一个立即执行的匿名函数可以把函数体拆开，一般这么写：

        ```
        (function (x) {
            return x * x;
        })(3);
        ```

- 一个使用的例子:

  - 闭包还可以把多参数的函数变成单参数的函数。例如，要计算xy可以用`Math.pow(x, y)`函数，不过考虑到经常计算x2或x3，我们可以利用闭包创建新的函数`pow2`和`pow3`：

  - ```
    function make_pow(n) {
        return function (x) {
            return Math.pow(x, n);
        }
    }
    ```

#### 箭头函数

- ```
  // 可变参数:
  (x, y, ...rest) => {
      var i, sum = x + y;
      for (i=0; i<rest.length; i++) {
          sum += rest[i];
      }
      return sum;
  }
  ```

- 如果要返回一个对象，就要注意，如果是单表达式，这么写的话会报错：

  ```
  // SyntaxError:
  x => { foo: x }
  ```

  因为和函数体的`{ ... }`有语法冲突，所以要改为：

  ```
  // ok:
  x => ({ foo: x })
  ```

- 关于this:

  - 箭头函数看上去是匿名函数的一种简写，但实际上，箭头函数和匿名函数有个明显的区别：箭头函数内部的`this`是词法作用域

  - **由于`this`在箭头函数中已经按照词法作用域绑定了**，所以，用`call()`或者`apply()`调用箭头函数时，无法对`this`进行绑定，**即传入的第一个参数被忽略**：

    ```
    var obj = {
        birth: 1990,
        getAge: function (year) {
            var b = this.birth; // 1990
            var fn = (y) => y - this.birth; // this.birth仍是1990
            return fn.call({birth:2000}, year);
        }
    };
    obj.getAge(2015); // 25
    ```

#### generator

- [关于generator讲的很好的一篇文章](http://www.ruanyifeng.com/blog/2015/04/generator.html)

  - 相当于执行完`yield ……`后就从这个线程出去了，下次调next的时候才会回这个线程
- `yield a`和`.next(b)`,a和b就相当于两个线程之间的信息传递（link中文章的*协程*的概念）
  
  - 
  
- 定义

  - generator跟函数很像，定义如下：

    ```javascript
    function* foo(x) {
        yield x + 1;
        yield x + 2;
        return x + 3;
    }
    ```

    generator和函数不同的是，generator由`function*`定义（注意多出的`*`号），并且，除了`return`语句，还可以用`yield`返回多次。

- Fibonacci:

  - ```
    function* fib(max) {
        var
            t,
            a = 0,
            b = 1,
            n = 0;
        while (n < max) {
            yield a;
            [a, b] = [b, a + b];
            n ++;
        }
        return;
    }
    ```

  - ```
    fib(5); // fib {[[GeneratorStatus]]: "suspended", [[GeneratorReceiver]]: Window}
    ```

    直接调用一个generator和调用函数不一样，**`fib(5)`仅仅是创建了一个generator对象，还没有去执行它**。（`fib(5)`的返回值是函数指针）

    调用generator对象有两个方法

- 一是不断地调用generator对象的`next()`方法：

  ```
  var f = fib(5);
  f.next(); // {value: 0, done: false}
  f.next(); // {value: 1, done: false}
  f.next(); // {value: 1, done: false}
  f.next(); // {value: 2, done: false}
  f.next(); // {value: 3, done: false}
  f.next(); // {value: undefined, done: true}
  ```

  - `next()`方法会执行generator的代码，然后，每次遇到`yield x;`就返回一个对象`{value: x, done: true/false}`，然后“暂停”。返回的`value`就是`yield`的返回值，`done`表示这个generator是否已经执行结束了。**如果`done`为`true`，则`value`就是`return`的返回值。**

- 第二个方法是直接用`for ... of`循环迭代generator对象，这种方式不需要我们自己判断`done`：

  - ```
    for (var x of fib(10)) {
        console.log(x); // 依次输出0, 1, 1, 2, 3, ...
    }
    ```

- 因为generator可以在执行过程中多次返回，所以它看上去就像一个可以记住执行状态的函数

  - !可以记住执行状态这一点:
    - **闭包和generator很像**

## TODO:标准对象

- 介绍了`Date`, `RegExp`,`JSON`

## TODO:面向对象编程

- 介绍了创建和继承

## 浏览器

#### TODO:浏览器对象

- 介绍了JS对浏览器的操作

#### TODO:操作DOM

#### TODO:操作表单

#### TODO:操作文件

- 在JavaScript中，浏览器的JavaScript执行引擎在执行JavaScript代码时，总是以单线程模式执行，也就是说，任何时候，JavaScript代码都不可能同时有多于1个线程在执行。

- 在JavaScript中，执行多任务实际上都是**异步调用**，比如上面的代码：

  ```
  reader.readAsDataURL(file);
  ```

  就会发起一个异步操作来读取文件内容。因为是异步操作，所以我们在JavaScript代码中就不知道什么时候操作结束，因此需要先设置一个**回调函数**：

  ```
  reader.onload = function(e) {
      // 当文件读取完成后，自动调用此函数:
  };
  ```

  当文件读取完成后，JavaScript引擎将自动调用我们设置的回调函数。执行回调函数时，文件已经读取完毕，所以我们可以在回调函数内部安全地获得文件内容。

#### AJAX(Asynchronous JavaScript and XML)

- Asynchronous JavaScript and XML，意思就是用JavaScript执行异步网络请求。

- 在现代浏览器上写AJAX主要依靠`XMLHttpRequest`对象：

  - ```
    var request = new XMLHttpRequest(); // 新建XMLHttpRequest对象
    
    request.onreadystatechange = function () { // 状态发生变化时，函数被回调
        if (request.readyState === 4) { // 成功完成
            // 判断响应结果:
            if (request.status === 200) {
                // 成功，通过responseText拿到响应的文本:
                // success和fail是自己写的函数，可以打印结果
                return success(request.responseText);
            } else {
                // 失败，根据响应码判断失败原因:
                return fail(request.status);
            }
        } else {
            // HTTP请求还在继续...
        }
    }
    
    // 发送请求:
    request.open('GET', '/api/categories');
    request.send();
    ```

  - 上面代码的URL使用的是相对路径，绝对路径会报错：

    - 默认情况下，JavaScript在发送AJAX请求时，URL的域名必须和当前页面完全一致。
      - 完全一致=域名相同、协议相同、端口相同

- 跨域政策（CROS）

  - CORS全称Cross-Origin Resource Sharing，是HTML5规范定义的如何跨域访问资源。

  - 一些概念：

    - Origin表示本域，也就是浏览器当前页面的域。当JavaScript向外域（如sina.com）发起请求后，浏览器收到响应后，首先检查响应头里的`Access-Control-Allow-Origin`是否包含本域，如果是，则此次跨域请求成功，如果不是，则请求失败，JavaScript将无法获取到响应的任何数据。

    - ![js-cors](https://www.liaoxuefeng.com/files/attachments/1027024093709472/l)

    - 假设本域是`my.com`，外域是`sina.com`，只要响应头`Access-Control-Allow-Origin`为`http://my.com`，或者是`*`，本次请求就可以成功。

      可见，跨域能否成功，取决于对方服务器是否愿意给你设置一个正确的`Access-Control-Allow-Origin`，决定权始终在对方手中。

    - 面这种跨域请求，称之为“**简单请求**”。简单请求包括GET、HEAD和POST（POST的Content-Type类型 仅限`application/x-www-form-urlencoded`、`multipart/form-data`和`text/plain`），并且不能出现任何自定义头（例如，`X-Custom: 12345`），通常能满足90%的需求。

  - 对于PUT、DELETE以及其他类型如`application/json`的POST请求，在发送AJAX请求之前，浏览器会先发送一个`OPTIONS`请求（称为preflighted请求）到这个URL上，询问目标服务器是否接受：

    ```
    OPTIONS /path/to/resource HTTP/1.1
    Host: bar.com
    Origin: http://my.com
    Access-Control-Request-Method: POST
    ```

    服务器必须响应并明确指出允许的Method：

    ```
    HTTP/1.1 200 OK
    Access-Control-Allow-Origin: http://my.com
    Access-Control-Allow-Methods: POST, GET, PUT, OPTIONS
    Access-Control-Max-Age: 86400
    ```

    浏览器确认服务器响应的`Access-Control-Allow-Methods`头确实包含将要发送的AJAX请求的Method，才会继续发送AJAX，否则，抛出一个错误。

    由于以`POST`、`PUT`方式传送JSON格式的数据在REST中很常见，所以要跨域正确处理`POST`和`PUT`请求，服务器端必须正确响应`OPTIONS`请求。

#### `async`和`await`

- [segmentfault](https://segmentfault.com/a/1190000007535316#item-2-4)

- [廖雪峰的Blog](http://www.ruanyifeng.com/blog/2015/05/async.html)

- [Promise.resolve()](https://segmentfault.com/a/1190000020980101)

- async 函数（包含函数语句、函数表达式、Lambda表达式）会返回一个 Promise 对象，如果在函数中 `return` 一个直接量，async 会把这个直接量通过 `Promise.resolve()` 封装成 Promise 对象。

- await 表达式的运算结果取决于它等的东西。

  **如果它等到的不是一个 Promise 对象**，那 await 表达式的运算结果就是它等到的东西。

  **如果它等到的是一个 Promise 对象**，await 就忙起来了，它会阻塞后面的代码，等着 Promise 对象 resolve，然后得到 resolve 的值，作为 await 表达式的运算结果。

  > 看到上面的阻塞一词，心慌了吧……放心，这就是 await 必须用在 async 函数中的原因。async 函数调用不会造成阻塞，它内部所有的阻塞都被封装在一个 Promise 对象中异步执行

- 总结：对于Promise，把它理解为一个异步进程的栈，每新建一个Promise对象就把它里面代码（进程）塞到这个异步进程栈中，然后每一个事件循环的时候从进程栈中取进程执行。

- 对于async，他会把后面的函数/表达式封装在一个Promise对象中，因此`var a = async function f(){}`,则`a`就是一个Promise对象，可以接resolve

- 而对于await，要取决于它后面的等待的东西是不是Promise对象，如果不是则它会直接往下顺序走，若是则它会把后面的代码阻塞，等待这个Promise对象的resolve值，但它阻塞的代码都在async包起来的最外面的Promise对象中（**故本质上还是没有阻塞，故await只能在async中使用**）

- 综上，其实async和await就是异步进程的同步写法

  - 因为你不用的话：

    - ```
      //用
      var a = await readFile();
      /* ... 对a一系列操作 */
      
      //不用
      new Promise((resolve) => {
      	readFile().回调函数(resolve(data));
      }).resolve(/*...对a的一系列操作*/)
      ```

      

#### Promise

- ```
  //js设置一定时间后调用回调函数
  setTimeout(callback, 1000); // 1秒钟后调用callback函数
  ```

- Promise有各种开源实现，在ES6中被统一规范，由浏览器直接支持。

- **await后面要跟Promise对象才会是异步**

- 对于Promise的说明：

  - resolve作用是，将Promise对象的状态从“未完成”变为“成功”（即从 pending 变为 fulfilled），在异步操作成功时调用，并将异步操作的结果，作为参数传递出去；
  - reject作用是，将Promise对象的状态从“未完成”变为“失败”（即从 pending 变为 rejected），在异步操作失败时调用，并将异步操作报出的错误，作为参数传递出去。 
  - promise有三个状态：
     1、pending[待定]初始状态
     2、fulfilled[实现]操作成功
     3、rejected[被否决]操作失败
     当promise状态发生改变，就会触发then()里的响应函数处理后续步骤；
     promise状态一经改变，不会再变。
  - Promise对象的状态改变，只有两种可能：
     从pending变为fulfilled
     从pending变为rejected。
     这两种情况只要发生，状态就凝固了，不会再变了。

- ```
  function test(resolve, reject) {
      var timeOut = Math.random() * 2;
      log('set timeout to: ' + timeOut + ' seconds.');
      setTimeout(function () {
          if (timeOut < 1) {
              log('call resolve()...');
              //不是自己写的函数，一定要有resolve和reject
              resolve('200 OK');
          }
          else {
              log('call reject()...');
              reject('timeout in ' + timeOut + ' seconds.');
          }
      }, timeOut * 1000);
  }
  
  
  new Promise(test).then(function (result) {
      console.log('成功：' + result);
  }).catch(function (reason) {
      console.log('失败：' + reason);
  });
  ```

- 可见Promise最大的好处是在异步执行的流程中，把执行代码和处理结果的代码清晰地分离了：

  - ![promise](https://www.liaoxuefeng.com/files/attachments/1027242914217888/l)

- Promise还可以做更多的事情，比如，有若干个异步任务，需要先做任务1，如果成功后再做任务2，任何任务失败则不再继续并执行错误处理函数。

  要串行执行这样的异步任务，不用Promise需要写一层一层的嵌套代码。有了Promise，我们只需要简单地写：

  ```
  job1.then(job2).then(job3).catch(handleError);
  ```
  - 其中，`job1`、`job2`和`job3`都是Promise对象。

  - ```
    // 0.5秒后返回input*input的计算结果:
    function multiply(input) {
        return new Promise(function (resolve, reject) {
            log('calculating ' + input + ' x ' + input + '...');
            setTimeout(resolve, 500, input * input);
        });
    }
    
    // 0.5秒后返回input+input的计算结果:
    function add(input) {
        return new Promise(function (resolve, reject) {
            log('calculating ' + input + ' + ' + input + '...');
            setTimeout(resolve, 500, input + input);
        });
    }
    
    var p = new Promise(function (resolve, reject) {
        log('start new Promise...');
        resolve(123);
    });
    
    p.then(multiply)
     .then(add)
     .then(multiply)
     .then(add)
     .then(function (result) {
        log('Got value: ' + result);
    });
    ```

- **除了串行执行若干异步任务外，Promise还可以并行执行异步任务。**

  - ```
    var p1 = new Promise(function (resolve, reject) {
        setTimeout(resolve, 500, 'P1');
    });
    var p2 = new Promise(function (resolve, reject) {
        setTimeout(resolve, 600, 'P2');
    });
    // 同时执行p1和p2，并在它们都完成后执行then:
    Promise.all([p1, p2]).then(function (results) {
        console.log(results); // 获得一个Array: ['P1', 'P2']
    });
    ```

- 有些时候，多个异步任务是为了容错。比如，同时向两个URL读取用户的个人信息，只需要获得先返回的结果即可。这种情况下，用`Promise.race()`实现：

  ```
  var p1 = new Promise(function (resolve, reject) {
      setTimeout(resolve, 500, 'P1');
  });
  var p2 = new Promise(function (resolve, reject) {
      setTimeout(resolve, 600, 'P2');
  });
  Promise.race([p1, p2]).then(function (result) {
      console.log(result); // 'P1'
  });
  ```

  由于`p1`执行较快，Promise的`then()`将获得结果`'P1'`。`p2`仍在继续执行，但执行结果将被丢弃。

#### TODO：CANVAS

## JQUERY

- JavaScript世界中使用最广泛的一个库

- 使用jQuery

  - 使用jQuery只需要在页面的``引入jQuery文件即可：

  ```
  <html>
  <head>
      <script src="//code.jquery.com/jquery-1.11.3.min.js"></script>
  	...
  </head>
  <body>
      ...
  </body>
  </html>
  ```

- jQuery这么流行，肯定是因为它解决了一些很重要的问题。实际上，jQuery能帮我们干这些事情：
  - 消除浏览器差异：你不需要自己写冗长的代码来针对不同的浏览器来绑定事件，编写AJAX等代码；
  - 简洁的操作DOM的方法：写`$('#test')`肯定比`document.getElementById('test')`来得简洁；
  - 轻松实现动画、修改CSS等各种操作。

- $符号

  - `$`是著名的jQuery符号。实际上，jQuery把所有功能全部封装在一个全局变量`jQuery`中，而`$`也是一个合法的变量名，它是变量`jQuery`的别名

  - `$`本质上就是一个函数，但是函数也是对象，于是`$`除了可以直接调用外，也可以有很多其他属性。

  - 换名字：

    - ```
      jq = jQuery.noConflict();
      jq // jQuery(selector, context)
      ```

#### 选择器

- jQuery的选择器就是帮助我们快速定位到一个或多个DOM节点。

- 按ID查找

  - ```
    // 查找<div id="abc">:
    var div = $('#abc');
    ```

    *注意*，`#abc`以`#`开头。返回的对象是jQuery对象。

  - jQuery对象类似数组，它的每个元素都是一个引用了DOM节点的对象。

    - 以上面的查找为例，如果`id`为`abc`的``存在，返回的jQuery对象如下：

      ```
      [<div id="abc">...</div>]
      ```

  - jQuery对象和DOM对象之间可以互相转化：

    ```
    var div = $('#abc'); // jQuery对象
    var divDom = div.get(0); // 假设存在div，获取第1个DOM元素
    var another = $(divDom); // 重新把DOM包装为jQuery对象
    ```

- 按tag查找

  - ```
    var ps = $('p'); // 返回所有<p>节点
    ps.length; // 数一数页面有多少个<p>节点
    ```

- 按class查找

  - ```
    // 按class查找注意在class名称前加一个.
    var a = $('.red'); // 所有节点包含`class="red"`都将返回
    // 例如:
    // <div class="red">...</div>
    // <p class="green red">...</p>
    ```

  - 通常很多节点有多个class，我们可以查找同时包含`red`和`green`的节点：

    ```
    var a = $('.red.green'); // 注意没有空格！
    // 符合条件的节点：
    // <div class="red green">...</div>
    // <div class="blue green red">...</div>
    ```

- 按属性查找

  - ```
    var email = $('[name=email]'); // 找出<??? name="email">
    ```

  - 当属性的值包含空格等特殊字符时，需要用**双引号**括起来。

    按属性查找还可以使用**前缀查找或者后缀**查找：

    ```
    var icons = $('[name^=icon]'); // 找出所有name属性值以icon开头的DOM
    // 例如: name="icon-1", name="icon-2"
    var names = $('[name$=with]'); // 找出所有name属性值以with结尾的DOM
    // 例如: name="startswith", name="endswith"
    ```

    这个方法尤其适合通过class属性查找，且不受class包含多个名称的影响：

    ```
    var icons = $('[class^="icon-"]'); // 找出所有class包含至少一个以`icon-`开头的DOM
    // 例如: class="icon-clock", class="abc icon-home"
    ```

- 组合查找

  - 组合查找就是把上述简单选择器组合起来使用。如果我们查找`$('[name=email]')`，很可能把表单外的``也找出来，但我们只希望查找``，就可以这么写：

    ```
    var emailInput = $('input[name=email]'); // 不会找出<div name="email">
    ```

    同样的，根据tag和class来组合查找也很常见：

    ```
    var tr = $('tr.red'); // 找出<tr class="red ...">...</tr>
    ```

- 多项选择器

  - 多项选择器就是把多个选择器用`,`组合起来一块选：

    ```
    $('p,div'); // 把<p>和<div>都选出来
    $('p.red,p.green'); // 把<p class="red">和<p class="green">都选出来
    ```

    要注意的是，选出来的元素是按照它们在HTML中出现的顺序排列的，**而且不会有重复元素**。例如，``不会被上面的`$('p.red,p.green')`选择两次。

##### 层级选择器

- 如果两个DOM元素具有层级关系，就可以用`$('ancestor descendant')`来选择，层级之间用空格隔开。例如：

  ```
  <!-- HTML结构 -->
  <div class="testing">
      <ul class="lang">
          <li class="lang-javascript">JavaScript</li>
          <li class="lang-python">Python</li>
          <li class="lang-lua">Lua</li>
      </ul>
  </div>
  ```

  要选出JavaScript，可以用层级选择器：

  ```
  $('ul.lang li.lang-javascript'); // [<li class="lang-javascript">JavaScript</li>]
  $('div.testing li.lang-javascript'); // [<li class="lang-javascript">JavaScript</li>]
  ```

  因为`<div>`和`<ul>`都是`<li>`的祖先节点，所以上面两种方式都可以选出相应的`<li>`节点。

- 还可以多层：

  - ```
    $('form.test p input'); // 在form表单选择被<p>包含的<input>
    ```

##### 子选择器（Child Selector）

- 子选择器`$('parent>child')`类似层级选择器，但是限定了层级关系必须是父子关系，就是``节点必须是``节点的直属子节点。还是以上面的例子：

```
$('ul.lang>li.lang-javascript'); // 可以选出[<li class="lang-javascript">JavaScript</li>]
$('div.testing>li.lang-javascript'); // [], 无法选出，因为<div>和<li>不构成父子关系
```

##### 过滤器（Filter）

- 过滤器一般不单独使用，它通常附加在选择器上，帮助我们更精确地定位元素。观察过滤器的效果：

  ```
  $('ul.lang li'); // 选出JavaScript、Python和Lua 3个节点
  
  $('ul.lang li:first-child'); // 仅选出JavaScript
  $('ul.lang li:last-child'); // 仅选出Lua
  $('ul.lang li:nth-child(2)'); // 选出第N个元素，N从1开始
  $('ul.lang li:nth-child(even)'); // 选出序号为偶数的元素
  $('ul.lang li:nth-child(odd)'); // 选出序号为奇数的元素
  ```

##### 表单相关

- 针对表单元素，jQuery还有一组特殊的选择器：

  - `:input`：可以选择``，``，``和``；
  - `:file`：可以选择``，和`input[type=file]`一样；
  - `:checkbox`：可以选择复选框，和`input[type=checkbox]`一样；
  - `:radio`：可以选择单选框，和`input[type=radio]`一样；
  - `:focus`：可以选择当前输入焦点的元素，例如把光标放到一个``上，用`$('input:focus')`就可以选出；
  - `:checked`：选择当前勾上的单选框和复选框，用这个选择器可以立刻获得用户选择的项目，如`$('input[type=radio]:checked')`；
  - `:enabled`：可以选择可以正常输入的``、`` 等，也就是没有灰掉的输入；
  - `:disabled`：和`:enabled`正好相反，选择那些不能输入的。

  此外，jQuery还有很多有用的选择器，例如，选出可见的或隐藏的元素：

  ```
  $('div:visible'); // 所有可见的div
  $('div:hidden'); // 所有隐藏的div
  ```

##### 查找和过滤

- 当我们拿到一个jQuery对象后，还可以以这个对象为基准，进行查找和过滤。

- 查找：

  - ```
    <!-- HTML结构 -->
    <ul class="lang">
        <li class="js dy">JavaScript</li>
        <li class="dy">Python</li>
        <li id="swift">Swift</li>
        <li class="dy">Scheme</li>
        <li name="haskell">Haskell</li>
    </ul>
    
    var ul = $('ul.lang'); // 获得<ul>
    var dy = ul.find('.dy'); // 获得JavaScript, Python, Scheme
    var swf = ul.find('#swift'); // 获得Swift
    var hsk = ul.find('[name=haskell]'); // 获得Haskell
    ```

  - 如果要从当前节点开始向上查找，使用`parent()`方法：

    ```
    var swf = $('#swift'); // 获得Swift
    var parent = swf.parent(); // 获得Swift的上层节点<ul>
    var a = swf.parent('.red'); // 获得Swift的上层节点<ul>，同时传入过滤条件。如果ul不符合条件，返回空jQuery对象
    ```

  - 对于位于同一层级的节点，可以通过`next()`和`prev()`方法，例如：

    当我们已经拿到`Swift`节点后：

    ```
    var swift = $('#swift');
    
    swift.next(); // Scheme
    swift.next('[name=haskell]'); // 空的jQuery对象，因为Swift的下一个元素Scheme不符合条件[name=haskell]
    
    swift.prev(); // Python
    swift.prev('.dy'); // Python，因为Python同时符合过滤器条件.dy
    ```

- 过滤

  - `filter()`方法可以过滤掉不符合选择器条件的节点：

    ```
    var langs = $('ul.lang li'); // 拿到JavaScript, Python, Swift, Scheme和Haskell
    var a = langs.filter('.dy'); // 拿到JavaScript, Python, Scheme
    ```

  - 或者传入一个函数，要特别注意函数内部的`this`被绑定为DOM对象，不是jQuery对象：

    ```
    var langs = $('ul.lang li'); // 拿到JavaScript, Python, Swift, Scheme和Haskell
    langs.filter(function () {
        return this.innerHTML.indexOf('S') === 0; // 返回S开头的节点
    }); // 拿到Swift, Scheme
    ```

  - `map()`方法把一个jQuery对象包含的若干DOM节点转化为其他对象：

    ```
    var langs = $('ul.lang li'); // 拿到JavaScript, Python, Swift, Scheme和Haskell
    var arr = langs.map(function () {
        return this.innerHTML;
    }).get(); // 用get()拿到包含string的Array：['JavaScript', 'Python', 'Swift', 'Scheme', 'Haskell']
    ```

  - 此外，一个jQuery对象如果包含了不止一个DOM节点，`first()`、`last()`和`slice()`方法可以返回一个新的jQuery对象，把不需要的DOM节点去掉：

    ```
    var langs = $('ul.lang li'); // 拿到JavaScript, Python, Swift, Scheme和Haskell
    var js = langs.first(); // JavaScript，相当于$('ul.lang li:first-child')
    var haskell = langs.last(); // Haskell, 相当于$('ul.lang li:last-child')
    var sub = langs.slice(2, 4); // Swift, Scheme, 参数和数组的slice()方法一致
    ```

#### TODO：剩下的JQUERY部分

## TODO：错误处理

## TODO：underscore

## Node.js

- 在2009年，Ryan正式推出了基于JavaScript语言和V8引擎的开源Web服务器项目，命名为Node.js。
- Node第一次把JavaScript带入到后端服务器开发
- npm其实是Node.js的包管理工具（package manager）
- 从本章开始，我们编写的JavaScript代码将*不能*在浏览器环境中执行了，而是在Node环境中执行
- 对于windows：
  - 要务必注意，记事本以UTF-8格式保存文件时，会自作聪明地在文件开始的地方加上几个特殊字符（UTF-8 BOM），结果经常会导致程序运行出现莫名其妙的错误。
  - 注意用UTF-8格式保存。
- 第一行总是写上`'use strict';`是因为我们总是以严格模式运行JavaScript代码，避免各种潜在陷阱。
- `node --use_strict hello.js`:使用strict模式

#### 模块

- 在Node环境中，一个.js文件就称之为一个模块（module）。

- 模块的保存与使用：

  - ```
    //hello.js
    'use strict';
    
    var s = 'Hello';
    
    function greet(name) {
        console.log(s + ', ' + name + '!');
    }
    module.exports = greet;
    
    //greet.js
    'use strict';
    
    // 引入hello模块:
    var greet = require('./hello');
    
    var s = 'Michael';
    
    greet(s); // Hello, Michael!
    ```

    - 在使用`require()`引入模块的时候，请注意模块的相对路径。
    - 如果只写模块名,则Node会依次在内置模块、全局模块和当前模块下查找`hello.js`，你很可能会得到一个错误：

  - 总结：一个模块想要对外暴露变量（函数也是变量），可以用`module.exports = variable;`，一个模块要引用其他模块暴露的变量，用`var ref = require('module_name');`就拿到了引用模块的变量。

    - ```
      module.exports = {
          hello: hello,
          greet: greet
      };
      ```

#### 基本模块

- global

  - 在Node.js环境中，也有唯一的全局对象，但不叫`window`，而叫`global`

- process

  - `process`也是Node.js提供的一个对象，它代表当前Node.js进程

  - ```
    > process === global.process;
    true
    > process.version;
    'v5.2.0'
    > process.platform;
    'darwin'
    > process.arch;
    'x64'
    > process.cwd(); //返回当前工作目录
    '/Users/michael'
    > process.chdir('/private/tmp'); // 切换当前工作目录
    undefined
    > process.cwd();
    '/private/tmp'
    ```

  - ​	Node.js不断执行响应事件的JavaScript函数，直到没有任何响应事件的函数可以执行时，Node.js就退出了。

    - 如果我们想要在下一次事件响应中执行代码，可以调用`process.nextTick()`：

    ```
    // test.js
    
    // process.nextTick()将在下一轮事件循环中调用:
    process.nextTick(function () {
        console.log('nextTick callback!');
    });
    console.log('nextTick was set!');
    ```

  - ```
    // 程序即将退出时的回调函数:
    process.on('exit', function (code) {
        console.log('about to exit with code: ' + code);
    });
    ```

##### fs

- Node.js内置的`fs`模块就是文件系统模块，负责读写文件，提供了异步和同步的方法

- 异步读取文件：

  - ```
    'use strict';
    
    var fs = require('fs');
    
    fs.readFile('sample.txt', 'utf-8', function (err, data) {
        if (err) {
            console.log(err);
        } else {
            console.log(data);
        }
    });
    ```

  - 由于`err`是否为`null`就是判断是否出错的标志，所以通常的判断逻辑总是：

    ```
    if (err) {
        // 出错了
    } else {
        // 正常
    }
    ```

  - 当读取二进制文件时，不传入文件编码时，回调函数的`data`参数将返回一个`Buffer`对象。

- 同步读取文件：

  - ```
    'use strict';
    
    var fs = require('fs');
    
    var data = fs.readFileSync('sample.txt', 'utf-8');
    console.log(data);
    ```

    可见，原异步调用的回调函数的`data`被函数直接返回，函数名需要改为`readFileSync`，其它参数不变。

    如果同步读取文件发生错误，则需要用`try...catch`捕获该错误：

    ```
    try {
        var data = fs.readFileSync('sample.txt', 'utf-8');
        console.log(data);
    } catch (err) {
        // 出错了
    }
    ```

- 写文件：

  ```
  //异步
  'use strict';
  var fs = require('fs');
  
  var data = 'Hello, Node.js';
  fs.writeFile('output.txt', data, function (err) {
      if (err) {
          console.log(err);
      } else {
          console.log('ok.');
      }
  });
  
  //同步
  'use strict';
  var fs = require('fs');
  
  var data = 'Hello, Node.js';
  fs.writeFileSync('output.txt', data);
  ```

- 获取文件信息：

  - 如果我们要获取文件大小，创建时间等信息，可以使用`fs.stat()`，它返回一个`Stat`对象，能告诉我们文件或目录的详细信息：

  - ```
    'use strict';
    
    var fs = require('fs');
    
    fs.stat('sample.txt', function (err, stat) {
        if (err) {
            console.log(err);
        } else {
            // 是否是文件:
            console.log('isFile: ' + stat.isFile());
            // 是否是目录:
            console.log('isDirectory: ' + stat.isDirectory());
            if (stat.isFile()) {
                // 文件大小:
                console.log('size: ' + stat.size);
                // 创建时间, Date对象:
                console.log('birth time: ' + stat.birthtime);
                // 修改时间, Date对象:
                console.log('modified time: ' + stat.mtime);
            }
        }
    });
    ```

- 关于异步和同步：
  - 由于Node环境执行的JavaScript代码是服务器端代码，所以，绝大部分需要在服务器运行期反复执行业务逻辑的代码，*必须使用异步代码*，否则，同步代码在执行时期，服务器将停止响应，因为JavaScript只有一个执行线程。
  - 服务器启动时如果需要读取配置文件，或者结束时需要写入到状态文件时，可以使用同步代码，因为这些代码只在启动和结束时执行一次，不影响服务器正常运行时的异步执行。

##### stream

- 流的特点是数据是有序的，而且必须依次读取，或者依次写入，不能像Array那样随机定位。

- **关于流的操作都是异步的**

- 下面是一个从文件流读取文本内容的示例：

  ```
  'use strict';
  
  var fs = require('fs');
  
  // 打开一个流:
  var rs = fs.createReadStream('sample.txt', 'utf-8');
  
  rs.on('data', function (chunk) {
      console.log('DATA:')
      console.log(chunk);
  });
  
  rs.on('end', function () {
      console.log('END');
  });
  
  rs.on('error', function (err) {
      console.log('ERROR: ' + err);
  });
  ```

- 要以流的形式写入文件，只需要不断调用`write()`方法，最后以`end()`结束：

  ```
  'use strict';
  
  var fs = require('fs');
  
  var ws1 = fs.createWriteStream('output1.txt', 'utf-8');
  ws1.write('使用Stream写入文本数据...\n');
  ws1.write('END.');
  ws1.end();
  
  var ws2 = fs.createWriteStream('output2.txt');
  ws2.write(new Buffer('使用Stream写入二进制数据...\n', 'utf-8'));
  ws2.write(new Buffer('END.', 'utf-8'));
  ws2.end();
  ```

- pipe

  - 让我们用`pipe()`把一个文件流和另一个文件流串起来，这样源文件的所有数据就自动写入到目标文件里了，所以，这实际上是一个复制文件的程序：

    ```
    'use strict';
    
    var fs = require('fs');
    
    var rs = fs.createReadStream('sample.txt');
    var ws = fs.createWriteStream('copied.txt');
    
    //此步也是异步的
    //rs.pipe(ws).on('end', function(){})
    rs.pipe(ws);
    ```

    - 默认情况下，当`Readable`流的数据读取完毕，`end`事件触发后，将自动关闭`Writable`流。如果我们不希望自动关闭`Writable`流，需要传入参数：

      ```
      readable.pipe(writable, { end: false });
      ```

##### http

- `request`对象封装了HTTP请求，我们调用`request`对象的属性和方法就可以拿到所有HTTP请求的信息；

  `response`对象封装了HTTP响应，我们操作`response`对象的方法，就可以把HTTP响应返回给浏览器。

- 一个最简单的web服务器：

  - ```javascript
    'use strict';
    
    // 导入http模块:
    var http = require('http');
    
    // 创建http server，并传入回调函数:
    var server = http.createServer(function (request, response) {
        // 回调函数接收request和response对象,
        // 获得HTTP请求的method和url:
        console.log(request.method + ': ' + request.url);
        // 将HTTP响应200写入response, 同时设置Content-Type: text/html:
        response.writeHead(200, {'Content-Type': 'text/html'});
        // 将HTTP响应的HTML内容写入response:
        response.end('<h1>Hello world!</h1>');
    });
    
    // 让服务器监听8080端口:
    server.listen(8080);
    
    console.log('Server is running at http://127.0.0.1:8080/');
    ```

- 文件服务器：

  - 解析URL需要用到Node.js提供的`url`模块，它使用起来非常简单，通过`parse()`将一个字符串解析为一个`Url`对象

  - 处理本地文件目录需要使用Node.js提供的`path`模块

    - ```
      'use strict';
      
      var path = require('path');
      
      // 解析当前目录:
      var workDir = path.resolve('.'); // '/Users/michael'
      
      // 组合完整的文件路径:当前目录+'pub'+'index.html':
      var filePath = path.join(workDir, 'pub', 'index.html');
      // '/Users/michael/pub/index.html'
      ```

  - ```javascript
    'use strict';
    
    var
        fs = require('fs'),
        url = require('url'),
        path = require('path'),
        http = require('http');
    
    // 从命令行参数获取root目录，默认是当前目录:
    var root = path.resolve(process.argv[2] || '.');
    
    console.log('Static root dir: ' + root);
    
    // 创建服务器:
    var server = http.createServer(function (request, response) {
        // 获得URL的path，类似 '/css/bootstrap.css':
        var pathname = url.parse(request.url).pathname;
        // 获得对应的本地文件路径，类似 '/srv/www/css/bootstrap.css':
        var filepath = path.join(root, pathname);
        // 获取文件状态:
        fs.stat(filepath, function (err, stats) {
            if (!err && stats.isFile()) {
                // 没有出错并且文件存在:
                console.log('200 ' + request.url);
                // 发送200响应:
                response.writeHead(200);
                // 将文件流导向response:
                fs.createReadStream(filepath).pipe(response);
            } else {
                // 出错了或者文件不存在:
                console.log('404 ' + request.url);
                // 发送404响应:
                response.writeHead(404);
                response.end('404 Not Found');
            }
        });
    });
    
    server.listen(8080);
    
    console.log('Server is running at http://127.0.0.1:8080/');
    ```

  - 在命令行运行`node file_server.js /path/to/dir`

##### TODO:crypto

- 加密算法

#### TODO:Web开发

- CS（client，server）和BS（browser，server）

- > 静态Web页面：由文本编辑器直接编辑并生成静态的HTML页面，如果要修改Web页面的内容，就需要再次编辑HTML源文件，早期的互联网Web页面就是静态的；
  >
  > CGI：由于静态Web页面无法与用户交互，比如用户填写了一个注册表单，静态Web页面就无法处理。要处理用户发送的动态数据，出现了Common Gateway Interface，简称CGI，用C/C++编写。
  >
  > ASP/JSP/PHP：由于Web应用特点是修改频繁，用C/C++这样的低级语言非常不适合Web开发，而脚本语言由于开发效率高，与HTML结合紧密，因此，迅速取代了CGI模式。ASP是微软推出的用VBScript脚本编程的Web开发技术，而JSP用Java来编写脚本，PHP本身则是开源的脚本语言。
  >
  > MVC：为了解决直接用脚本语言嵌入HTML导致的可维护性差的问题，Web应用也引入了Model-View-Controller的模式，来简化Web开发。ASP发展为ASP.Net，JSP和PHP也有一大堆MVC框架。
  >
  > 目前，Web开发技术仍在快速发展中，异步开发、新的MVVM前端技术层出不穷。

- 由于Node.js把JavaScript引入了服务器端，因此也可以使用JavaScript进行web开发了。

- ES7（目前是草案，还没有发布）引入了新的关键字`async`和`await`，可以轻松地把一个function变为异步模式：

  ```
  async function () {
      var data = await fs.read('/file1');
  }
  ```

##### KOA



- 

- 在合适的位置加上：

  ```
  app.use(bodyParser());
  ```

  由于middleware的顺序很重要，这个`koa-bodyparser`必须在`router`之前被注册到`app`对象上。

  

##### MVVM

- 