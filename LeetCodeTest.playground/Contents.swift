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

/*
 给定一个字符串，请你找出其中不含有重复字符的 最长子串 的长度。
 
 一下是脑残解法，对例题那个字符串无能为力，诚心搞我啊，需要支援！
 
 用例
 "pwwkew" = 3
 " " = 1
 "abcabcbb" = 3
 "dvdf" = 3
 */
func lengthOfLongestSubstring(_ s: String) -> Int {
    var maxLength: Int = 0
    var startIndex = s.startIndex
    var offset = 0
    for index in 0 ..< s.count {
        // 找出当前光标位置的字符位置
        let targetIndex = s.index(startIndex, offsetBy: index - offset)
        // 找出对应的字符
        let targetString = String(s[targetIndex])
        print("Target String: ", targetString)
        // 当前截取的字符串
        let tempString = s[startIndex ..< targetIndex]
        print("Temp String: ", tempString)
        // 如果出现重复，更新当前长度，并字符串左移一位继续计算
        if tempString.contains(targetString) {
            maxLength = tempString.count > maxLength ? tempString.count : maxLength
            print("Max length -------- ", maxLength)
            startIndex = s.index(after: startIndex)
            offset += 1
            let nextString = s[startIndex ..< s.endIndex]
            print("Next String: ", nextString)
            let stringLength = lengthOfLongestSubstring(String(nextString))
            maxLength = stringLength > maxLength ? stringLength : maxLength
            print("Max length -------- ", maxLength)
        }
    }
    let lastString = s[startIndex ..< s.endIndex]
    let lastChara = lastString[lastString.index(before: s.endIndex)]
    if (!lastString.contains(lastChara)) {
        maxLength = lastString.count > maxLength ? lastString.count : maxLength
        print("Max length -------- ", maxLength)
    }
    print("Max length -------- ", maxLength)
    return maxLength
}

class ArraySolution {
    // 1.数组删除重复元素
    func removeDuplicates(nums:[Int]) -> Int {
        var duplicateNums = Array.init(nums)
        duplicateNums[0] = nums[0]
        var slowIderate: Int = 0;
        for (idx, num) in nums.enumerated() {
            if duplicateNums[slowIderate] != num {
                print("slow: \(slowIderate) Fast: \(idx)")
                slowIderate += 1
                duplicateNums[slowIderate] = num
            } else {
                print("相同值，忽略")
            }
        }
        let retArray = duplicateNums.prefix(slowIderate + 1)
        print(retArray)
        return retArray.count
    }
    
    // 2.股票最大利润
    func maxProfit(stockPrice: [Int]) -> Int {
        var profit = 0
        for (day, price) in stockPrice.enumerated() {
            if day > 0 { // 第一天无法比较
                if (price > stockPrice[day - 1]) { // 如果今天的价格大于昨天，则卖出得到利润
                    profit += price - stockPrice[day - 1];
                }
            }
        }
        return profit
    }
    
    // 3.数组旋转移动
    func rotate(_ nums: inout [Int], _ k: Int) {
        if k <= 0 {
            return
        }
        var offset = 0;
        if k > nums.count {
            offset = k % nums.count
        } else {
            offset = k
        }
        let numsPrefix = nums.suffix(offset)
        let numsSuffix = nums.prefix(nums.count - offset)
        var result = Array.init(numsPrefix)
        result.append(contentsOf: numsSuffix)
        nums = result
    }
}

var sampleArray = [1,2,3,4,5,6,7,8]

ArraySolution().rotate(&sampleArray, 99)

