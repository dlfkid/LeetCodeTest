import Cocoa

var greeting = "Hello, playground"

class TreeNodeSolution {
    
    public class TreeNode {
        public var val: Int
        public var left: TreeNode?
        public var right: TreeNode?
        public init() { self.val = 0; self.left = nil; self.right = nil; }
        public init(_ val: Int) { self.val = val; self.left = nil; self.right = nil; }
        public init(_ val: Int, _ left: TreeNode?, _ right: TreeNode?) {
            self.val = val
            self.left = left
            self.right = right
        }
    }
    
    /*
     前序遍历
     
     给你二叉树的根节点 root ，返回它节点值的 前序 遍历。
     
     输入：root = [1,null,2,3]
     输出：[1,2,3]
     示例 2：
     
     输入：root = []
     输出：[]
     示例 3：
     
     输入：root = [1]
     输出：[1]
     示例 4：
     
     
     输入：root = [1,2]
     输出：[1,2]
     示例 5：
     
     
     输入：root = [1,null,2]
     输出：[1,2]
     
     来源：力扣（LeetCode）
     链接：https://leetcode.cn/problems/binary-tree-preorder-traversal
     著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
     */
    func preorderTraversal(_ root: TreeNode?) -> [Int] {
        var results = [Int]()
        internalPretraversal(current: root, result: &results)
        return results
    }
    
    func internalPretraversal(current: TreeNode?, result: inout [Int]) {
        guard let node = current else {
            return
        }
        result.append(node.val) // 根
        internalPretraversal(current: node.left, result: &result) // 左
        internalPretraversal(current: node.right, result: &result) // 右
    }
    
    // 迭代法
    func preorderTraversalIderate(_ root: TreeNode?, _ result: inout [Int]) {
        var stack = [TreeNode]()
        guard let node = root else {
            return
        }
        stack.append(node)
        while !stack.isEmpty {
            guard let popedNode = stack.popLast() else {
                break
            }
            result.append(popedNode.val)
            if let rightSon = popedNode.right {
                stack.append(rightSon)
            }
            if let leftSon = popedNode.left {
                stack.append(leftSon)
            }
        }
    }
    
    /*
     后续遍历
     */
    func postorderTraversal(_ root: TreeNode?) -> [Int] {
        var results = [Int]()
        internalPostorderTraversal(root, &results)
        return results
    }
    
    func internalPostorderTraversal(_ current: TreeNode?, _ result: inout [Int]) {
        guard let node = current else {
            return
        }
        internalPostorderTraversal(node.left, &result)
        internalPostorderTraversal(node.right, &result)
        result.append(node.val)
    }
    
    // 后序迭代法
    func postorderTraversalIderate(_ root: TreeNode?, _ result: inout [Int]) {
        var stack = [TreeNode]()
        guard let node = root else {
            return
        }
        stack.append(node)
        while !stack.isEmpty {
            guard let popedNode = stack.popLast() else {
                break
            }
            result.append(popedNode.val)
            if let rightSon = popedNode.right {
                stack.append(rightSon)
            }
            if let leftSon = popedNode.left {
                stack.append(leftSon)
            }
        }
        // 此时的入参顺序是根右左，因此最后把数组反转一下得到左右根，就是后续遍历的顺序
        result.reverse()
    }
    
    /*
     中序遍历
     */
    func inorderTraversal(_ root: TreeNode?) -> [Int] {
        var results = [Int]()
        internalInorderTraversal(root, &results)
        return results
    }
    
    func internalInorderTraversal(_ current: TreeNode?, _ results: inout [Int]) {
        guard let node = current else {
            return
        }
        internalInorderTraversal(node.left, &results)
        results.append(node.val)
        internalInorderTraversal(node.right, &results)
    }
    
    // 中序遍历迭代法
    func internalInorderTraversalIderate(_ root: TreeNode?, _ results: inout [Int]) {
        var stack = [TreeNode]()
        guard let node = root else {
            return
        }
        var current: TreeNode? = node
        while !stack.isEmpty || current != nil {
            if let tempNode = current {
                stack.append(tempNode)
                current = tempNode.left
            } else {
                current = stack.popLast()
                results.append(current!.val)
                current = current?.right
            }
        }
    }
    
    /*
     给你二叉树的根节点 root ，返回其节点值的 层序遍历 。 （即逐层地，从左到右访问所有节点）。
     输入：root = [3,9,20,null,null,15,7]
     输出：[[3],[9,20],[15,7]]
     示例 2：
     
     输入：root = [1]
     输出：[[1]]
     示例 3：
     
     输入：root = []
     输出：[]
     
     来源：力扣（LeetCode）
     链接：https://leetcode.cn/problems/binary-tree-level-order-traversal
     著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
     */
    func levelOrder(_ root: TreeNode?) -> [[Int]] {
        var result = [[Int]]()
        guard let node = root else {
            return result
        }
        var queue = [TreeNode]()
        queue.append(node)
        while !queue.isEmpty {
            var tempRes = [Int]()
            let size = queue.count
            for _ in 0 ..< size {
                let firstNode = queue.removeFirst()
                tempRes.append(firstNode.val)
                if let subLeft = firstNode.left {
                    queue.append(subLeft)
                }
                if let subRight = firstNode.right {
                    queue.append(subRight)
                }
            }
            result.append(tempRes)
        }
        return result
    }
    
