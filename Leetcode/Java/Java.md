# Java入门

![image-20200903102632814](/home/lemon/Workspace/myCheatSheet/Leetcode/Java/pic/image-20200903102632814.png)

## Java程序基础

### 基本结构

```java
public class Hello {
    public static void main(String[] args) { // 方法名是main
        // 方法代码...
    } // 方法定义结束
}
```

- 注释: 

    ```java
    1:
    //
    2:
    /*
    */
    3:此类注释用于生成文档
    /*
    *
    *
    */
    ```

    ### 变量和数据类型

- 基本数据类型: <img src="/home/lemon/Workspace/myCheatSheet/Leetcode/Java/pic/image-20200903103446286.png" alt="image-20200903103446286" style="zoom:50%;" /><img src="/home/lemon/Workspace/myCheatSheet/Leetcode/Java/pic/image-20200903103524941.png" alt="image-20200903103524941" style="zoom: 50%;" />

    - 整型: Java只定义了带符号的整型.
    - 浮点型: `float`需要带后缀`f`. (`float f2 = 3.14e38f;`)
    - 字符型: 字符类型`char`表示一个字符。Java的`char`类型除了可表示标准的ASCII外，还可以表示一个Unicode字符.

- **除了上述基本类型的变量, 剩余的均为引用类型**.

- 常量: `final double PI = 3.14; // PI是一个常量`

- **var**: 自动类型推导

    - `var sb = new StringBuilder();`

### 运算

- 算数右移: `>>>`(永远直接补零); 逻辑右移:`>>` (高位1不会变)
- 强制转型: `short s = (short) i;`
- `&&, ||, !, A? B:C`

### 字符和字符串

- Java在内存中总是使用**Unicode**表示字符 (两个字节)

    - ```java
        // 注意是十六进制:
        char c3 = '\u0041'; // 'A'，因为十六进制0041 = 十进制65
        ```

- 字符串:

    - 可以直接采用`+`拼接.

    - `"""..."""`可以直接表示*多行字符串*

        - 多行字符串前面共同的空格会被去掉，即：

            ```java
            String s = """
            ...........SELECT * FROM
            ...........  users
            ...........WHERE id > 100
            ...........ORDER BY name DESC
            ...........""";
            ```

    - Java的字符串除了是一个引用类型外，还有个重要特点，就是**字符串不可变**

        - ```java
            String s = "hello";
            s = "world" // 字符串未变,s指向了一个新的字符串
            ```

    - 引用型变量未赋值时为空值: `String s2; // 没有赋初值值，s2是null`

### 数组

- 整体初始化: 

    - ```java
        int[] ns = new int[] { 68, 79, 91, 85, 62 };
        int[] ns = { 68, 79, 91, 85, 62 };
        ```

- 注意当数组中元素为引用类型时(e.g.字符串)的情况.

## 流程控制

### 输入输出

- 输出:
    - `System.out.println()`: 表示输出并换行. (`print`不换行)
    - 格式化输出: `System.out.printf("%.2f\n", d); // 显示两位小数3.14`
        - <img src="/home/lemon/Workspace/myCheatSheet/Leetcode/Java/pic/image-20200903105447328.png" alt="image-20200903105447328" style="zoom:50%;" />

- 输入:

    - ```java
        import java.util.Scanner;
        
        public class Main {
            public static void main(String[] args) {
                Scanner scanner = new Scanner(System.in); // 创建Scanner对象
                String name = scanner.nextLine(); // 读取一行输入并获取字符串
                int age = scanner.nextInt(); // 读取一行输入并获取整数
            }
        }
        ```

### if判断

- 判断浮点数相等用`==`判断不靠谱：`if (Math.abs(x - 0.1) < 0.00001)`
- 判断引用类型相等:
    - `==`是判断**是否指向同一个对象**
    - 要判断引用类型的变量内容是否相等，必须使用`equals()`方法.
        - 要避免`NullPointerException`错误: `if (s1 != null && s1.equals("hello"))`

### switch语句

- 使用`switch`时，如果遗漏了`break`，就会造成严重的逻辑错误，而且不易在源代码中发现错误。从Java 12开始，`switch`语句升级为更简洁的表达式语法，使用类似模式匹配（Pattern Matching）的方法，保证只有一种路径会被执行，并且不需要`break`语句：

    - ```java
        public class Main {
            public static void main(String[] args) {
                String fruit = "apple";
                switch (fruit) {
                case "apple" -> System.out.println("Selected apple");
                case "pear" -> System.out.println("Selected pear");
                case "mango" -> {
                    System.out.println("Selected mango");
                    System.out.println("Good choice!");
                }
                default -> System.out.println("No fruit selected");
                }
            }
        }
        ```

    - 注意新语法使用`->`，如果有多条语句，需要用`{}`括起来。不要写`break`语句，因为新语法只会执行匹配的语句，没有穿透效应。

- 利用新的`switch`语法返回值:

    - ```java
        public class Main {
            public static void main(String[] args) {
                String fruit = "apple";
                int opt = switch (fruit) {
                    case "apple" -> 1;
                    case "pear", "mango" -> 2;
                    default -> 0;
                }; // 注意赋值语句要以;结束
                System.out.println("opt = " + opt);
            }
        }
        ```

    - 当返回值较复杂时: `yield`

        - ```java
            public class Main {
                public static void main(String[] args) {
                    String fruit = "orange";
                    int opt = switch (fruit) {
                        case "apple" -> 1;
                        case "pear", "mango" -> 2;
                        default -> {
                            int code = fruit.hashCode();
                            yield code; // switch语句返回值
                        }
                    };
                    System.out.println("opt = " + opt);
                }
            }
            ```

### while和do while

- ```
    while (条件表达式) {                                do {
        循环语句                                        	执行循环语句
    }                                                  } while (条件表达式); //分号
    ```

### for循环

- `for each`:

    - ```java
        for (int n : ns) {
            System.out.println(n);
        }
        ```

## 数组操作

### 遍历

- 打印数组: Java标准库提供了`Arrays.toString()`，可以快速打印数组内容

    - 对于多维数组: `Arrays.deepToString()`

    - ```java
        import java.util.Arrays;
        
        public class Main {
            public static void main(String[] args) {
                int[] ns = { 1, 1, 2, 3, 5, 8 };
                System.out.println(Arrays.toString(ns));
            }
        }
        // [1, 1, 2, 3, 5, 8]
        ```

