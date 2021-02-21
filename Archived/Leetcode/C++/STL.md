# STL

## [111. 二叉树的最小深度](https://leetcode-cn.com/problems/minimum-depth-of-binary-tree/)

- ```c++
    class Solution {
    public:// BFS
        int minDepth(TreeNode* root) {
            if(!root)   return 0;
            queue<pair<TreeNode*, int> > queue;
            queue.push(make_pair(root, 1));
            while(!queue.empty()){
                TreeNode* node = queue.front().first;
                int depth = queue.front().second;
                queue.pop();
                if(!node->left && !node->right)
                    return depth;
                if(node->left)
                    queue.push(make_pair(node->left, depth + 1));
                if(node->right)
                    queue.push(make_pair(node->right, depth + 1));
            }
            return 0;
        }
    };
    ```

- 因为是二叉树所以不会有元素重复进入队列.

## [76. 最小覆盖子串](https://leetcode-cn.com/problems/minimum-window-substring/)

```c++
class Solution {
public:
    string minWindow(string s, string t) {
        unordered_map<char, int> target;
        int charFinded = 0;
        int l = 0, r = 0, len = s.size();
        int startPoint = -1;
        int length = INT_MAX;

        for (int i = 0; i < t.size(); i++) {
            target[t[i]]++;
        }
        
        while (r < len) {
            char c = s[r];
            r++;

            if (target.count(c)) {
                if (target[c] > 0)
                    charFinded++;
                target[c]--;
            }
            
            // cout << l << " " << r << " " << charFinded << endl;

            while(charFinded == t.size()) {
                if (r - l < length) {
                    length = r - l;
                    startPoint = l;
                }

                char d = s[l];
                l++;

                if (target.count(d)) {
                    if (target[d] >= 0)
                        charFinded--;
                    target[d]++;
                }
            }
        }
        // cout << length << " : " << startPoint << endl;
        if (length == INT_MAX)
            return "";
        
        string ans;
        for (int i = startPoint; i < startPoint + length; i++) {
            ans += s[i];
        }

        return ans;
    }
};
```

> `unordered_map`就是哈希表（字典），它的一个方法`count(key)`相当于 Java 的`containsKey(key)`可以判断键 key 是否存在。
>
> 可以使用方括号访问键对应的值`map[key]`。需要注意的是，如果该`key`不存在，C++ 会自动创建这个 key，并把`map[key]`赋值为 0。
>
> 所以代码中多次出现的`map[key]++`相当于 Java 的`map.put(key, map.getOrDefault(key, 0) + 1)`。

- 如果想遍历这个`unordered_map`

    - ```c++
        bool check() {
                for (const auto &amp;p: ori) {
                    if (cnt[p.first] &lt; p.second) {
                        return false;
                    }
                }
                return true;
            }-
        ```

    - About `auto`:

        - [here](https://www.cnblogs.com/Nothing-9708071624/p/10167982.html)

        - >  想要拷贝元素：for(auto x:range)
            >
            >  想要修改元素 : for(auto &&x:range)
            >
            >  想要只读元素：for(const auto& x:range)