    /*
     给你二叉树的根节点 root ，返回其节点值 自底向上的层序遍历 。 （即按从叶子节点所在层到根节点所在的层，逐层从左向右遍历）
     
     示例 1：
     
     输入：root = [3,9,20,null,null,15,7]
     输出：[[15,7],[9,20],[3]]
     示例 2：
     
     输入：root = [1]
     输出：[[1]]
     示例 3：
     
     输入：root = []
     输出：[]
     
     来源：力扣（LeetCode）
     链接：https://leetcode.cn/problems/binary-tree-level-order-traversal-ii
     著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
     */
    
    func levelOrderBottom(_ root: TreeNode?) -> [[Int]] {
        // 依然使用层序遍历，唯一的区别是收集临时结果时从头部入队，这样就是反序的层序遍历
        var result = [[Int]]()
        guard let root = root else {
            return result
        }
        var queue = [TreeNode]()
        queue.append(root)
        while !queue.isEmpty {
            var tempResult = [Int]()
            for _ in 0 ..< queue.count {
                let node = queue.removeFirst()
                tempResult.append(node.val)
                if let leftSon = node.left {
                    queue.append(leftSon)
                }
                if let rightSon = node.right {
                    queue.append(rightSon)
                }
            }
            result.insert(tempResult, at: 0)
        }
        return result
    }
    
    /*
     给你一棵二叉树的根节点 root ，翻转这棵二叉树，并返回其根节点。
     
     输入：root = [4,2,7,1,3,6,9]
     输出：[4,7,2,9,6,3,1]
     
     来源：力扣（LeetCode）
     链接：https://leetcode.cn/problems/invert-binary-tree
     著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
     */
    func invertTree(_ root: TreeNode?) -> TreeNode? {
        guard let node = root else {
            return nil
        }
        var stack = [TreeNode]()
        stack.append(node)
        while !stack.isEmpty {
            let tempNode = stack.removeLast()
            let leftSon = tempNode.left
            let rightSon = tempNode.right
            tempNode.left = rightSon
            tempNode.right = leftSon
            if let newLeft = tempNode.left {
                stack.append(newLeft)
            }
            if let newRight = tempNode.right {
                stack.append(newRight)
            }
        }
        return node
    }
    
    /*
     给你一个二叉树的根节点 root ， 检查它是否轴对称。
     输入：root = [1,2,2,3,4,4,3]
     输出：true
     */
    func isSymmetric(_ root: TreeNode?) -> Bool {
        return compareNodes(root?.left, root?.right)
    }
    
    func compareNodes(_ lhs: TreeNode?, _ rhs: TreeNode?) -> Bool {
        if lhs == nil && rhs == nil {
            return true
        } else if lhs == nil && rhs != nil {
            return false
        } else if lhs != nil && rhs == nil {
            return false
        } else {
            if lhs!.val != rhs!.val {
                return false
            } else {
                let result1 = compareNodes(lhs!.left, rhs!.right)
                let result2 = compareNodes(lhs?.right, rhs?.left)
                return result1 && result2
            }
        }
    }
    
    /*
     给定一个二叉树，找出其最大深度。
     
     二叉树的深度为根节点到最远叶子节点的最长路径上的节点数。
     
     说明: 叶子节点是指没有子节点的节点。
     */
    func maxDepth(_ root: TreeNode?) -> Int {
        guard let node = root else {
            return 0
        }
        let leftHeight = maxDepth(node.left)
        let rightHeight = maxDepth(node.right)
        return 1 + max(leftHeight, rightHeight)
    }
    
    /*
     给定一个二叉树，找出其最小深度。
     
     最小深度是从根节点到最近叶子节点的最短路径上的节点数量。
     
     说明：叶子节点是指没有子节点的节点。
     */
    func minDepth(_ root: TreeNode?) -> Int {
        guard let node = root else {
            return 0
        }
        let leftHeight = minDepth(node.left)
        let rightHeight = minDepth(node.right)
        
        if node.right == nil && node.left != nil {
            return 1 + leftHeight
        } else if node.right != nil && node.left == nil {
            return 1 + rightHeight
        }
        return 1 + min(leftHeight, rightHeight)
    }
    
    /*
     给定一个二叉树，判断它是否是高度平衡的二叉树。
     
     本题中，一棵高度平衡二叉树定义为：
     
     一个二叉树每个节点 的左右两个子树的高度差的绝对值不超过 1 。
     */
    func isBalanced(_ root: TreeNode?) -> Bool {
        return treeHeight(root) != -1
    }
    // 后序遍历法
    func treeHeight(_ root: TreeNode?) -> Int {
        guard let node = root else {
            return 0
        }
        let leftHeight = treeHeight(node.left)
        let rightHeight = treeHeight(node.right)
        if leftHeight == -1 || rightHeight == -1 {
            return -1
        }
        if abs(rightHeight - leftHeight) > 1 {
            return -1
        } else {
            return 1 + max(leftHeight, rightHeight)
        }
    }
    