0 0 0 0 0 0 2 0 4 6 0 8 0 10 12 14 0 16 0 0 2 20 22 0

0 0 0 0 0 0 2 0 4 0 0 2 0 4 0 0 0 2 0 0 2 0 0 0  

### 排序

- `Arrays.sort(myArray);` : `myArray`自身被修改.

- 自定义`Comparator`: 

    - `public static void sort(T[] a,int fromIndex,int toIndex, Comparator c)`: [from, to)

    - ```java
        package test;
        
        import java.util.Arrays;
        import java.util.Comparator;
        
        public class Main {
            public static void main(String[] args) {
                //注意，要想改变默认的排列顺序，不能使用基本类型（int,double, char）
                //而要使用它们对应的类
                Integer[] a = {9, 8, 7, 2, 3, 4, 1, 0, 6, 5};
                //定义一个自定义类MyComparator的对象
                Comparator cmp = new MyComparator();
                Arrays.sort(a, cmp);
                for(int i = 0; i < a.length; i ++) {
                    System.out.print(a[i] + " ");
                }
            }
        }
        //Comparator是一个接口，所以这里我们自己定义的类MyComparator要implents该接口
        //而不是extends Comparator
        class MyComparator implements Comparator<Integer>{
            @Override
            public int compare(Integer o1, Integer o2) {
                //正数: o1比o2大;
                if(o1 < o2) { 
                    return 1;
                }else if(o1 > o2) {
                    return -1;
                }else {
                    return 0;
                }
            }
        }
        ```

# 面向对象编程

## 面向对象的基础

```java
Person ming = new Person();
```

- 注意区分`Person ming`是定义`Person`类型的变量`ming`，而`new Person()`是创建`Person`实例。

### 方法

- 在方法内部，可以使用一个隐含的变量`this`，它始终指向当前实例。因此，通过`this.field`就可以访问当前实例的字段。如果没有命名冲突，可以省略`this`

- 可变参数:

    - 可变参数用`类型...`定义，可变参数相当于数组类型：

    - ```java
        class Group {
            private String[] names;
        
            public void setNames(String... names) {
                this.names = names;
            }
        }
        ```

    - 使用可变参数时**可以保证无法传入`null`**: 因为传入0个参数时，接收到的实际值是一个空数组而不是`null`

- 参数传递时: 注意是基本类型还是引用类型.

- 构造函数: 

    - ```java
        public Person() {
        } //当你显示定义了,编译器就不会为这个类增加默认构造函数了
        ```

- 方法重载:

    - 名字, 返回值相同, 参数不同.

### 继承

- 默认继承的是`Object`类

`class Student extends Person`

- :warning: 子类自动获得了父类的所有字段，**严禁定义与父类重名的字段**！

- `protected`: 子类无法访问父类的`private`字段或者`private`方法; 但`protected`可以.

- `super`: 

    - 往往不是必须的, 除非涉及到构造函数.
    - 在Java中，任何`class`的构造方法，第一行语句必须是调用父类的构造方法。如果没有明确地调用父类的构造方法，编译器会帮我们自动加一句`super();`
    - 子类*不会继承*任何父类的构造方法。子类默认的构造方法是编译器自动生成的，不是继承的。

- 向上转型:

    - ```java
        Student s = new Student();
        Person p = s; // upcasting, ok
        ```

- 向下转型:

    - ```java
        Person p1 = new Student(); // upcasting, ok
        Person p2 = new Person();
        Student s1 = (Student) p1; // ok
        Student s2 = (Student) p2; // runtime error! ClassCastException!
        ```

    - 使用`instanceof`先做判断

### 多态

- 重载`overload` <-> 覆写`override` (函数参数也一样)

    - `@Override`

- > 一个实际类型为`Student`，引用类型为`Person`的变量，调用其`run()`方法，实际上调用的方法是`Student`的`run()`方法。

    - Java的实例方法调用是基于**运行时**的实际类型的动态调用，而非变量的声明类型。
    - 所以`Person`和`Student`都必须要有`run()`, 否则编译时报错.

- Override Object类的方法

    - `toString()`：把instance输出为`String`；
    - `equals()`：判断两个instance是否逻辑相等；
    - `hashCode()`：计算一个instance的哈希值。

- 调用super

    - 在子类的覆写方法中，如果要调用父类的被覆写的方法，可以通过`super`来调用.

- final:

    - 如果一个父类不允许子类对它的某个方法进行覆写，可以把该方法标记为`final`
    - 如果一个类不希望任何其他类继承自它，那么可以把这个类本身标记为`final`
    - 用`final`修饰的字段在初始化后不能被修改

### 抽象类

```java
abstract class Person { //抽象类不能实例化, 但是可以 Person p = new Student();
    public abstract void run(); //这类方法只有在子类中被覆写了才有意义
}
```

### 接口

- `interface`可以被理解为一个纯抽象类: (若干个抽象方法的签名)

    - 不能有实例字段`field`

    - 所有方法默认都是`public abstract` (所以这两个修饰符不用显式写出)

    - ```java
        interface Person {
            void run();
            String getName();
        }
        ```

- 一个类可以实现(`@Override`)多个接口

    - 接口也可以继承
    - <img src="/home/lemon/Workspace/myCheatSheet/Leetcode/Java/pic/image-20200903141950757.png" alt="image-20200903141950757" style="zoom:80%;" />

- 在使用的时候，实例化的对象永远只能是某个具体的子类，但总是**通过接口去引用**它.

    - 可以用一个接口变量指向一个实例.

- `default`方法

    - ```java
        interface Person {
            String getName();
            default void run() {
                System.out.println(getName() + " run");
            }
        }
        ```

    - 实现类可以不必覆写`default`方法

    - `default`方法和抽象类的普通方法是有所不同的。因为`interface`没有字段，`default`方法无法访问字段，而抽象类的普通方法可以访问实例字段。

### 静态字段和静态方法

- `static`字段属于这个类 (`类名.静态字段`)
- `static`方法不属于实例, 没有`this`变量, 无法访问实例字段，只能访问静态字段.
- 接口的静态字段:
    - `interface`是一个纯抽象类，所以它不能定义实例字段。但是，`interface`是可以有静态字段的，并且静态字段必须为`final`类型. (`public static final` -> 可以不写, 编译器会自动加上)

