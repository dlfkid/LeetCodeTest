import UIKit

/*
 
1.数组中组成目标值的两个数的下标
 
 给定一个整数数组 nums 和一个目标值 target，请你在该数组中找出和为目标值的那 两个 整数，并返回他们的数组下标。
 
 你可以假设每种输入只会对应一个答案。但是，你不能重复利用这个数组中同样的元素。
 
 示例:
 
 给定 nums = [2, 7, 11, 15], target = 9
 
 因为 nums[0] + nums[1] = 2 + 7 = 9
 所以返回 [0, 1]
 
 以下的解法是暴力破解法，更优秀的算法应该使用哈希表来实现
 
 */

let nums = [2, 7, 11, 15], target = 9

func sumElement(nums: [Int], target: Int) -> [Int] {
    for index in 0 ..< nums.count {
        let num = nums[index]
        let otherNum = target - num
        for subIndex in 0 ..< nums.count {
            let subNum = nums[subIndex]
            if otherNum == subNum && index != subIndex {
                return [index, subIndex]
            }
        }
    }
    return [0, 0]
}

sumElement(nums: nums, target: target)


/*
 2.逆序链表相加
 
 给出两个 非空 的链表用来表示两个非负的整数。其中，它们各自的位数是按照 逆序 的方式存储的，并且它们的每个节点只能存储 一位 数字。
 
 如果，我们将这两个数相加起来，则会返回一个新的链表来表示它们的和。
 
 您可以假设除了数字 0 之外，这两个数都不会以 0 开头。
 
 以下解法使用了递归的思想
 
 */

public class ListNode {
         public var val: Int
         public var next: ListNode?
         public init(_ val: Int) {
                 self.val = val
                     self.next = nil
        }
}
class ListNodeSumTool {
    func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        
        var value1: Int, value2: Int
        
        value1 = l1?.val ?? 0
        
        value2 = l2?.val ?? 0
        
        // 获得下一节点该进的位数
        let carry = value1 + value2 < 10 ? 0 : 1
        
        // 获得当前节点的值
        let nodeValue = value1 + value2 - 10 * carry
        
        let node = ListNode(nodeValue)
        if (l1?.next != nil || l2?.next != nil || carry > 0) {
            node.next = self.addTwoNumbers(l1?.next, l2?.next, carry)
        }
        return node
    }
    
    func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?, _ previousCarry: Int) -> ListNode? {
        var value1: Int, value2: Int
        
        value1 = l1?.val ?? 0
        
        value2 = l2?.val ?? 0
        
        // 获得下一节点该进的位数
        let carry = value1 + value2 + previousCarry < 10 ? 0 : 1
        
        // 获得当前节点的值
        let nodeValue = value1 + value2 + previousCarry - 10 * carry
        
        let node = ListNode(nodeValue)
        if (l1?.next != nil || l2?.next != nil || carry > 0) {
            node.next = self.addTwoNumbers(l1?.next, l2?.next, carry)
        }
        return node
    }
}

let sum = ListNodeSumTool()

let one = ListNode(5)

let two = ListNode(5)

sum.addTwoNumbers(one, two)