    /*
     给你一个二叉树的根节点 root ，按 任意顺序 ，返回所有从根节点到叶子节点的路径。
     
     叶子节点 是指没有子节点的节点。
     
      
     示例 1：
     
     
     输入：root = [1,2,3,null,5]
     输出：["1->2->5","1->3"]
     示例 2：
     
     输入：root = [1]
     输出：["1"]
     
     来源：力扣（LeetCode）
     链接：https://leetcode.cn/problems/binary-tree-paths
     著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
     */
    
    func binaryTreePaths(_ root: TreeNode?) -> [String] {
        var results = [String]()
        var path = ""
        binaryTreePathBackTracking(&path, &results, root)
        return results
    }
    
    func binaryTreePathBackTracking(_ path: inout String, _ results: inout [String], _ root: TreeNode?) {
        if let node = root {
            let component = createTempComponent(current: path, node: node)
            print(component)
            path.append(component)
        }
        let lastIndex = path.endIndex
        if root?.left == nil && root?.right == nil {
            results.append(path)
            return
        }
        if let leftNode = root?.left {
            binaryTreePathBackTracking(&path, &results, leftNode)
            path.removeSubrange(lastIndex..<path.endIndex)
        }
        if let rightNode = root?.right {
            binaryTreePathBackTracking(&path, &results, rightNode)
            path.removeSubrange(lastIndex..<path.endIndex)
        }
    }
    
    func createTempComponent(current: String, node: TreeNode) -> String {
        if current.count == 0 {
            return String(node.val)
        }
        return String("->\(node.val)")
    }
    
    /*
     给定二叉树的根节点 root ，返回所有左叶子之和。
     
     输入: root = [3,9,20,null,null,15,7]
     输出: 24
     解释: 在这个二叉树中，有两个左叶子，分别是 9 和 15，所以返回 24
     示例 2:
     
     输入: root = [1]
     输出: 0
     
     来源：力扣（LeetCode）
     链接：https://leetcode.cn/problems/sum-of-left-leaves
     著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
     */
    func sumOfLeftLeaves(_ root: TreeNode?) -> Int {
        guard let node = root  else {
            return 0
        }
        let leftNum = sumOfLeftLeaves(root?.left)
        let rightNum = sumOfLeftLeaves(root?.right)
        var midNum = 0
        if node.left != nil {
            if (node.left!.left == nil && node.left!.right == nil) {
                midNum = node.left?.val ?? 0
            }
        }
        let sum = leftNum + rightNum + midNum
        return sum
    }
    // 递归法
    func sumOfLeftLeaves2(_ root: TreeNode?) -> Int {
        guard let root = root else {
            return 0
        }
        var stack = [TreeNode]()
        stack.append(root)
        var sum = 0
        while !stack.isEmpty {
            let node = stack.removeLast()
            if node.left != nil && node.left!.left == nil && node.left!.right == nil {
                sum += node.left!.val
            }
            if let rightNode = node.right {
                stack.append(rightNode)
            }
            if let leftNode = node.left {
                stack.append(leftNode)
            }
        }
        return sum
    }
    
    /*
     给定一个二叉树的 根节点 root，请找出该二叉树的 最底层 最左边 节点的值。
     
     假设二叉树中至少有一个节点。
     
     输入: root = [2,1,3]
     输出: 1
     
     
     输入: [1,2,3,4,null,5,6,null,null,7]
     输出: 7
     
     来源：力扣（LeetCode）
     链接：https://leetcode.cn/problems/find-bottom-left-tree-value
     著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
     */
    // 层序遍历
    func findBottomLeftValue(_ root: TreeNode?) -> Int {
        guard let root = root else {
            return 0
        }
        var queue = [TreeNode]()
        queue.append(root)
        var result = 0
        while !queue.isEmpty {
            for i in 0 ..< queue.count {
                let node = queue.removeFirst()
                if i == 0 {
                    result = node.val
                }
                if let leftNode = node.left {
                    queue.append(leftNode)
                }
                if let rightNode = node.right {
                    queue.append(rightNode)
                }
            }
        }
        return result
    }
    
    /*
     给定两个整数数组 inorder 和 postorder ，其中 inorder 是二叉树的中序遍历， postorder 是同一棵树的后序遍历，请你构造并返回这颗 二叉树 。
     示例 1:
     输入：inorder = [9,3,15,20,7], postorder = [9,15,7,20,3]
     输出：[3,9,20,null,null,15,7]
     示例 2:
     输入：inorder = [-1], postorder = [-1]
     输出：[-1]
     
     来源：力扣（LeetCode）
     链接：https://leetcode.cn/problems/construct-binary-tree-from-inorder-and-postorder-traversal
     著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
     */
    func buildTree(_ inorder: [Int], _ postorder: [Int]) -> TreeNode? {
        return buildTreeInternal(inorder: inorder, inorderBegin: 0, inorderEnd: inorder.count, postorder: postorder, postorderBegin: 0, postorderEnd: postorder.count)
    }
    func buildTreeInternal(inorder: [Int], inorderBegin: Int, inorderEnd: Int, postorder: [Int], postorderBegin: Int, postorderEnd: Int) -> TreeNode? {
        if postorderEnd - postorderBegin < 1 {
            return nil
        }
        
        // 后序遍历数组的最后一个元素作为分割点
        let rootValue = postorder[postorderEnd - 1]
        let root = TreeNode(rootValue)
        
        if postorderEnd - postorderBegin == 1 {
            return root
        }
        
        // 从中序遍历数组中找到根节点的下标
        var delimiterIndex = 0
        if let index = inorder.firstIndex(of: rootValue) {
            delimiterIndex = index
        }
        
        root.left = buildTreeInternal(inorder: inorder,
                                      inorderBegin: inorderBegin,
                                      inorderEnd: delimiterIndex,
                                      postorder: postorder,
                                      postorderBegin: postorderBegin,
                                      postorderEnd: postorderBegin + (delimiterIndex - inorderBegin))
        
        root.right = buildTreeInternal(inorder: inorder,
                                       inorderBegin: delimiterIndex + 1,
                                       inorderEnd: inorderEnd,
                                       postorder: postorder,
                                       postorderBegin: postorderBegin + (delimiterIndex - inorderBegin),
                                       postorderEnd: postorderEnd - 1)
        return root
    }
    