### 包

Java定义了一种名字空间，称之为包：`package`。一个类总是属于某个包，类名（比如`Person`）只是一个简写，真正的完整类名是`包名.类名`。

- 在定义`class`的时候，我们需要在第一行声明这个`class`属于哪个包。

    - ```java
        package ming; // 申明包名ming
        
        public class Person {
        }
        ```

- :warning:要特别注意：包没有父子关系。java.util和java.util.zip是不同的包，两者没有任何继承关系。

- 包作用域

    - 位于同一个包的类，可以访问包作用域的字段和方法。不用`public`、`protected`、`private`修饰的字段和方法就是包作用域。

    - ```java
        //file1
        package hello;
        
        public class Person {
            // 包作用域:
            void hello() {
                System.out.println("Hello!");
            }
        }
        
        // file2
        package hello;
        
        public class Main {
            public static void main(String[] args) {
                Person p = new Person();
                p.hello(); // 可以调用，因为Main和Person在同一个包
            }
        }
        ```

- 调用某个类的两种方法:

    - 直接写出完整类名: `mr.jun.Arrays arrays = new mr.jun.Arrays();`
    - `import`: `import mr.jun.Arrays; Arrays arrays = new Arrays();`
        - 在写`import`的时候，可以使用`*`，表示把这个包下面的所有`class`都导入进来 (但不包括子包的`class`): 不推荐
        - `import static`可以导入可以导入一个类的静态字段和静态方法 (很少用)

- `import`的查找顺序:

    - <img src="/home/lemon/Workspace/myCheatSheet/Leetcode/Java/pic/image-20200903143327628.png" alt="image-20200903143327628" style="zoom:50%;" />

- 注意：

    - ![image-20200903143410969](/home/lemon/Workspace/myCheatSheet/Leetcode/Java/pic/image-20200903143410969.png)

### 作用域

- `public`:

    - 定义为`public`的`class`、`interface`可以被任何包中的任何类访问.
    - 定义为`public`的`field`、`method`可以被其他类访问，前提是首先有访问`class`的权限

- `private`:

    - 定义为`private`的`field`、`method`无法被其他类访问.

    - > 实际上，确切地说，`private`访问权限被限定在`class`的内部，而且与方法声明顺序*无关*。推荐把`private`方法放到后面，因为`public`方法定义了类对外提供的功能，阅读代码的时候，应该先关注`public`方法

    - 如果一个类内部还定义了嵌套类，那么，嵌套类拥有访问`private`的权限

- `protected`:

    - 定义为`protected`的字段和方法可以被子类访问，以及子类的子类. (即便在不同的包中)

- `package`:

    - 最后，包作用域是指一个类允许访问同一个`package`的没有`public`、`private`修饰的`class`，以及没有`public`、`protected`、`private`修饰的字段和方法。

- :warning: 一个`.java`文件只能包含<font color="red">一个</font>`public`类，但可以包含多个非`public`类。如果有`public`类，文件名必须和`public`类的名字相同。

### TODO: classpath和jar

### TODO: 模块

## Java核心类 `java.lang`

### 字符串和编码

- 字符串是不可变的, 判等得用`equals` / `equalsIgnoreCase()`

    - 不可变所以像`s.toUpperCase` / `s.trim`都不是修改`s`, 而是返回一个新的字符串 (所以要`s = s.trim()`)

- 搜索子串:

    - ```java
        // 是否包含子串:
        "Hello".contains("ll"); // true
        "Hello".indexOf("l"); // 2
        "Hello".lastIndexOf("l"); // 3
        "Hello".startsWith("He"); // true
        "Hello".endsWith("lo"); // true
        ```

- 提取子串: `s.substring(l,r)` : [l,r) (注意都是小写, 这是一个词)

- 去除首尾空白字符: 空白字符包括空格，`\t`，`\r`，`\n` (:warning: 不包括" ")

    - `trim`; `strip` 
      
        - `strip`和`trim`不同的是，类似中文的空格字符`\u3000`也会被移除
        
    - 去除头部空白

        - ```java
            str = str.replaceFirst("^ *", "");
            ```

- 判断是否为空: `isEmpty()`和`isBlank()`

    - ```java
        "".isEmpty(); // true，因为字符串长度为0
        "  ".isEmpty(); // false，因为字符串长度不为0
        "  \n".isBlank(); // true，因为只包含空白字符
        " Hello ".isBlank(); // false，因为包含非空白字符
        s.length() == 0;
        ```

- 替换子串:

    - <font color="red">`replace`中参数是子串; `replaceFirst`或`replaceAll`参数才能用正则</font>

    - - ```java
            String s = "hello";
            s.replace('l', 'w'); // "hewwo"，所有字符'l'被替换为'w'
            String s = "A,,B;C ,D";
            s.replaceAll("[\\,\\;\\s]+", ","); // "A,B,C,D"
        ```

    - **java正则中**: `\s`表示空白字符; `\S`表示非空白字符

- 分割字符串:

    - ```java
        String s = "A,B,C,D";
        String[] ss = s.split("\\,"); // {"A", "B", "C", "D"}
        ```

- 字符串拼接:

    - ```java
        String[] arr = {"A", "B", "C"};
        String s = String.join("***", arr); // "A***B***C"
        ```

- 格式化字符串:

    - 字符串提供了`formatted()`方法和`format()`静态方法，可以传入其他参数，替换占位符，然后生成新的字符串

    - ```java
        public class Main {
            public static void main(String[] args) {
                String s = "Hi %s, your score is %d!";
                System.out.println(s.formatted("Alice", 80));
                System.out.println(String.format("Hi %s, your score is %.2f!", "Bob", 59.5));
            }
        }
        ```

