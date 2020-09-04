# Section 0

## 0.1. 学习算法和刷题的框架思维

### 0.1.1. 数据结构的存储方式

- 最底层只有两种: 数组和链表. (插入/删除, 查找)

### 0.1.2. 数据结构的基本操作

- 遍历 + 访问
    - 线性: e.g. 遍历
    - 非线性: e.g. 递归 (链表; 二叉树...)

### 0.1.3. 算法刷题指南

- 问题 <-> 数据结构 <-> 代码**框架**
- 为什么要先刷二叉树呢，**因为二叉树是最容易培养框架思维的，而且大部分算法技巧，本质上都是树的遍历问题**。

## 0.2. 动态规划解题框架

- 动态规划: 求最值时避免重复的穷举.

- 暴力动态规划:

    - ```python
        # 初始化 base case
        dp[0][0][...] = base
        # 进行状态转移
        for 状态1 in 状态1的所有取值：
            for 状态2 in 状态2的所有取值：
                for ...
                    dp[状态1][状态2][...] = 求最值(选择1，选择2...)
        ```

- [动态规划三要素](https://www.zhihu.com/question/23995189: 

    - **重叠子问题**; (暴力时一个子问题会被多次计算)
        - 实际上考虑是否用DP只要考虑`无后效性` + `最优子结构`即可.
    - **无后效性**:
        - 例如凑零钱, `f(n)`表示凑出面值为n的零钱最少要几张纸币. 则一旦f(n)确定，“我们如何凑出f(n)”就再也用不着了。
            -  <font color="grey">要求出f(15)，只需要知道f(14),f(10),f(4)的值，而f(14),f(10),f(4)是如何算出来的，对之后的问题没有影响。</font>
            - <font color="grey">如果给定某一阶段的状态，则在这一阶段以后过程的发展不受这阶段以前各段状态的影响</font>
    - **最优子结构**:
        - 大问题的**最优解**可以由小问题的**最优解**推出，这个性质叫做“最优子结构性质”。
            - <font color="grey">利用w=14,10,4的**最优**解，我们即可算出w=15的**最优**解。</font>

- **明确 base case -> 明确「状态」-> 明确「选择」 -> 定义 dp 数组/函数的含义**(状态转移)。

    - 状态: 原问题和子问题中会变化的变量

        - <font color="red">我是谁</font>

    - 选择: 导致「状态」产生变化的行为

        - <font color="red">我从哪里来, 我要到哪里去</font> (e.g. 最长上升子序列.)
        - **我从哪里来要关注子问题存不存在(数组越界) or 子问题是否有解**
    
    - dp 数组/函数的含义: 递归 / 递推
    
        - ```
            # 递推 && 递归思想
            for i in range(状态):
            	dp[i] = f(dp[子问题状态])
            	
            # 递推 && 递推思想
            for i in range(状态):
            	dp[i的父问题] = f(dp[i])
            ```

### 0.2.1. 斐波那契数列

- `递归的时间复杂度`: 子问题的个数(递归树中的节点个数) * 解决每一个子问题需要的时间(假设它所需要的子节点已经算出)

- 三种动态规划解法:

- `解法1`: 暴力

    - base case + 子问题 (状态/选择) + 状态转移方程

- `解法2`: 带**备忘录**的递归解法; [自顶向下]
- 相当于给递归树剪枝
  
- `解法3`: 递推算法 [自底向上]

    - 相当于沿着剪了枝的递归树从下往上递推上去的
    - 重叠子问题.

    - 状态转移方程(暴力中需要的); 状态压缩(仅记录所需状态; 滚数组).

### 0.2.2. 凑零钱

- 注: 若零钱个数有限则不满足无后效性了:

    - 因为`f(n)`依赖于`f(n-5)`是怎么算出来的, 而这一点并没有体现在状态中.

- 注意处理**子问题无解**的情况. (`dp[子问题] == -1`)

- 使用`递推算法`时也可以用`递归`的想法:

    - ```
        # 递推 && 递归思想 (这样好想)
        for i in range(状态):
        	dp[i] = f(dp[子问题状态])
        	
        # 递推 && 递推思想
        for i in range(状态):
        	dp[i的父问题] = f(dp[i])
        ```

## 0.3. 回溯算法解题框架

- **解决一个回溯问题，实际上就是一个决策树的遍历过程**。

    - 路径 (当前行走的路径); 分支(当前节点的子节点); 结束条件(到达叶子节点)

    - ```python
        result = []
        def backtrack(路径, 选择列表):
            if 满足结束条件:
                result.add(路径)
                return
        
            for 选择 in 选择列表:
                做选择
                backtrack(路径, 选择列表)
                撤销选择
        ```

- **前序遍历的代码在进入某一个节点之前的那个时间点执行，后序遍历代码在离开某个节点之后的那个时间点执行**。

- 不一定非得到结束条件才停止下钻, 中途可以加入`isValid`判断当前路径是否已经非法从而实现剪枝.

- 全排列:

    - 可以将数组分为两个部分: 已经填过和未填过, 这样只需要交换.

#### 0.3.1. Compared between DP and Backtrack

- 本质都是一颗递归树:
    - DP: 基于重复子问题; 最优子结构, 减少对子树(子问题)的遍历.
    - Backtrack: 先序遍历递归树, 问题之间(树和子树)之间**不满足**最优子结构. (父节点会修改子树可用的选择列表.)
        - 可以利用题目的一些限制进行剪枝. (`isValid`)

## 0.4. BFS算法解题框架

```c++
初始化队列Q.
Q={起点s}; 
标记s为己访问; // 1.
while (Q非空) {
    取Q队首元素u; u出队;
    if (u == 目标状态) {…} // 2.
    所有与u相邻且未被访问的点进入队列;  // 3.
    标记与u相邻的点为已访问;
}
```

- 既然 BFS 那么好，为啥 DFS 还要存在**？

> BFS 可以找到最短距离，但是*空间复杂度高，而 DFS 的空间复杂度较低*。
>
> 还是拿刚才我们处理二叉树问题的例子，假设给你的这个二叉树是满二叉树，节点数为 `N`，对于 DFS 算法来说，空间复杂度无非就是递归堆栈，最坏情况下顶多就是树的高度，也就是 `O(logN)`。
>
> 但是你想想 BFS 算法，队列中每次都会储存着二叉树一层的节点，这样的话最坏情况下空间复杂度应该是树的最底层节点的数量，也就是 `N/2`，用 Big O 表示的话也就是 `O(N)`。
>
> 由此观之，BFS 还是有代价的，一般来说在找最短路径的时候使用 BFS，其他时候还是 DFS 使用得多一些.

- 如果BFS需要返回的是步数, 则一般需要`queue<pair<node, int>>`.
- 

### 0.4.1. 双向 BFS 优化

- 传统BFS: 起点->终点; 双向BFS: 起点->终点 and 终点->起点.

    - 二者最坏复杂度都是 `O(N)`，但是实际上双向 BFS 确实会快一些

    - <img src="./pic/DBFS1.png" alt="img" style="zoom:25%;" /> 

    - <img src="./pic/DBFS2.png" alt="img" style="zoom:25%;" />

    - 双向 BFS 也有局限，因为你必须知道终点在哪里.

    - 实现技巧:

        - **不再使用队列，而是使用 HashSet 方便快速判断两个集合是否有交集**。

        - 另外的一个技巧点就是 **while 循环的最后交换** **`start1`** **和** **`start2`** **的内容**，所以只要默认扩散 `start1` 就相当于轮流扩散 `start1` 和 `start2`。

        - 双向BFS中, 不能在入队时把所有元素都加入`visited`, 不然两个集合永远不会有交集了. (而是在出队)
    
            - 但因为这样, 集合中会存在重复入队的元素, 所以不用queue用set.
        - 同时注意这种写法, 相当于每次扩散是扩散了**一层** (for循环), 而不是单向
                BFS扩散一个节点.

        - 始终扩散临接元素较小的集合:
    
            - ```c++
                set<Node> start1;
                set<Node> start2;
                start1.push(start);
                start2.push(end);
                hash_map<Node> visited;
                
                while (!start1.isEmpty() && !start2.isEmpty()) {
                    // 优化 optional
                    if (start1.size() > start2.size()) {
                        // 交换 start1 和 start2
                        temp = start1;
                        start1 = start2;
                        start2 = temp;
                    }
                    // set在循环时不能修改
                    set<Node> tmpt;
                    
                    for(start1的所有节点p) {
                        // 出队时标记已经访问
                        visited.add(p);
                        if (start2.contains(p)) {目标节点...}
                        for(p的所有未访问的邻居节点n)
                            tmpt.add(n);
                    }
                    start1 = start2;
                    start2 = temp;
            }
                ```
    
            - 因为按照 BFS 的逻辑，**队列（集合）中的元素越多，扩散之后新的队列（集合）中的元素就越多**；在双向 BFS 算法中，如果我们每次都选择一个较小的集合进行扩散，那么占用的空间增长速度就会慢一些，效率就会高一些

## 0.5. 二分搜索

- 见自己的`板子.md`

## 0.6. 滑动窗口

- 框架:

    - ```c++
        /* 滑动窗口算法框架 [l,r)*/
        void slidingWindow(string s, string t) {
            unordered_map<char, int> need, window;
            for (char c : t) need[c]++;
        
            int left = 0, right = 0;
            int valid = 0; 
            while (right < s.size()) { //注意一次移入窗口的数据量大小.
                // c 是将移入窗口的字符
                char c = s[right];
                // 立刻就在这里右移窗口, 省的忘了.
                right++;
                // 进行窗口内数据的一系列更新
                ...
        
                // 判断左侧窗口是否要收缩
                while (window needs shrink) {
                    //可能在这里判断是否需要更新我们的答案.
                    ...
                    
                    // d 是将移出窗口的字符
                    char d = s[left];
                    // 左移窗口
                    left++;
                    // 进行窗口内数据的一系列更新
                    ...
                }
                //也可能在这里判断是否需要更新我们的答案.
                ...
            }
        }
        ```

- > `unordered_map`就是哈希表（字典），它的一个方法`count(key)`相当于 Java 的`containsKey(key)`可以判断键 key 是否存在。
    >
    > 可以使用方括号访问键对应的值`map[key]`。需要注意的是，如果该`key`不存在，C++ 会自动创建这个 key，并把`map[key]`赋值为 0。
    >
    > 所以代码中多次出现的`map[key]++`相当于 Java 的`map.put(key, map.getOrDefault(key, 0) + 1)`。

- 滑动窗口很擅长处理子串问题. (此方法的难点不在于理解, 而在于细节)

    - `[left, right)`称之为一个窗口.
    - 需要思考的问题:
        - 什么时候需要扩大/缩小窗口
            - **需要注意窗口为空时是否满足题目的valid条件**
            - 如果窗口为空时也满足; 则`window need shrink == (valid && l < r)`
        - 扩大/缩小窗口的时候哪些值需要变化
        - 扩大/缩小窗口时需要更新我们的答案.

### 0.6.1. 关于滑动窗口的题目:

- 包含任意排列 (等于包含所有字母即可.)

- 对于找排列问题可以使用**固定长度的滑动窗口**:

    - 比如想看`s2`中是否包含`s1`的排列, 则可以使用一个长度为`s1.size()`的固定长度窗口, 然后每次只用整体平移. (要事先判断`s1.size() <= s2.size()`)

    - 注意边界条件:

        - 一般是

        - ```c++
            //先判断一遍
            for (int i = 0; i < s1.length(); i++) {
                s1map[s1.charAt(i) - 'a']++;
                s2map[s2.charAt(i) - 'a']++;
            }
            if (matches(s1map, s2map))
                return true;
            // < 而不是<=
            for (int i = 0; i < s2.length() - s1.length(); i++) {	
                // 先滑动,再判断.
                s2map[s2.charAt(i + s1.length()) - 'a']++;
                s2map[s2.charAt(i) - 'a']--;
                
                if (matches(s1map, s2map))
                    return true;
            }
            
            ```

- 对于字符串可以不用`unordered_map`,直接开一个大小为26的数组即可.

- 对于重复字符串

    - 在判断是否需要shrink的时候其实只需要判断**入窗口**的元素即可, 不用都过一遍.
    - 因为收缩窗口的条件是: 刚刚入窗口的字符和窗口内字符重合.

## 0.7. 股票买卖问题

- **明确 base case -> 明确「状态」-> 明确「选择」 -> 定义 dp 数组/函数的含义**(状态转移)

- 列出穷举的DP:

    - ```python
        for 状态1 in 状态1的所有取值：
            for 状态2 in 状态2的所有取值：
                for ...
                    dp[状态1][状态2][...] = 择优(选择1，选择2...)
        ```
        
    - ```python
        dp[i][k][0 or 1]
        0 <= i <= n-1, 1 <= k <= K
        n 为天数，大 K 为最多交易数, k为当前已经交易(购买)次数.
        此问题共 n × K × 2 种状态，全部穷举就能搞定。
        
        for 0 <= i < n:
            for 1 <= k <= K:
                for s in {0, 1}:
                    dp[i][k][s] = max(buy, sell, rest)
        ```
    
        
    
- Base case:

    - ```python
        dp[-1][k][0] = 0
        # 解释：因为 i 是从 0 开始的，所以 i = -1 意味着还没有开始，这时候的利润当然是 0 。
        dp[-1][k][1] = -infinity
        # 解释：还没开始的时候，是不可能持有股票的，用负无穷表示这种不可能。
        dp[i][0][0] = 0
        # 解释：因为 k 是从 1 开始的，所以 k = 0 意味着根本不允许交易，这时候利润当然是 0 。
        dp[i][0][1] = -infinity
        # 解释：不允许交易的情况下，是不可能持有股票的，用负无穷表示这种不可能。
        ```

- ```python
    dp[i][k][0] = max(dp[i-1][k][0], dp[i-1][k][1] + prices[i])
                  max(   选择 rest  ,             选择 sell      )
    
    # 解释：今天我没有持有股票，有两种可能：
    # 要么是我昨天就没有持有，然后今天选择 rest，所以我今天还是没有持有；
    # 要么是我昨天持有股票，但是今天我 sell 了，所以我今天没有持有股票了。
    
    dp[i][k][1] = max(dp[i-1][k][1], dp[i-1][k-1][0] - prices[i])
                  max(   选择 rest  ,           选择 buy         )
    
    # 解释：今天我持有着股票，有两种可能：
    # 要么我昨天就持有着股票，然后今天选择 rest，所以我今天还持有着股票；
    # 要么我昨天本没有持有，但今天我选择 buy，所以今天我就持有股票了。
    ```

### 0.7.1. 关于股票的题目:

- 对于`k=1/infinity`可以把k优化掉.

- 如何开一个动态三维数组:

    - `vector<vector<vector<int>>>dp(len, vector<vector<int>>(k+1, vector<int>(2)));`
    - `vector<int> a (size, initial_number)`

- 注意计算的先后顺序, 对于

    - ```c++
        // dp[i][0] = max(dp[i-1][0], dp[i-1][1] + prices[i])
        dp_i_0 = Math.max(dp_i_0, dp_i_1 + prices[i]);
        // dp[i][1] = max(dp[i-1][1], -prices[i])
        dp_i_1 = Math.max(dp_i_1, -prices[i]);
        ```

        - 这里其使用了滚数组的技巧来节省空间, 所以在这里必须得先算`dp_i_0`, 因为他会用到上一次的`dp_i_1`.

## 0.8. 打家劫舍问题

- `我是谁` + `我从哪里来，我要到哪里去`
    - 无后效性 + 最优子结构
    - 注意状态之间的转移可以是分情况的, 例如打家劫舍里, 当前状态就可以根据打不打劫当前节点转移到两种子状态.
    - 对于`打家劫舍3`, 存在重复子问题, 最简单的优化方式就是使用备忘录.
        - `unordered_map<TreeNode*,int>`

## 0.9. 高楼扔鸡蛋

![image-20200903173748699](/home/lemon/Workspace/myCheatSheet/Leetcode/labuladong_cheatsheet/pic/image-20200903173748699.png)

- `K`为鸡蛋数量; `X`为楼层数; `dp(K,N)`的意思是: 如果我们有`K`个鸡蛋, 要在`N`层楼的最坏情况下找到这其中哪一层为我们要的答案, 需要尝试的次数.
- 观察得
    - <img src="/home/lemon/Workspace/myCheatSheet/Leetcode/labuladong_cheatsheet/pic/image-20200903174255269.png" alt="image-20200903174255269" style="zoom:67%;" />
    - 故在每一层可以用二分搜索查找$\arg\min\limits_{X}(max(dp(K-1,X-1), dp(K,N-X)))$

- ```c++
    int dp(int n_eggs, int floors, vector<vector<int>>& memo) {
        // basecase
        if (n_eggs == 1) 
            return floors;
        if (floors == 0)
            return 0;
        if (memo[n_eggs][floors] != -1)
            return memo[n_eggs][floors];
        int ans = -1;
        int l = 1, r = floors + 1;
        while(l < r) {
            int x = l + (r - l) / 2;
            int x0 = dp(n_eggs, floors-x, memo);
            int x1 = dp(n_eggs-1, x-1, memo);
            if (x0 > x1) {
                l = x + 1;
            } else if (x0 < x1) {
                r = x;
            } else {
                l = x;
                break;
            }
        }
        ans = 1 + max(dp(n_eggs, floors-l, memo), dp(n_eggs-1, l-1, memo));
        memo[n_eggs][floors] = ans;
        return ans;
    }
    ```

## 0.10. 子集背包问题

- 0-1背包:

    > - **`dp[i][w]`的定义如下：对于前`i`个物品，当前背包的容量为`w`，这种情况下可以装的最大价值是`dp[i][w]`。**
    > - dp\[i\]\[w\] = max(
    >           把物品 i 装进背包,
    >           不把物品 i 装进背包
    >         )

- 子集背包同上:

    - <font color="red">我从哪里来, 我要到哪里去</font>

    - 先写出dp方程:

        - ```
            if (nums[i-1] > j) {
                dp[i][j] = dp[i-1][j];
            } else {
                dp[i][j] = dp[i-1][j] || dp[i-1][j-nums[i-1]];
            }
            ```

        - 会发现`dp[i][j]`只需要`dp[i'][j']`, 其中`i'<i`; `j'<j`

            - 所以在递推的时候`i,j`都应该正着遍历, 保证求解`dp[i][j]`时所有`dp[i'][j']`都已经算出来了.

## 0.11. 完全背包问题

- 回溯和动规虽然都是遍历递归树, 但是回溯会存在一个节点多次访问的情况.

    - `Root->(L,R)`: 
        - 回溯时:`Root, L, Root, R`-> 但如果题目要给出具体解法则必须这么走.
        - 动规时: `L, R, Root`.

- 分类: (以凑零钱为例)

    - 每种零钱的个数: 一个; 若干个; 无限个
        - 若干个且是组合问题时注意**去重复** (`nSum`)
        - 只有无限个才能用DP, 否则只能回溯. (不满足无后向性)
    - 求出是否可以凑出 / 最多有多少种凑法 / 输出每种凑法
    - 不同顺序的是否算同一种 (`1 1 2`和`1 2 1`是否算同一种)
        - 算: 组合问题;  不算: 排列问题.
        - 组合问题需要事先对零钱排序.

- 对于完全背包问题: dp ; 组合问题

    - 暴力解法:

        - `dp[i][j]`: 使用前`i`个`[0,i)`零钱, 凑出`j`元钱有多少种凑法.

        - `dp[0][0] = 1` 

        - ```c++
            dp[i][j] = dp[i - 1][j - 0 * coins[i]] + 
                       dp[i - 1][j - 1 * coins[i]] +
                       dp[i - 1][j - 2 * coins[i]] + 
                       ... + 
                       dp[i - 1][j - k * coins[i]]
            ```

    - 同样的想法: 递推实现
    
        - ```python
            class Solution:
                def change(self, amount: int, coins: List[int]) -> int:
                    dp = [0] * (amount + 1)
                    dp[0] = 1
                    
                    for coin in coins:
                        for x in range(coin, amount + 1):
                            dp[x] += dp[x - coin]
                    return dp[amount]
            ```

## 0.12. 实现计算器

-  操作数都是非负数; 加减乘除:
    - 核心思想:`1+2-3*4`转化为`+1, +2, -3, *4`
    - 在遇到`-`的时候说明上一个数已经计算完, **根据上一个数的符号**去决定应该进行什么操作.
- 遇到`(`时进入递归; 遇到`)`时返回: (别用Java了,`java`基本类型无法修改, 无法传引用, 除非`int[]`)

```cpp
class Solution {
public:
    int calculate(string s) {
        int begin = 0;
       return calHelper(s, begin);

    }
    int calHelper(string s, int& i) //i用于记录计算开始的索引
    {
        char operation = '+';
        stack<int> nums;
        int num = 0;
        int res = 0;
        bool flag = false;
        for (i; i < s.size(); i++)
        {
            if (s[i] >= '0' && s[i] <= '9')
            {
                num = num * 10 + (s[i] - '0');
            }
             if (s[i] == '(')
            {
                num = calHelper(s, ++ i); //从i的下一个开始计算， 进入递归
                i++; //计算完之后的i指向)所以再++
            }
            if (((s[i] < '0' || s[i] > '9') && s[i] != ' ') || i >= s.size() - 1) // 继续计算
            {
                int pre = 0;
                switch (operation)
                {
                case '+': nums.push(num);
                    break;
                case '-': nums.push(-num);
                    break;
                case '*':
                    pre = nums.top();
                    nums.pop();
                    nums.push(pre * num);
                    break;
                case '/':
                    pre = nums.top();
                    nums.pop();
                    nums.push(pre / num);
                    break;
                }

                operation = s[i];
                num = 0;
            }
            if (s[i] == ')') //遇到)回到上一级递归
            {
                break;
            }
        }
        while (!nums.empty())
        {
            res += nums.top();
            nums.pop();
        }
        return res;
    }
};
```