    /*
     给定一个不重复的整数数组 nums 。 最大二叉树 可以用下面的算法从 nums 递归地构建:
     
     创建一个根节点，其值为 nums 中的最大值。
     递归地在最大值 左边 的 子数组前缀上 构建左子树。
     递归地在最大值 右边 的 子数组后缀上 构建右子树。
     返回 nums 构建的 最大二叉树 。
     
      
     
     示例 1：
     
     
     输入：nums = [3,2,1,6,0,5]
     输出：[6,3,5,null,2,0,null,null,1]
     解释：递归调用如下所示：
     - [3,2,1,6,0,5] 中的最大值是 6 ，左边部分是 [3,2,1] ，右边部分是 [0,5] 。
     - [3,2,1] 中的最大值是 3 ，左边部分是 [] ，右边部分是 [2,1] 。
     - 空数组，无子节点。
     - [2,1] 中的最大值是 2 ，左边部分是 [] ，右边部分是 [1] 。
     - 空数组，无子节点。
     - 只有一个元素，所以子节点是一个值为 1 的节点。
     - [0,5] 中的最大值是 5 ，左边部分是 [0] ，右边部分是 [] 。
     - 只有一个元素，所以子节点是一个值为 0 的节点。
     - 空数组，无子节点。
     
     来源：力扣（LeetCode）
     链接：https://leetcode.cn/problems/maximum-binary-tree
     著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
     */
    
    func constructMaximumBinaryTree(_ nums: [Int]) -> TreeNode? {
        // 这道题是要构造二叉树， 构造二叉树一定要用前序遍历，根左右才能构造出二叉树
        guard nums.count != 1 else {
            // 题目规定数组长度至少为一，1的时候就是叶子节点了，直接构造节点返回即可
            return TreeNode(nums[0])
        }
        var maxValue = 0
        var maxIndex = 0
        for index in 0 ..< nums.count {
            // 通过遍历数组找出最大值
            if nums[index] > maxValue {
                maxValue = nums[index]
                maxIndex = index
            }
        }
        // 根据最大值构造节点
        let newTreeNode = TreeNode(maxValue)
        // 构造左右子树
        if maxIndex > 0 {
            // 以最大值的index为分界构造左右子数组
            let leftNums: [Int] = Array(nums[0 ..< maxIndex])
            newTreeNode.left = constructMaximumBinaryTree(leftNums)
        }
        if maxIndex < nums.count - 1 {
            // 以最大值的index为分界构造左右子数组
            let rightNums: [Int] = Array(nums[maxIndex + 1 ..< nums.count])
            newTreeNode.right = constructMaximumBinaryTree(rightNums)
        }
        // 返回根节点
        return newTreeNode
    }
    
    /*
     给你两棵二叉树： root1 和 root2 。
     
     想象一下，当你将其中一棵覆盖到另一棵之上时，两棵树上的一些节点将会重叠（而另一些不会）。你需要将这两棵树合并成一棵新二叉树。合并的规则是：如果两个节点重叠，那么将这两个节点的值相加作为合并后节点的新值；否则，不为 null 的节点将直接作为新二叉树的节点。
     
     返回合并后的二叉树。
     
     注意: 合并过程必须从两个树的根节点开始。
     
      
     
     示例 1：
     
     
     输入：root1 = [1,3,2,5], root2 = [2,1,3,null,4,null,7]
     输出：[3,4,5,5,4,null,7]
     示例 2：
     
     输入：root1 = [1], root2 = [1,2]
     输出：[2,2]
     
     来源：力扣（LeetCode）
     链接：https://leetcode.cn/problems/merge-two-binary-trees
     著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
     */
    func mergeTrees(_ root1: TreeNode?, _ root2: TreeNode?) -> TreeNode? {
        // 采用前序遍历，因为是合并两棵树，所以优先返回存在的节点
        guard let root1 = root1 else {
            return root2
        }
        guard let root2 = root2 else {
            return root1
        }
        // 两个节点都存在的时候新的值等于他们的和，左右子树递归合并
        root1.val += root2.val
        root1.left = mergeTrees(root1.left, root2.left)
        root1.right = mergeTrees(root2.right, root2.right)
        return root1
    }
    