- 类型转换:

    - 任何类型转为`String`:

        - ```java
            String.valueOf(123); // "123"
            String.valueOf(45.67); // "45.67"
            String.valueOf(true); // "true"
            String.valueOf(new Object()); // 类似java.lang.Object@636be97c
            String.valueOf('1');
            ```

    - `String`转化为其他类型:

        - ```java
            int n1 = Integer.parseInt("123"); // 123
            int n2 = Integer.parseInt("ff", 16); // 按十六进制转换，255
            boolean b1 = Boolean.parseBoolean("true"); // true
            boolean b2 = Boolean.parseBoolean("FALSE"); // false
            ```

        - 要特别注意，`Integer`有个`getInteger(String)`方法，它不是将字符串转换为`int`，而是把该字符串对应的系统变量转换为`Integer`:

            - ```java
                Integer.getInteger("java.version"); // 版本号，11
                ```

    - 转化为`char[]`:

        - ```java
            char[] cs = "Hello".toCharArray(); // String -> char[]
            String s = new String(cs); // char[] -> String
            ```

        - 如果修改了`char[]`数组，`String`并不会改变: 

            - 这是因为通过`new String(char[])`创建新的`String`实例时，它并不会直接引用传入的`char[]`数组，而是会**复制一份**，所以，修改外部的`char[]`数组不会影响`String`实例内部的`char[]`数组，因为这是两个不同的数组。

        - `String`是不可修改的, 所以不存在修改`String`看`char[]`会不会变化的问题.
        
    - 获取`char`

        - `s.charAt(index)`;
        - `s.deleteCharAt(index)`
        - `indexOf`; `contains`

- TODO字符编码

### StringBuilder

- 直接使用`String`拼接时每次循环都会创建新的字符串对象，然后扔掉旧的字符串 (耗内存; 慢)

- `StringBuilder`是一个可变对象，可以预分配缓冲区，这样，往`StringBuilder`中新增字符时，不会创建新的临时对象;

    - ```java
        StringBuilder sb = new StringBuilder(1024);
        sb.append(',');
        sb.append("Mr ")
                  .append("Bob")
                  .append("!"); //链式操作
        sb.delete(sb.length()-1, sb.length()); //delete '!'
        String s = sb.toString();
        
        ```

// add to front
        sb.insert(0, Integer.toString(i)); //这样会使得StringBuilder没用了.
        ```
        
    - > 进行链式操作的关键是，定义的`append()`方法会返回`this`，这样，就可以不断调用自身的其他方法。

### StringJoiner

`import java.util.StringJoiner`

- 需要指定开头和结尾时:

    - ```java
        public class Main {
            public static void main(String[] args) {
                String[] names = {"Bob", "Alice", "Grace"};
                var sj = new StringJoiner(", ", "Hello ", "!"); //开头结尾是"Hello "和"!"
                for (String name : names) {
                    sj.add(name);
                }
                System.out.println(sj.toString());
            }
        }
        ```

- 不需要指定时:

    - ```java
        String[] names = {"Bob", "Alice", "Grace"};
        var s = String.join(", ", names);
        ```

### 包装类型

> 引用类型可以赋值为`null`，表示空，但基本类型不能赋值为`null`, 那么，如何把一个基本类型视为对象(引用类型)?
>
> 比如，想要把`int`基本类型变成一个引用类型，我们可以定义一个`Integer`类，它只包含一个实例字段`int`，这样，`Integer`类就可以视为`int`的包装类（Wrapper Class）

- ```java
    public class Integer {
        private int value;
    
        public Integer(int value) {
            this.value = value;
        }
    
        public int intValue() {
            return this.value;
        }
    }
    
    Integer n = null;
    Integer n2 = new Integer(99);
    int n3 = n2.intValue();
    n = Integer.valueOf(n3);
    ```

- `Auto Boxing`:

    - ```java
        nteger n = 100; // 编译器自动使用Integer.valueOf(int)
        int x = n; // 编译器自动使用Integer.intValue()
        ```

    - 这种直接把`int`变为`Integer`的赋值写法，称为自动装箱（Auto Boxing），反过来，把`Integer`变为`int`的赋值写法，称为自动拆箱（Auto Unboxing）。

    - 装箱和拆箱会影响代码的执行效率，因为编译后的`class`代码是严格区分基本类型和引用类型的。并且，自动拆箱执行时可能会报`NullPointerException`.

- **不变类**: 所有的包装类型都是**不变类**. ([here](https://stackoverflow.com/questions/16903637/i-still-working-for-immutable-integer-in-java))

    - ```java
        class Playground {
            public static void main(String[] args) {
                Integer n = Integer.valueOf(10);
                test(n);
                System.out.println(n); // 10
            }
            
            private static void test(Integer p) {
                // actually compiled to n = Integer.valueOf(100)
                // 相当于参数中的引用p已经指向了新的Integer实例
                p = 100; 
                
            }
        }
        ```

    - 对于引用重新赋值 != 修改引用指向的实例:

        - ```java
            A a1 = new A();
            A a2 = a1;
            System.out.println(a1);
            System.out.println(a2);
            a2 = new A();
            System.out.println(a1);
            System.out.println(a2);
            /*
            A@33909752
            A@33909752
            A@33909752
            A@55f96302
            */
            ```

    - :warning:对两个`Integer`实例进行比较要特别注意：绝对不能用`==`比较，因为`Integer`是引用类型，必须使用`equals()`比较.

- **内存优化**:

    - 方法1：`Integer n = new Integer(100);`
    - 方法2：`Integer n = Integer.valueOf(100);`

    方法2更好，因为方法1总是创建新的`Integer`实例，方法2把内部优化留给`Integer`的实现者去做.

- **进制转换**:

    - ```java
        int x1 = Integer.parseInt("100"); // 100
        int x2 = Integer.parseInt("100", 16); // 256,因为按16进制解析
        System.out.println(Integer.toString(100)); // "100",表示为10进制
        System.out.println(Integer.toString(100, 36)); // "2s",表示为36进制
        System.out.println(Integer.toHexString(100)); // "64",表示为16进制
        System.out.println(Integer.toOctalString(100)); // "144",表示为8进制
        System.out.println(Integer.toBinaryString(100)); // "1100100",表示为2进制
        ```

- **有用的静态变量**:

    - ```java
        // boolean只有两个值true/false，其包装类型只需要引用Boolean提供的静态字段:
        Boolean t = Boolean.TRUE;
        Boolean f = Boolean.FALSE;
        // int可表示的最大/最小值:
        int max = Integer.MAX_VALUE; // 2147483647
        int min = Integer.MIN_VALUE; // -2147483648
        // long类型占用的bit和byte数量:
        int sizeOfLong = Long.SIZE; // 64 (bits)
        int bytesOfLong = Long.BYTES; // 8 (bytes)
        ```

- **类型转换**:

    - ```javascript
        // 向上转型为Number: 整数和浮点数的包装类型都继承自Number
        Number num = new Integer(999);
        // 获取byte, int, long, float, double:
        byte b = num.byteValue();
        int n = num.intValue();
        long ln = num.longValue();
        float f = num.floatValue();
        double d = num.doubleValue();
        ```

- **无符号整型**:

    - 符号整型和有符号整型的转换在Java中就需要借助包装类型的静态方法完成。

    - ```java
        public class Main {
            public static void main(String[] args) {
                byte x = -1;
                byte y = 127;
                System.out.println(Byte.toUnsignedInt(x)); // 255
                System.out.println(Byte.toUnsignedInt(y)); // 127
            }
        }
        
        ```

        - 类似的，可以把一个`short`按unsigned转换为`int`，把一个`int`按unsigned转换为`long`。

### TODO JavaBean

### TODO 枚举类

```java
public class Main {
    public static void main(String[] args) {
        Weekday day = Weekday.SUN;
        if (day == Weekday.SAT || day == Weekday.SUN) {
            System.out.println("Work at home!");
        } else {
            System.out.println("Work at office!");
        }
    }
}

