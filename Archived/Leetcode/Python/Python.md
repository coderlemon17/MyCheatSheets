# collections.defaultdict

```python
class Solution(object):
    def groupAnagrams(self, strs):
        # defaultdict的意思是会为不存在的键创建默认value, 这里是list
        ans = collections.defaultdict(list)
        for s in strs:
            ans[tuple(sorted(s))].append(s)
        return ans.values()
```

# ord函数

```python
count[ord(c) - ord('a')] += 1
```

> ord() 函数是 chr() 函数（对于8位的ASCII字符串）或 unichr() 函数（对于Unicode对象）的配对函数，它以一个字符（长度为1的字符串）作为参数，返回对应的 ASCII 数值，或者 Unicode 数值