    /*
     给定二叉搜索树（BST）的根节点 root 和一个整数值 val。
     
     你需要在 BST 中找到节点值等于 val 的节点。 返回以该节点为根的子树。 如果节点不存在，则返回 null 。
     
      
     
     示例 1:
     
     
     
     输入：root = [4,2,7,1,3], val = 2
     输出：[2,1,3]
     示例 2:
     
     
     输入：root = [4,2,7,1,3], val = 5
     输出：[]
     
     来源：力扣（LeetCode）
     链接：https://leetcode.cn/problems/search-in-a-binary-search-tree
     著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
     */
    func searchBST(_ root: TreeNode?, _ val: Int) -> TreeNode? {
        guard let root = root else {
            return nil
        }
        var node: TreeNode? = root
        while node != nil {
            if node!.val == val {
                break
            }
            if node!.val > val {
                node = node!.left
            } else if node!.val < val {
                node = node!.right
            }
        }
        return node
    }
    
    /*
     给你一个二叉树的根节点 root ，判断其是否是一个有效的二叉搜索树。
     
     有效 二叉搜索树定义如下：
     
     节点的左子树只包含 小于 当前节点的数。
     节点的右子树只包含 大于 当前节点的数。
     所有左子树和右子树自身必须也是二叉搜索树。
      
     
     示例 1：
     
     
     输入：root = [2,1,3]
     输出：true
     
     来源：力扣（LeetCode）
     链接：https://leetcode.cn/problems/validate-binary-search-tree
     著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
     */
    func isValidBST(_ root: TreeNode?) -> Bool {
        // 本题采用中序遍历法，因为二叉搜索树如果用中序遍历的话，他的值就是单调递增的，只要判断非空的新值是否大于旧值即可
        guard let root = root else {
            return true
        }
        var stack = [TreeNode]()
        var current: TreeNode? = root
        var result = true
        var lastVal: Int? = nil // 用于保存旧值，初始状态下是空的
        while !stack.isEmpty || current != nil {
            if let tempNode = current {
                // 先遍历到左叶子节点
                stack.append(tempNode)
                current = tempNode.left
            } else {
                // 到达左叶子节点后，中序遍历正式开始，此时开始判断是否单调递增
                current = stack.popLast()
                if let currentVal = current?.val {
                    // 如果旧值存在，且当前值不大于旧值，说明不是二叉搜索树
                    if lastVal != nil && currentVal <= lastVal! {
                        result = false
                        break
                    } else {
                        // 否则更新旧值
                        lastVal = currentVal
                    }
                }
                current = current?.right
            }
        }
        return result
    }
    
    /*
     给你一个二叉搜索树的根节点 root ，返回 树中任意两不同节点值之间的最小差值 。
     
     差值是一个正数，其数值等于两值之差的绝对值。
     
      
     
     示例 1：
     
     
     输入：root = [4,2,6,1,3]
     输出：1
     示例 2：
     
     
     输入：root = [1,0,48,null,null,12,49]
     输出：1
     
     来源：力扣（LeetCode）
     链接：https://leetcode.cn/problems/minimum-absolute-difference-in-bst
     著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
     */
    func getMinimumDifference(_ root: TreeNode?) -> Int {
        var result = Int.max
        var pre: TreeNode? = nil
        var current: TreeNode? = root
        guard current != nil else {
            return result
        }
        var stack = [TreeNode]()
        while !stack.isEmpty || current != nil {
            if let node = current {
                stack.append(node)
                current = node.left
            } else {
                current = stack.popLast()
                if pre != nil && current != nil {
                    result = min(result, abs(pre!.val - current!.val))
                }
                pre = current
                current = current?.right
            }
        }
        return result
    }
    
    /*
     给你一个含重复值的二叉搜索树（BST）的根节点 root ，找出并返回 BST 中的所有 众数（即，出现频率最高的元素）。
     
     如果树中有不止一个众数，可以按 任意顺序 返回。
     
     假定 BST 满足如下定义：
     
     结点左子树中所含节点的值 小于等于 当前节点的值
     结点右子树中所含节点的值 大于等于 当前节点的值
     左子树和右子树都是二叉搜索树
      
     
     示例 1：
     
     
     输入：root = [1,null,2,2]
     输出：[2]
     示例 2：
     
     输入：root = [0]
     输出：[0]
     
     来源：力扣（LeetCode）
     链接：https://leetcode.cn/problems/find-mode-in-binary-search-tree
     著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
     */
    func findMode(_ root: TreeNode?) -> [Int] {
        var result = [Int]()
        guard let root = root else {
            return result
        }
        var maxCount = 0
        var count = 1
        var pre: TreeNode? = nil
        var current: TreeNode? = root
        var stack = [TreeNode]()
        while !stack.isEmpty || current != nil {
            if let node = current {
                stack.append(node)
                current = node.left
            } else {
                current = stack.popLast()
                // 执行逻辑
                if current != nil {
                    // 由于是二叉搜索树，相同的数必然连续
                    if pre != nil && pre!.val == current!.val {
                        count += 1
                    } else {
                        // 遇到了不相同的数，需要把count复位
                        count = 1
                    }
                    // 判断是否要更新maxCount, 如果更新了要清空结果数组
                    if count > maxCount {
                        maxCount = count
                        result.removeAll()
                    }
                    // 达到或超过maxCount的值需要记录在结果集合中
                    if count >= maxCount {
                        result.append(current!.val)
                    }
                }
                // 继续中序遍历
                pre = current
                current = current?.right
            }
        }
        return result
    }
    