enum Weekday {
    SUN, MON, TUE, WED, THU, FRI, SAT;
}
```

- 引用类型比较，要始终使用`equals()`方法，但`enum`类型可以例外。
    - 这是因为`enum`类型的每个常量在JVM中只有一个**唯一实例**，所以可以直接用`==`比较.

### TODO 记录类

### BigInteger

> `java.math.BigInteger`就是用来表示任意大小的整数

- 对`BigInteger`做运算的时候，只能使用实例方法，例如，加法运算:

    - ```java
        import java.math.BigInteger;
        BigInteger i1 = new BigInteger("1234567890", 10); //10进制
        BigInteger i2 = new BigInteger("12345678901234567890");
        BigInteger sum = i1.add(i2); // 12345678902469135780
        sum.toString(2); //转为2进制String
        ```

- 转换:

    > - 转换为`byte`：`byteValue()`
    > - 转换为`short`：`shortValue()`
    > - 转换为`int`：`intValue()`
    > - 转换为`long`：`longValue()`
    > - 转换为`float`：`floatValue()`
    > - 转换为`double`：`doubleValue()`

    - 通过上述方法，可以把`BigInteger`转换成基本类型。如果`BigInteger`表示的范围**超过了基本类型的范围**，转换时将丢失高位信息，即结果不一定是准确的。如果需要**准确地转换**成基本类型，可以使用`intValueExact()`、`longValueExact()`等方法，在转换时如果超出范围，将直接**抛出`ArithmeticException`异常**。
    
- 比较: `.compareTo()`

    - <img src="/home/lemon/Workspace/myCheatSheet/Leetcode/Java/pic/image-20200904150042091.png" alt="image-20200904150042091" style="zoom: 50%;" />

### BigDecimal

> `BigDecimal`可以表示一个任意大小且精度完全准确的浮点数。

- 表示小数位数:

    - `BigDecimal`用`scale()`表示小数位数:

        - ```java
            BigDecimal d1 = new BigDecimal("123.45");
            BigDecimal d2 = new BigDecimal("123.4500");
            BigDecimal d3 = new BigDecimal("1234500");
            System.out.println(d1.scale()); // 2,两位小数
            System.out.println(d2.scale()); // 4
            System.out.println(d3.scale()); // 0
            ```

    - 通过`BigDecimal`的`stripTrailingZeros()`方法，可以将一个`BigDecimal`格式化为一个相等的，但去掉了末尾0的`BigDecimal`:

        - ```java
            BigDecimal d1 = new BigDecimal("123.4500");
            BigDecimal d2 = d1.stripTrailingZeros();
            System.out.println(d1.scale()); // 4
            System.out.println(d2.scale()); // 2,因为去掉了00
            
            BigDecimal d3 = new BigDecimal("1234500");
            BigDecimal d4 = d3.stripTrailingZeros();
            System.out.println(d3.scale()); // 0 //整数位的0也会去掉
            System.out.println(d4.scale()); // -2 // 如果一个BigDecimal的scale()返回负数，例如，-2，表示这个数是个整数，并且末尾有2个0。
            ```

    - 设置精度:

        - ```java
            BigDecimal d1 = new BigDecimal("123.456789");
            BigDecimal d2 = d1.setScale(4, RoundingMode.HALF_UP); // 四舍五入，123.4568
            BigDecimal d3 = d1.setScale(4, RoundingMode.DOWN); // 直接截断，123.4567
            ```

- 运算: 对`BigDecimal`做加、减、乘时，精度不会丢失，但是做除法时，存在无法除尽的情况，这时，就必须**指定精度以及如何进行截断**:

    - ```java
        BigDecimal d1 = new BigDecimal("123.456");
        BigDecimal d2 = new BigDecimal("23.456789");
        BigDecimal d3 = d1.divide(d2, 10, RoundingMode.HALF_UP); // 保留10位小数并四舍五入
        BigDecimal d4 = d1.divide(d2); // 报错：ArithmeticException，因为除不尽
        ```

    - 还可以对`BigDecimal`做除法的同时求余数:

        - ```java
            public class Main {
                public static void main(String[] args) {
                    BigDecimal n = new BigDecimal("12.345");
                    BigDecimal m = new BigDecimal("0.12");
                    BigDecimal[] dr = n.divideAndRemainder(m);
                    System.out.println(dr[0]); // 102
                    System.out.println(dr[1]); // 0.105
                }
            }
            ```

        - 我们可以利用这个方法判断两个`BigDecimal`是否是整数倍数:

            - ```java
                BigDecimal n = new BigDecimal("12.75");
                BigDecimal m = new BigDecimal("0.15");
                BigDecimal[] dr = n.divideAndRemainder(m);
                if (dr[1].signum() == 0) { // 返回此BigInteger的函数正负号 (1, -1, 0)
                    // n是m的整数倍
                }
                ```

- 比较:

    - 在比较两个`BigDecimal`的值是否相等时，要特别注意，使用`equals()`方法不但要求两个`BigDecimal`的值相等，还要求它们的`scale()`相等
    - **必须使用`compareTo()`方法来比较，它根据两个值的大小分别返回负数、正数和`0`，分别表示小于、大于和等于。**

- `BigDecimal`也是从`Number`继承的，也是不可变对象。

### TODO 常用工具类

- Math; Random; SecureRandom

- `Character.isDigit(arr[i])`: 判断是否为数字

- ```
    Random r = new Random();
    r.nextInt(); // 2071575453,每次都不一样
    r.nextInt(10); // 5,生成一个[0,10)之间的int
    r.nextLong(); // 8811649292570369305,每次都不一样
    r.nextFloat(); // 0.54335...生成一个[0,1)之间的float
    r.nextDouble(); // 0.3716...生成一个[0,1)之间的double
    ```

    

# 集合

<img src="/home/lemon/Workspace/myCheatSheet/Leetcode/Java/pic/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzMxODE1NTA3,size_16,color_FFFFFF,t_70" alt="img" style="zoom:67%;" />

- Java标准库自带的`java.util`包提供了集合类：`Collection`，它是除`Map`外所有其他集合类的根接口。Java的`java.util`包主要提供了以下三种类型的集合：
    - `List`：一种有序列表的集合，例如，按索引排列的`Student`的`List`；
    - `Set`：一种保证没有重复元素的集合，例如，所有无重复名称的`Student`的`Set`；
    - `Map`：一种通过键值（key-value）查找的映射表集合，例如，根据`Student`的`name`查找对应`Student`的`Map`。
- Java集合设计的特点: 
    - 接口和实现类相分离，例如，有序表的接口是`List`，具体的实现类有`ArrayList`，`LinkedList`等
    - 支持泛型
    - Java访问集合总是通过统一的方式——迭代器（Iterator）来实现，它最明显的好处在于无需知道集合内部元素是按什么方式存储的
- ![image-20200903170549631](/home/lemon/Workspace/myCheatSheet/Leetcode/Java/pic/image-20200903170549631.png)

## List

- `List`是一类基础接口, 实现有`ArrayList`(数组实现)和`LinkedList` (链表实现):

    - <img src="/home/lemon/Workspace/myCheatSheet/Leetcode/Java/pic/image-20200903171135848.png" alt="image-20200903171135848" style="zoom: 67%;" />
    - ![image-20200903171200635](/home/lemon/Workspace/myCheatSheet/Leetcode/Java/pic/image-20200903171200635.png)

### 基础操作

- `add(E e)`; `add(int index, E e)`; `contains(E e)`; `indexOf(E e)`; `remove(int index)`; `remove(E e)`; `removeAll(E e)`;
    
- 默认加到队尾; `indexOf`不存在返回-1; 
    
- `List`的创建:

    - 直接创建`ArrayList` or `LinkedList`.
    - `List<Integer> list = List.of(1, 2, 5);` 不支持传入`null`, 但是`list.add()`可以添加`null`.

- 遍历`List`:

    - 可以通过`for`循环和`get()`, 但是这样对于`LinkedList`会很耗时.

    - **推荐使用迭代器**:

        - ```java
            import java.util.Iterator;
            import java.util.List;
            public class Main {
                public static void main(String[] args) {
                    List<String> list = List.of("apple", "pear", "banana");
                    for (Iterator<String> it = list.iterator(); it.hasNext(); ) {
                        String s = it.next();
                        System.out.println(s);
                    }
                }
            }
            
            //这样也是迭代器遍历
            //只要实现了Iterable接口的集合类都可以直接用for each循环来遍历
            for (String s : list) {
                System.out.println(s);
            }
            ```

    - 使用迭代器是无法直接修改元素的:

        - ```java
            Iterator iterator = list.iterator();
            while (iterator.hasNext()) {
            	Object element = iterator.next();
            	if ("riemann".equals(element)) {
            	int index = list.indexOf(element);
            	list.set(index,"riemannUpdate");
            }
            ```


### List和数组的转换

**List转数组**

- (depreciated) `Object[] array = list.toArray();` (会丢失类型信息)

- 给`toArray(T[])`传入一个类型相同的`Array`，`List`内部自动把元素复制到传入的`Array`中

    - ```java
        Integer[] array = list.toArray(new Integer[list.size()]);
        Integer[] array = list.toArray(Integer[]::new);
        ```

    - 如果传入的数组不够大，那么`List`内部会创建一个新的刚好够大的数组，填充后返回；如果传入的数组比`List`元素还要多，那么填充完元素后，剩下的数组元素一律填充`null`。

**数组转List**

- ```java
    Integer[] array = { 1, 2, 3 };
    List<Integer> list = List.of(array);
    ```

    - 对于JDK 11之前的版本，可以使用`Arrays.asList(T...)`方法把数组转换成`List`。
    - 要注意的是，返回的`List`不一定就是`ArrayList`或者`LinkedList`，因为`List`只是一个接口，如果我们调用`List.of()`，它返回的是一个**只读**`List`
        - 只读: 可以对元素进行读取 / 覆盖; 不允许调用`add / remove`等操作

- 扩展阅读: **数组转ArrayList**:

    - stackoverflow: [1](https://stackoverflow.com/questions/16748030/difference-between-arrays-aslistarray-and-new-arraylistintegerarrays-aslist); [2](https://stackoverflow.com/questions/5134466/how-to-cast-arraylist-from-list/41136009)

    - ```java
        1.List<Integer> list1 = new ArrayList<Integer>(List.of(array));  //copy
        2.List<Integer> list2 = Arrays.asList(array); //reference
        ```

    - 方法1中, 相当于拷贝了一份数据到`ArrayList`中, 改变`ArrayList`不会影响原数据

        - `ArrayList<Integer> list1 = ((ArrayList<Integer>) List.of(array))`或 `ArrayList<Integer> list1 = new ArrayList<Integer>(array)`都是非法的.
            - 前者非法是因为你不知道这个`List<>`到底是指向了什么实例, 所以你也就不能将其向下类型转换; 后者非法是因为`ArrayList`没有这个构造函数.

    - 方法2中, `Arrays.asList`相当于返回了对`array`的一个实现了`List`接口的`wrapper`, *which makes the original array available as a list.* 但这个`wrapper`是受限的, *some `List` operations aren't allowed on the wrapper, like adding or removing elements from the list, you can only read or overwrite the elements.*

    - e.g. `String`转`ArrayList`: `ArrayList<String> list = new ArrayList<String> (List.of(s.split("")));`

### List初始化

- 初始化某一特定值:
    - `Arrays.fill(array, -1);`
- 初始化size:
    - 只能一次一次往里加: 
        - `while(arr.size() < 10) arr.add(0);`
    - 数组可以初始化size: `int [] a = new int[10];`
    - `new ArrayList(10); //10是capacity`
- `multi-dimensional collections`:
    - 最好用数组.

### 编写equals方法

- `List`中`indexOf`和`contains`都是根据`equals`进行判断的.
- ![image-20200904132020053](/home/lemon/Workspace/myCheatSheet/Leetcode/Java/pic/image-20200904132020053.png)
- ![image-20200904132110085](/home/lemon/Workspace/myCheatSheet/Leetcode/Java/pic/image-20200904132110085.png)

## Map

- 基础操作: `put(K key, V value)`, `V get(K key)`, `boolean containsKey(K key)`, `remove(K key)`

    - `Map<String, Integer> map = new HashMap<>();`

- 遍历:

    - ```java
        for (String key : map.keySet()) {
            Integer value = map.get(key);
            System.out.println(key + " = " + value);
        }
        
        map.values() //获取所有值
        
        for (Map.Entry<String, Integer> entry : map.entrySet()) {
        	String key = entry.getKey();
        	Integer value = entry.getValue();
        	System.out.println(key + " = " + value);
        }
        ```

    - :warning:遍历Map时，不可假设输出的key是有序的!

### TODO 编写equals和hashCode

> `HashMap`之所以能根据`key`直接拿到`value`，原因是它内部通过空间换时间的方法，用一个大数组存储所有`value`，并根据key直接计算出`value`应该存储在哪个索引
>
> - key -> hashCode找到对应的Value cell
> - 通过比较key和Value cell中存的key, 判断是否命中.

### Initialization

- [here](https://stackoverflow.com/questions/6802483/how-to-directly-initialize-a-hashmap-in-a-literal-way)

- ```java
    For Java Version 9 or higher:
    // this works for any number of elements:
    import static java.util.Map.entry;    
    Map<String, String> test2 = Map.ofEntries(
        entry("a", "b"),
        entry("c", "d")
    );
    ```

- ```java
    For up to Java Version 8:
    Map<String, String> myMap = new HashMap<String, String>() {{
        put("a", "b");
        put("c", "d");
    }};
    ```

- `getOrDefault`

    - ```java
        HashMap<String, Integer> allWords = new HashMap<String, Integer>();
        for (String w : words) {
        	int value = allWords.getOrDefault(w, 0);
            allWords.put(w, value + 1);
        }
        ```

### EnumMap

- 如果作为key的对象是`enum`类型，那么，还可以使用Java集合库提供的一种`EnumMap`，它在内部以一个非常紧凑的数组存储value，并且根据`enum`类型的key直接定位到内部数组的索引，并不需要计算`hashCode()`，不但效率最高，而且没有额外的空间浪费。

- ```java
    public class Main {
        public static void main(String[] args) {
            Map<DayOfWeek, String> map = new EnumMap<>(DayOfWeek.class);
            map.put(DayOfWeek.MONDAY, "星期一");
            map.put(DayOfWeek.TUESDAY, "星期二");
            map.put(DayOfWeek.WEDNESDAY, "星期三");
            map.put(DayOfWeek.THURSDAY, "星期四");
            map.put(DayOfWeek.FRIDAY, "星期五");
            map.put(DayOfWeek.SATURDAY, "星期六");
            map.put(DayOfWeek.SUNDAY, "星期日");
            System.out.println(map);
            System.out.println(map.get(DayOfWeek.MONDAY));
        }
    }
    ```

    - 使用`EnumMap`的时候，我们总是用`Map`接口来引用它，因此，实际上把`HashMap`和`EnumMap`互换，在客户端看来没有任何区别。

### TODO TreeMap

- ![image-20200904135931380](/home/lemon/Workspace/myCheatSheet/Leetcode/Java/pic/image-20200904135931380.png)

- > 一般的`HashMap`在内部是不会对`Key`进行排序的, 但还有一种`Map`，它在内部会对Key进行排序，这种`Map`就是`SortedMap`。注意到`SortedMap`是接口，它的实现类是`TreeMap`

- 作为`SortedMap`的Key必须实现`Comparable`接口，或者传入`Comparator`；

    - ```java
        Map<Student, Integer> map = new TreeMap<>(new Comparator<Student>() {
        	public int compare(Student p1, Student p2) {
        		if (p1.score == p2.score) {
                	return 0;
                }
                	return p1.score > p2.score ? -1 : 1;
            }
        });
        ```

    - 要严格按照`compare()`规范实现比较逻辑(返回1,0,-1)，否则，`TreeMap`将不能正常工作。

## TODO Properties

## Set

- <img src="/home/lemon/Workspace/myCheatSheet/Leetcode/Java/pic/image-20200904140211341.png" alt="image-20200904140211341" style="zoom: 67%;" />
- 放入`Set`的元素和`Map`的key类似，都要正确实现`equals()`和`hashCode()`方法，否则该元素无法正确地放入`Set`。
- 最常用的`Set`实现类是`HashSet`. 最常用的有序`Set`实现是`TreeSet`
    - ![image-20200904140417008](/home/lemon/Workspace/myCheatSheet/Leetcode/Java/pic/image-20200904140417008.png)
    - 使用`TreeSet`和使用`TreeMap`的要求一样，添加的元素必须正确实现`Comparable`接口，如果没有实现`Comparable`接口，那么创建`TreeSet`时必须传入一个`Comparator`对象。

## Queue

- ![image-20200904140827543](/home/lemon/Workspace/myCheatSheet/Leetcode/Java/pic/image-20200904140827543.png)
    
- 注意：**不要把`null`添加到队列中**，否则`poll()`方法返回`null`时，很难确定是取到了`null`元素还是队列为空。
    
- `LinkedList`即实现了`List`接口，又实现了`Queue`接口，但是，在使用的时候，如果我们把它当作List，就获取List的引用，如果我们把它当作Queue，就获取Queue的引用：

    ```java
    // 这是一个List:
    List<String> list = new LinkedList<>();
    // 这是一个Queue:
    Queue<String> queue = new LinkedList<>();
    ```

    始终按照面向抽象编程的原则编写代码，可以大大提高代码的质量。

### Priority Queue

- `PriorityQueue`和`Queue`的区别在于，它的出队顺序与元素的优先级有关，对`PriorityQueue`调用`remove()`或`poll()`方法，返回的总是优先级最高的元素。

- 因此，放入`PriorityQueue`的元素，必须实现`Comparable`接口，`PriorityQueue`会根据元素的排序顺序决定出队的优先级。否则需要提供一个`Comparator`对象来判断两个元素的顺序

    - ```java
        import java.util.Comparator;
        import java.util.PriorityQueue;
        import java.util.Queue;
        public class Main {
            public static void main(String[] args) {
                Queue<User> q = new PriorityQueue<>(new UserComparator());
            }
        }
        
        class UserComparator implements Comparator<User> {
            public int compare(User u1, User u2) {
        		//比较逻辑
            }
        }
        ```

### Deque

- `Deque`是双向队列: (同样的, 避免把`null`添加到队列)
    
- ![image-20200904141828994](/home/lemon/Workspace/myCheatSheet/Leetcode/Java/pic/image-20200904141828994.png)
    
- **`Deque`是接口不是实现**, 是扩展自`Queue`的接口, 因此，`Queue`提供的`add()`/`offer()`方法在`Deque`中也可以使用，但是，使用`Deque`，最好不要调用`offer()`，而是调用`offerLast()`;

- <font color="red">`Deque`是一个接口，它的实现类有`ArrayDeque`和`LinkedList`。</font>

- > 我们发现`LinkedList`真是一个全能选手，它即是`List`，又是`Queue`，还是`Deque`。但是我们在使用的时候，总是用特定的接口来引用它，这是因为持有接口说明代码的抽象层次更高，而且接口本身定义的方法代表了特定的用途。
    >
    > ```
    > // 不推荐的写法:
    > LinkedList<String> d1 = new LinkedList<>();
    > d1.offerLast("z");
    > // 推荐的写法：
    > Deque<String> d2 = new LinkedList<>();
    > d2.offerLast("z");
    > ```
    >
    > 可见面向抽象编程的一个原则就是：尽量持有接口，而不是具体的实现类。

## Stack

- ![image-20200904142320530](/home/lemon/Workspace/myCheatSheet/Leetcode/Java/pic/image-20200904142320530.png)

## Iterator

- 编译器把`for each`循环通过`Iterator`改写为了普通的`for`循环：

    - ```java
        for (Iterator<String> it = list.iterator(); it.hasNext(); ) {
             String s = it.next();
             System.out.println(s);
        }
        ```

- 实现`ReverseList`和`ReverseIterator`

```java
class ReverseList<T> implements Iterable<T> {

    private List<T> list = new ArrayList<>();

    public void add(T t) {
        list.add(t);
    }

    @Override
    public Iterator<T> iterator() {
        return new ReverseIterator(list.size());
    }

    class ReverseIterator implements Iterator<T> {
        int index;

        ReverseIterator(int index) {
            this.index = index;
        }

        @Override
        public boolean hasNext() {
            return index > 0;
        }

        @Override
        public T next() {
            index--;
            return ReverseList.this.list.get(index);
        }
    }
}

```

## TODO Collections

- `Collections`是JDK提供的工具类，同样位于`java.util`包中。它提供了一系列静态方法，能更方便地操作各种集合。

    - :warning:注意Collections结尾多了一个s，不是Collection！

- 排序

    - `Collections`可以对`List`进行排序。因为排序会直接修改`List`元素的位置，因此必须传入可变`List`.

        - ```java
            Collections.sort(list)
            ```

- 洗牌:

    - `Collections`提供了洗牌算法，即传入一个有序的`List`，可以随机打乱`List`内部元素的顺序，效果相当于让计算机洗牌

        - ```java
            Collections.shuffle(list);
            ```

- 

# IO

# Notice

## `public static void main`

- **Why main has to be static**: ([here](https://stackoverflow.com/questions/146576/why-is-the-java-main-method-static))

    > - The method is static because otherwise there would be ambiguity: which constructor should be called? Especially if your class looks like this:
    >
    >     ```java
    >     public class JavaClass{
    >       protected JavaClass(int x){}
    >       public void main(String[] args){
    >       }
    >     }
    >     ```
    >
    >     Should the JVM call `new JavaClass(int)`? What should it pass for `x`?
    >
    >     If not, should the JVM instantiate `JavaClass` without running any constructor method? I think it shouldn't, because that will special-case your entire class - sometimes you have an instance that hasn't been initialized, and you have to check for it in every method that could be called.
    >
    >     There are just too many edge cases and ambiguities for it to make sense for the JVM to have to instantiate a class before the entry point is called. That's why `main` is static.

- **How  to call a non-static method in a static method?** ([here](https://stackoverflow.com/questions/7379915/java-how-to-call-non-static-method-from-main-method))

    - **Initialize an instance!**

    - > The important point of instance methods is that they're meant to be specific to a particular instance of the class... so you'll need to *create* an instance first. That way the instance will have access to the right connection and prepared statement in your case. Just calling `ReportHandler.executeBatchInsert`, there isn't enough *context*.
        >
        > It's really important that you understand that:
        >
        > - Instance methods (and fields etc) relate to a particular instance
        > - Static methods and fields relate to the type itself, *not* a particular instance

    - 所以如果你想在main里call一个`non-static`的方法, 最好的方法是新建一个类, 然后在main里新建一个这个类的对象.

## 字段初始化

- ```
    public class Main {
    	// Java支持这样的原地初始化
    	List<String> mutable = new ArrayList<>();
        public static void main(String[] args) {
        }
    }
    ```

    # Int can't be `null`

    > - `int` *can't* be null, but `Integer` *can*. You need to be careful when unboxing null Integers since this can cause a lot of confusion and head scratching! [here](https://stackoverflow.com/questions/2254435/can-an-int-be-null-in-java)

    - ```java
        Integer count = map.get(key); // 对
        int count = map.get(key); // 错
        if (count == null) { // will get an error here: bad operand types for binary operator '=='
            map.put(key, 1);
        }
        else {
            map.put(key, count + 1);
        }
        ```

## 泛型

- `Map<Integer>`对; `Map<int>`错;

## ACM

### StdIn && StdOut

### 编译运行 (classpath && jar)

### 常用import的库

## 上述这些都得写成板子