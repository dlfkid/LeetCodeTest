import Cocoa

var greeting = "Hello, playground"

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

class TreeNodeSolution {
    let node = TreeNode(20, nil, nil)
    
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
            if let leftSon = popedNode.left {
                stack.append(leftSon)
            }
            if let rightSon = popedNode.right {
                stack.append(rightSon)
            }
        }
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
            var leftSon = tempNode.left
            var rightSon = tempNode.right
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
}