    /*
     给定一个二叉树, 找到该树中两个指定节点的最近公共祖先。
     
     百度百科中最近公共祖先的定义为：“对于有根树 T 的两个节点 p、q，最近公共祖先表示为一个节点 x，满足 x 是 p、q 的祖先且 x 的深度尽可能大（一个节点也可以是它自己的祖先）。”
     
      
     
     示例 1：
     
     
     输入：root = [3,5,1,6,2,0,8,null,null,7,4], p = 5, q = 1
     输出：3
     解释：节点 5 和节点 1 的最近公共祖先是节点 3 。
     示例 2：
     
     
     输入：root = [3,5,1,6,2,0,8,null,null,7,4], p = 5, q = 4
     输出：5
     解释：节点 5 和节点 4 的最近公共祖先是节点 5 。因为根据定义最近公共祖先节点可以为节点本身。
     
     来源：力扣（LeetCode）
     链接：https://leetcode.cn/problems/lowest-common-ancestor-of-a-binary-tree
     著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
     */
    func lowestCommonAncestor(_ root: TreeNode?, _ p: TreeNode?, _ q: TreeNode?) -> TreeNode? {
        guard let root = root, let p = p, let q = q else {
            return nil
        }
        // 当前节点值不等于目标节点值，否则返回自身
        guard root.val != p.val && root.val != q.val else {
            return root
        }
        let leftNode = lowestCommonAncestor(root.left, p, q)
        let rightNode = lowestCommonAncestor(root.right, p, q)
        // 左右子节点递归都非空的情况下，说明当前节点就是最近公共祖先
        if leftNode != nil && rightNode != nil {
            return root
        }
        if leftNode != nil && rightNode == nil {
            return leftNode
        }
        if leftNode == nil && rightNode != nil {
            return rightNode
        }
        return nil
    }
    
    /*
     给定一个二叉搜索树, 找到该树中两个指定节点的最近公共祖先。
     
     百度百科中最近公共祖先的定义为：“对于有根树 T 的两个结点 p、q，最近公共祖先表示为一个结点 x，满足 x 是 p、q 的祖先且 x 的深度尽可能大（一个节点也可以是它自己的祖先）。”
     
     例如，给定如下二叉搜索树:  root = [6,2,8,0,4,7,9,null,null,3,5]
     
     
     
      
     
     示例 1:
     
     输入: root = [6,2,8,0,4,7,9,null,null,3,5], p = 2, q = 8
     输出: 6
     解释: 节点 2 和节点 8 的最近公共祖先是 6。
     示例 2:
     
     输入: root = [6,2,8,0,4,7,9,null,null,3,5], p = 2, q = 4
     输出: 2
     解释: 节点 2 和节点 4 的最近公共祖先是 2, 因为根据定义最近公共祖先节点可以为节点本身。
     
     
     来源：力扣（LeetCode）
     链接：https://leetcode.cn/problems/lowest-common-ancestor-of-a-binary-search-tree
     著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
     */
    func lowestCommonAncestorForSearchTree(_ root: TreeNode?, _ p: TreeNode?, _ q: TreeNode?) -> TreeNode? {
        guard let root = root, let p = p, let q = q else {
            return nil
        }
        // 当前节点值不等于目标节点值，否则返回自身
        guard root.val != p.val && root.val != q.val else {
            return root
        }
        // 如果当前节点值比pq都小，说明当前节点在二叉搜索树目标节点的左方，要向右遍历
        if root.val < p.val && root.val < q.val {
            return lowestCommonAncestorForSearchTree(root.right, p, q)
        } else if root.val > p.val && root.val > q.val {
            // 如果当前节点值比pq都大，说明当前节点在二叉搜索树目标节点的右方，要向左遍历
            return lowestCommonAncestorForSearchTree(root.left, p, q)
        } else {
            // 如果当前节点值在pq之间，说明当前节点就是最近公共祖先
            return root
        }
    }
    // 迭代法
    func lowestCommonAncestorTraversal(_ root: TreeNode?, _ p: TreeNode?, _ q: TreeNode?) -> TreeNode? {
        guard let root = root, let p = p, let q = q else {
            return nil
        }
        var result: TreeNode? = nil
        var current: TreeNode? = root
        while let node = current {
            if node.val > p.val && node.val > q.val {
                current = node.left
            } else if node.val < p.val && node.val < q.val {
                current = node.right
            } else {
                result = current
                break
            }
        }
        return result
    }
    
