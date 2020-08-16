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