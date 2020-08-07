# 建议

头一次刷题,先刷`array`, `string`, `tree`, `linkedlist`,`math`,其他别按照tag刷题.

不会的题目记得收藏, 定期再清一遍收藏夹.

# 数组

## Easy

#### [1. 两数之和](https://leetcode-cn.com/problems/two-sum/)

- `Date`: 2020/08/06-13 : 08
- `Time`: 5 min
- `思路`: 暴力遍历
- `题解`: 核心想法是如果你要查找一个list中有无某一元素, 一般的做法只有遍历, 但是使用**哈希表**, 可以用空间换时间(最好`O(1)`最坏退化到`O(n)`)
    - e.g. 其他拿空间换时间的例子,开一个`Boolean`数组`a`, 则`a[i]`就代表了`i`在不在数组中.

## Median

#### [1343. 大小为 K 且平均值大于等于阈值的子数组数目](https://leetcode-cn.com/problems/number-of-sub-arrays-of-size-k-and-average-greater-than-or-equal-to-threshold/)

- `Date`: 2020/08/06-12 : 56

- `Time:` 10 min
- `思路`: 滑动窗口遍历, 出错点在于数据index和length之间的换算关系.
- `题解`: 为了减少计算, `sum > k * thred` 可以在最开始改为`sum -= k * thred; sum > 0`

## Hard

#### [4. 寻找两个正序数组的中位数](https://leetcode-cn.com/problems/median-of-two-sorted-arrays/)

- `Date`: 2020/08/06-13 : 20

- `Time`:  X

- `题解`:

    - 解法1: 类似归并排序中合并的思路, 注意代码的写法.

    - 解法2: 

        - 原问题其实可以转化为*在两个有序的数组中寻找第k小元素的问题*
        - 而寻找两个有序数组A,B中第`k`小元素,不妨先比较二者第`k/2`个元素的大小:
            - ![image.png](https://pic.leetcode-cn.com/735ea8129ab5b56b7058c6286217fa4bb5f8a198e4c8b2172fe0f75b29a966cd-image.png)
            - e.g. 如图, A中的第`k/2 = 3`小元素 < B中的第`k/2 = 3 `小元素, 故A中的第`1 - k/2`小元素**都不可能是第`k`小元素**, 可以排除.
        - 注意可能存在的特殊情况:
            - 1. `k/2 > 其中一个数组长度`: 则这个数组直接排除(清空) -> 令`k/2`为这个数组长度
                2. 注意代码中做法: 可以通过调整顺序让某一个数组永远是小的那个
                3. 递归出口为`k==1`或某一个数组为空.

    - Note:

        - 关于下标和第`k`大/小->哪个容易想用哪个.
        - $\text{len} = \underbrace{\text{end - start}}_{delta} + \overbrace{1}^{\text{元素start}}$

          