    /*
     给定二叉搜索树（BST）的根节点 root 和要插入树中的值 value ，将值插入二叉搜索树。 返回插入后二叉搜索树的根节点。 输入数据 保证 ，新值和原始二叉搜索树中的任意节点值都不同。
     
     注意，可能存在多种有效的插入方式，只要树在插入后仍保持为二叉搜索树即可。 你可以返回 任意有效的结果 。
     
      
     
     示例 1：
     
     
     输入：root = [4,2,7,1,3], val = 5
     输出：[4,2,7,1,3,5]
     解释：另一个满足题目要求可以通过的树是：
     
     示例 2：
     
     输入：root = [40,20,60,10,30,50,70], val = 25
     输出：[40,20,60,10,30,50,70,null,null,25]
     示例 3：
     
     输入：root = [4,2,7,1,3,null,null,null,null,null,null], val = 5
     输出：[4,2,7,1,3,5]
     
     来源：力扣（LeetCode）
     链接：https://leetcode.cn/problems/insert-into-a-binary-search-tree
     著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
     */
    func insertIntoBST(_ root: TreeNode?, _ val: Int) -> TreeNode? {
        // 二叉搜索树插入节点，可以插入在叶子节点上，因此终止条件应该是遇到叶子节点
        guard let root = root else {
            return TreeNode(val)
        }
        // 节点值大于目标值，说明该向左遍历，要插入的节点在左子结点
        if root.val > val {
            root.left = insertIntoBST(root.left, val)
        }
        // 节点值小于目标值，说明该向右遍历，要插入的节点在右子结点
        if root.val < val {
            root.right = insertIntoBST(root.right, val)
        }
        return root
    }
    
    /*
     给定一个二叉搜索树的根节点 root 和一个值 key，删除二叉搜索树中的 key 对应的节点，并保证二叉搜索树的性质不变。返回二叉搜索树（有可能被更新）的根节点的引用。
     
     一般来说，删除节点可分为两个步骤：
     
     首先找到需要删除的节点；
     如果找到了，删除它。
      
     
     示例 1:
     
     
     
     输入：root = [5,3,6,2,4,null,7], key = 3
     输出：[5,4,6,2,null,null,7]
     解释：给定需要删除的节点值是 3，所以我们首先找到 3 这个节点，然后删除它。
     一个正确的答案是 [5,4,6,2,null,null,7], 如下图所示。
     另一个正确答案是 [5,2,6,null,4,null,7]。
     
     
     示例 2:
     
     输入: root = [5,3,6,2,4,null,7], key = 0
     输出: [5,3,6,2,4,null,7]
     解释: 二叉树不包含值为 0 的节点
     示例 3:
     
     输入: root = [], key = 0
     输出: []
     
     来源：力扣（LeetCode）
     链接：https://leetcode.cn/problems/delete-node-in-a-bst
     著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
     */
    func deleteNode(_ root: TreeNode?, _ key: Int) -> TreeNode? {
        // 终止条件1：空二叉树或是没有找到要删除的节点
        guard let root = root else {
            return root
        }
        // 终止条件2: 找到了要删除的节点
        guard root.val != key else {
            // 左子树为空，右子树不空
            if root.left == nil && root.right != nil {
                return root.right
            }
            // 左子树不空，右子树为空
            if root.left != nil && root.right == nil {
                return root.left
            }
            // 左右子树都不空
            if let leftNode = root.left, let rightNode = root.right {
                var current: TreeNode? = rightNode
                while current?.left != nil {
                    current = current?.left
                }
                current?.left = leftNode
                return rightNode
            }
            // 左右子树都为空
            return nil
        }
        if root.val > key {
            root.left = deleteNode(root.left, key)
        } else if root.val < key {
            root.right = deleteNode(root.right, key)
        }
        return root
    }
    
    /*
     给你二叉搜索树的根节点 root ，同时给定最小边界low 和最大边界 high。通过修剪二叉搜索树，使得所有节点的值在[low, high]中。修剪树 不应该 改变保留在树中的元素的相对结构 (即，如果没有被移除，原有的父代子代关系都应当保留)。 可以证明，存在 唯一的答案 。
     
     所以结果应当返回修剪好的二叉搜索树的新的根节点。注意，根节点可能会根据给定的边界发生改变。
     
      
     
     示例 1：
     
     
     输入：root = [1,0,2], low = 1, high = 2
     输出：[1,null,2]
     示例 2：
     
     
     输入：root = [3,0,4,null,2,null,null,1], low = 1, high = 3
     输出：[3,2,null,1]
     
     来源：力扣（LeetCode）
     链接：https://leetcode.cn/problems/trim-a-binary-search-tree
     著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
     */
    func trimBST(_ root: TreeNode?, _ low: Int, _ high: Int) -> TreeNode? {
        guard let root = root else {
            return nil
        }
        // 判断当前节点值是否在范围内，如果小于范围，递归检查右子树，因为二叉搜索树的右子树节点值比根节点值大， 有可能符合范围
        if root.val < low {
            root.left = trimBST(root.right, low, high)
            return root
        }
        // 判断当前节点值是否在范围内，如果大于范围，递归检查左子树，因为二叉搜索树的左子树节点值比根节点值大，有可能符合范围
        if root.val > high {
            root.right = trimBST(root.left, low, high)
            return root
        }
        // 对于符合要求的那些节点，递归继续检查即可
        root.left = trimBST(root.left, low, high)
        root.right = trimBST(root.right, low, high)
        return root
    }
    
