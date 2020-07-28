# 继承时Python若有相同函数要小心

```python
class Parent(object):
    def __init__(self):
        self.me()
    def me(self):
        print("Parent")

class Child(Parent):
    def __init__(self):
        super(Child, self).__init__()
    def me(self):
        print("Child")
c = Child()
```

`>> Child`

- 即使是在父类中调用的,也会是调用子类的函数:
    - 因为Child中相当已经没有父类的那个me函数了,python不是很分父类和子类