    /*
     给你一个整数数组 nums ，其中元素已经按 升序 排列，请你将其转换为一棵 高度平衡 二叉搜索树。
     
     高度平衡 二叉树是一棵满足「每个节点的左右两个子树的高度差的绝对值不超过 1 」的二叉树。
     
      
     
     示例 1：
     
     
     输入：nums = [-10,-3,0,5,9]
     输出：[0,-3,9,-10,null,5]
     解释：[0,-10,5,null,-3,null,9] 也将被视为正确答案：
     
     示例 2：
     
     
     输入：nums = [1,3]
     输出：[3,1]
     解释：[1,null,3] 和 [3,1] 都是高度平衡二叉搜索树。
     
     来源：力扣（LeetCode）
     链接：https://leetcode.cn/problems/convert-sorted-array-to-binary-search-tree
     著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
     */
    func sortedArrayToBST(_ nums: [Int]) -> TreeNode? {
        var sortedNums = nums
        return sortedArrayToBSTTraversal(&sortedNums, 0, nums.count - 1)
    }
    // 设计递归函数，返回值表示当前区间内平衡二叉树的根节点， 区间和题目一样设计为左闭右闭
    func sortedArrayToBSTTraversal(_ nums: inout [Int], _ left: Int, _ right: Int) -> TreeNode? {
        // 卫语句排除非法区间，因为是左闭右闭区间，所以，left == right的时候范围内也有一个元素，是合法的，这里要用left <= right
        guard left <= right, right < nums.count else {
            return nil
        }
        // 计算左右区间的中间下标
        // 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
        let middle = (left + right) / 2
        // 以中间下标的值构造根节点
        let root = TreeNode(nums[middle])
        // 递归求叶子结点
        root.left = sortedArrayToBSTTraversal(&nums, left, middle - 1)
        root.right = sortedArrayToBSTTraversal(&nums, middle + 1, right)
        return root
    }
    
    /*
     给出二叉 搜索 树的根节点，该树的节点值各不相同，请你将其转换为累加树（Greater Sum Tree），使每个节点 node 的新值等于原树中大于或等于 node.val 的值之和。
     
     提醒一下，二叉搜索树满足下列约束条件：
     
     节点的左子树仅包含键 小于 节点键的节点。
     节点的右子树仅包含键 大于 节点键的节点。
     左右子树也必须是二叉搜索树。
     注意：本题和 1038: https://leetcode-cn.com/problems/binary-search-tree-to-greater-sum-tree/ 相同
     
      
     
     示例 1：
     
     
     
     输入：[4,1,6,0,2,5,7,null,null,null,3,null,null,null,8]
     输出：[30,36,21,36,35,26,15,null,null,null,33,null,null,null,8]
     示例 2：
     
     输入：root = [0,null,1]
     输出：[1,null,1]
     
     来源：力扣（LeetCode）
     链接：https://leetcode.cn/problems/convert-bst-to-greater-tree
     著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
     */
    func convertBST(_ root: TreeNode?) -> TreeNode? {
        // 由于累加树的定义是把每个小于上一个节点的节点值和上个节点的节点值相加，而二叉搜索树在中序遍历的时候是升序的，因此我们只需要将二叉树按照中序的反序（右根左）遍历，即可得到一个降序数组，此时从二叉树最大的节点开始，一个个向前遍历，把上一个节点值加到本节点中，就可以得到累加树了
        guard let root = root else {
            return nil
        }
        var pre: TreeNode? = nil
        var current: TreeNode? = root
        var stack = [TreeNode]()
        // 二叉树中序迭代法的反序操作
        while !stack.isEmpty || current != nil {
            if let node = current {
                stack.append(node)
                current = node.right
            } else {
                current = stack.popLast()
                if let node = current {
                    node.val += pre?.val ?? 0
                }
                pre = current
                current = current?.left
            }
        }
        return root
    }
}

public class Node {
     public var val: Int
     public var children: [Node]
     public init(_ val: Int) {
         self.val = val
         self.children = []
     }
    
    func levelOrder(_ root: Node?) -> [[Int]] {
        var result = [[Int]]()
        guard let root = root else {
            return result
        }
        var queue = [Node]()
        queue.append(root)
        while !queue.isEmpty {
            var tempCollection = [Int]()
            for _ in 0 ..< queue.count {
                let node = queue.removeFirst()
                tempCollection.append(node.val)
                for child in node.children {
                    queue.append(child)
                }
            }
            result.append(tempCollection)
        }
        return result
    }
    
    func preorder(_ root: Node?) -> [Int] {
        var result = [Int]()
        guard let root = root else {
            return result
        }
        var stack = [Node]()
        stack.append(root)
        while !stack.isEmpty {
            let node = stack.removeLast()
            result.append(node.val)
            var index = stack.count - 1
            while index >= 0 {
                // 入栈的时候要从最右边的节点开始入栈，因为是FILO的出入顺序，这样可以确保出栈后的顺序是根左右
                stack.append(node.children[index])
                index -= 1
            }
        }
        return result
    }
    
    func postorder(_ root: Node?) -> [Int] {
        var result = [Int]()
        guard let root = root else {
            return result
        }
        var stack = [Node]()
        stack.append(root)
        while !stack.isEmpty {
            let node = stack.removeLast()
            result.append(node.val)
            for child in node.children {
                // 后续遍历的话要确保出栈顺序是左右根，反过来就是根右左，所以这里我们要确保子节点入栈顺序是从左到右，这样出栈顺序就是右到左
                stack.append(child)
            }
        }
        // 获取到根右左顺序的结果数组，将之反转得到后续遍历
        return result.reversed()
    }
}

