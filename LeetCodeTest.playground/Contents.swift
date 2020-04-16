import UIKit

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
    
    // 4.存在重复元素
    
    func containsDuplicate(_ nums: [Int]) -> Bool {
        if nums.count <= 1 {
            return false
        }
        
        let sortedNums = nums.sorted { (num1, num2) -> Bool in
            return num1 <= num2
        }
    
        var slowIderate = 0;
        
        for index in 1..<sortedNums.count {
            if sortedNums[index] != sortedNums[slowIderate] {
                slowIderate += 1
            } else {
                return true
            }
        }
        return false
    }
    
    func bubbleSort(_ nums: inout [Int]) -> [Int] { // 冒泡排序示例
        let n = nums.count
        for i in 0 ..< n {
            var swapFlag = true
            for j in 0 ..< (n - i - 1) {
                if nums[j] > nums [j + 1] {
                    nums.swapAt(j, j + 1)
                    swapFlag = false
                }
            }
            if swapFlag {
                break
            }
        }
        return nums
    }
    
    // 5.只出现一次的数字
    func singleNumber(_ nums: [Int]) -> Int {
        var sampleNums = Set(nums)
        var tempSet: Set = Set<Int>()
        for num in nums {
            let ret = tempSet.insert(num)
            if !ret.inserted {
                sampleNums.remove(num)
            }
        }
        if sampleNums.count > 0 {
            return sampleNums.sorted()[0]
        } else {
            return 0
        }
    }
    
    // 6.两个数组的交集
    func intersect(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
        let num1 = nums1.sorted(by: <) // 首先将所有数组排序
        let num2 = nums2.sorted(by: <)
        
        
        var i = 0
        var j = 0
        var num3 = Array<Int>()
        
        while i < num1.count && j < num2.count { // 同事对两个数组进行遍历，有一个数组遍历结束就算完毕
            if num1[i] < num2[j] { // 相同位置的两个数如果不相等，则较小位置的数组进下一位继续遍历
                i = i + 1
            } else if num1[i] > num2[j] {
                j = j + 1
            } else { // 相等的数进入结果数组
                num3.append(num1[i])
                i = i + 1
                j = j + 1
            }
        }
        
        return num3
    }
    
    // 7.加一
    func plusOne(_ digits: [Int]) -> [Int] {
        var retArray = Array(digits)
        var startIndex = digits.count - 1;
        while startIndex >= 0 {
            if (startIndex == digits.count - 1) {
                retArray[startIndex] += 1
            } else {
                if (retArray[startIndex + 1] == 10) {
                    retArray[startIndex] += 1
                }
            }
            startIndex -= 1
        }
        if (retArray[0] == 10) {
            retArray = Array.init(repeating: 0, count: digits.count + 1)
            retArray[0] = 1
        } else {
            for (index, num) in retArray.enumerated() {
                if (num == 10) {
                    retArray[index] = 0
                }
            }
        }
        return retArray;
    }
    
    // 8.移动零
    func moveZeroes(_ nums: inout [Int]) {
        var retArray = Array.init(repeating: 0, count: nums.count)
        var location = 0
        for (_, num) in nums.enumerated() {
            if (num != 0) {
                retArray[location] = num
                location += 1
            }
        }
        nums = retArray
    }
    
    // 9.两数之和
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        var reversDict = [Int: Int]()
        for (index, num) in nums.enumerated() {
            print("Index:\(index) num:\(num)")
            reversDict.updateValue(index, forKey: num)
        }
        for (index2, num2) in nums.enumerated() {
            if let index3 = reversDict[target - num2] {
                if (index2 != index3) {
                    return [index2, index3]
                }
            } else {
                print("数组中没有对应的差")
            }
        }
        return [0,0]
    }
    
    // 10.有效的数独
    func isValidSudoku(_ board: [[Character]]) -> Bool {
        // 首先保证每一行没有重复的数字
        for line in board {
            let lineNums = self.stripNumberFromArray(line)
            if (self.containsDuplicate(lineNums)) {
                return false
            }
        }
        // 然后保证每一列没有重复的数字
        var columns = [[Character]]()
        let tempArray = board[0]
        for index2 in 0..<tempArray.count {
            var column = [Character]()
            for (_, array) in board.enumerated() { // 每个数组取对应位置的数字组成新的数数组，即是列数组
                column.append(array[index2])
            }
            columns.append(column)
        }
        for column in columns {
            let columnNums = self.stripNumberFromArray(column)
            if (self.containsDuplicate(columnNums)) {
                return false
            }
        }
        // 最后保证每个九宫格内没有重复的数字
        var squares = Array.init(repeating: [Character](), count: tempArray.count) // 创建空的九宫格数组
        for index in 0..<9 {
            let ret = index % 3
            let minIndex = ret * 3 // 符合要求的最小元素下标
            let maxIndex = ret * 3 + 2 // 符合要求的最大元素下标
            var minLine = 0
            var maxLine = 0
            if ret == 0 {
                minLine = index
                maxLine = index + 2
            } else if ret == 1 {
                minLine = index - 1
                maxLine = index + 1
            } else if ret == 2 {
                minLine = index - 2
                maxLine = index
            }
            for (index1, array) in board.enumerated() {
                if (index1 >= minLine && index1 <= maxLine) {
                    for (index2, num) in array.enumerated() {
                        if index2 >= minIndex && index2 <= maxIndex {
                            squares[index].append(num)
                        }
                    }
                }
            }
        }
        print(squares)
        
        // 得到九宫格数组后做相同处理
        for square in squares {
            let squareNums = self.stripNumberFromArray(square)
            if (self.containsDuplicate(squareNums)) {
                return false
            }
        }
        
        return  true
    }
    
    // 将数组中的.去掉，只保留数字
    func stripNumberFromArray(_ array: [Character]) -> [Int] {
        var retArray = [Int]()
        for chara in array {
            if chara.isNumber {
                retArray.append(chara.hexDigitValue ?? 0)
            }
        }
        return retArray
    }

    // 11.旋转图像
    func rotate(_ matrix: inout [[Int]]) {
        let n = matrix.count
        for i in 0..<n {
            for j in (i + 1)..<n {
                let temp = matrix[i][j]
                matrix[i][j] = matrix[j][i]
                matrix[j][i] = temp
            }
            matrix[i].reverse()
        }
        print(matrix)
    }
}

class StringSolution {
    // 1.反转字符串
    func reverseString(_ s: inout [Character]) {
        if s.count <= 0 {
            return
        }
        let count = s.count
        let finalIndex = (count - 1) % 2 == 0 ? count / 2 : (count - 2) / 2
        for i in 0...finalIndex {
            let temp = s[i]
            s[i] = s[count - 1 - i]
            s[count - 1 - i] = temp
        }
    }
    
    // 2.反转整型
    func reverse(_ x: Int) -> Int {
        if x == 0 {
            return x
        }
        var k = x
        var num = 0
        while k != 0 {
            num = num * 10 + k % 10
            k /= 10
        }
        if num > Int32.max || num < Int32.min {
            return 0
        }
        return num
    }
    
    // 3.字符串中的第一个唯一字符
    func firstUniqChar(_ s: String) -> Int {
        if s.count == 0 {
            return -1
        } else if s.count == 1 {
            return 0
        } else {
            let sampleCharacters = Array(s)
            for index in 0 ..< sampleCharacters.count {
                var sameCount = 0
                for index2 in 0 ..< sampleCharacters.count {
                    if (index != index2 && sampleCharacters[index] == sampleCharacters[index2]) {
                        sameCount += 1
                        break
                    }
                }
                if sameCount == 0 {
                    return index
                }
            }
            return -1
        }
    }
    
    // 4.有效的字母异位词
    func isAnagram(_ s: String, _ t: String) -> Bool {
        if (s.count != t.count) {
            return false
        }
        
        var sArray: [Character] = Array(s)
        var tArray: [Character] = Array(t)
        
        sArray.sort { (charaA, charaB) -> Bool in
            charaA < charaB
        }
        
        tArray.sort { (charaA, charaB) -> Bool in
            charaA < charaB
        }
        
        let sString = String(sArray)
        let tString = String(tArray)
        return sString == tString
    }
    
    // 5.验证回文字符串
    func isPalindrome(_ s: String) -> Bool {
        let sampleString = s.lowercased()
        let sArray = Array(sampleString)
        var leftIndex = 0
        var rightIndex = sArray.count - 1
        
        while (leftIndex < rightIndex) {
            if (!sArray[leftIndex].isNumber && !sArray[leftIndex].isLetter || sArray[leftIndex].isWhitespace) {
                leftIndex += 1
            } else if (!sArray[rightIndex].isNumber && !sArray[rightIndex].isLetter || sArray[rightIndex].isWhitespace) {
                rightIndex -= 1
            } else if (sArray[leftIndex] != sArray[rightIndex]) {
                return false
            } else {
                rightIndex -= 1
                leftIndex += 1
            }
        }
        return true
    }
    
    // 6.字符串转换整数 (atoi)
    func myAtoi(_ str: String) -> Int {
        var result = 0
        let sampleStr = str.trimmingCharacters(in: .whitespaces)
        if sampleStr.count == 0 {
            return result
        }
        let strArray: [Character] = Array(sampleStr)
        var numArray: [Character] = [Character]()
        var symbolArray: [Character] = [Character]()
        for (_, chara) in strArray.enumerated() {
            if chara.isNumber {
                numArray.append(chara)
            } else if (numArray.count > 0) {
                break
            } else if (chara.isMathSymbol || chara == Character("-")) {
                symbolArray.append(chara)
            } else {
                return 0
            }
        }
        
        if symbolArray.count > 1 {
            return 0
        } else if (symbolArray.contains("-")) {
            numArray.insert("-", at: 0)
        }
        
        let resultString = String(numArray)
        
        if let resultNum = Int(resultString) {
            if resultNum < Int(Int32.min) {
                return Int(Int32.min)
            }
            
            if resultNum > Int(Int32.max) {
                return Int(Int32.max)
            }
            
            result = Int(resultString) ?? 0
            
        } else {
            let maxInt32 = String(Int32.max)
            
            let minInt32 = String(Int32.min)
            
            if numArray.contains("-") && resultString.count > minInt32.count {
                return Int(Int32.min)
            } else if resultString.count > maxInt32.count {
                return Int(Int32.max)
            }
        }
        
        return result
    }
    
    // 7.实现strStr()
    func strStr(_ haystack: String, _ needle: String) -> Int {
        if needle.count == 0 {
            return 0
        }
        if haystack.count < needle.count {
            return -1
        }
        
        let hayStasckArray = Array(haystack)
        let needleArray = Array(needle)
        
        for (index, chara) in hayStasckArray.enumerated() {
            if chara == needleArray[0] {
                print("找到第一个相同的字符")
                if hayStasckArray.count - index >= needleArray.count {
                    print("指针数组的长度没有超过剩余字符")
                    var index3 = 0
                    let left = index
                    let right = index + needleArray.count - 1
                    if left == right {
                        return index
                    } else {
                        for index2 in left ... right {
                            if hayStasckArray[index2] == needleArray[index3] {
                                print("指针数组对上了原数组的一个元素")
                                if (index3 == needleArray.count - 1) {
                                    return index
                                }
                                index3 += 1
                            } else {
                                print("对不上指针数组的元素，退出循环")
                                break
                            }
                        }
                    }
                } else {
                    return -1
                }
            }
        }
        return -1
    }
    
    // 8.外观数列
    func countAndSay(_ n: Int) -> String {
        if n == 1 {
            return "1"
        } else if n == 2 {
            return "11"
        } else if n == 3 {
            return "21"
        } else if n == 4 {
            return "1211"
        } else if n == 5 {
            return "111221"
        } else {
            let strs = self.countAndSay(n - 1)
            let strsArray = Array(strs)
            var ss = [Character]()
            var count = 1
            var index = 1
            while index < strs.count {
                print("检查索引 i = \(index)")
                if strsArray[index] != strsArray[index - 1] {
                    ss.append(Character(String(count)))
                    ss.append(strsArray[index - 1])
                    count = 1
                    print("与前面的数不同，count不必增加")
                } else {
                    count += 1
                    print("与前面的数相同，count增加")
                }
                if index == strs.count - 1 {
                    print("i = \(index) 所有数遍历完毕，填入结尾")
                    ss.append(Character(String(count)))
                    ss.append(strsArray[index])
                }
                index += 1
            }
            return String(ss)
        }
    }
    
    // 9.最长公共前缀
    func longestCommonPrefix(_ strs: [String]) -> String {
        let count = strs.count
        
        if count == 0 {
            return ""
        }
        if count == 1 {
            return strs[0]
        }
        var result = strs[0]
        for i in 1 ..< count {
            while !strs[i].hasPrefix(result) {
                result = String(result.prefix(result.count - 1))
                if result.count == 0 {
                    return ""
                }
            }
        }
        return result
    }
}

class ListNode {
    public var val: Int
    public var next: ListNode?
    
    public init(_ val: Int) {
        self.val = val
        self.next = nil
    }
}

class LinkedListSolution {
    // 1.删除链表中的节点
    func deleteNode(_ node: ListNode?) {
        if let nextVal = node?.next?.val {
            node?.val = nextVal
            node?.next = node?.next?.next
        } else {
            return
        }
    }
    
    // 2.删除链表的倒数第N个节点
    func removeNthFromEnd(_ head: ListNode?, _ n: Int) -> ListNode? {
        if head == nil {
            return nil
        }
        var nodeArray = [ListNode]() // 构建数组
        // 取得最后一个节点
        var node = head
        while node?.next != nil {
            nodeArray.append(node!) // 将节点添加到数组
            node = node?.next ?? node
        }
        nodeArray.append(node!) // 添加最后一个节点
        if nodeArray.count < n {
            return nil
        } else {
            let index = nodeArray.count - n
            let targetNode = nodeArray[index] // 要删除的节点
            if let val = targetNode.next?.val {
                targetNode.val = val
                targetNode.next = targetNode.next?.next
                return nodeArray[0]
            } else { // 下一个节点没有值
                if index - 1 >= 0 {
                    let previousNode = nodeArray[index - 1] // 取上一个节点
                    previousNode.next = nil // 断开链条
                    return nodeArray[0]
                } else {
                    return nil
                }
            }
        }
    }
    
    // 3.反转链表
    func reverseList(_ head: ListNode?) -> ListNode? {
        if head == nil || head?.next == nil { // 传入值是空或是尾节点时返回原节点
            return head
        }
        let newhead = reverseList(head?.next) // 这样做可以确保此时的newhead应该是尾节点,因为非空节点都会在这里继续递归
        print("参数节点: \(head?.val ?? 0) 尾节点:\(newhead?.val ?? 0)")
        head?.next?.next = head // 此时head是倒数第二个节点,将尾节点的next指针指向自己,相当于反转了尾节点的指向
        head?.next = nil // 将尾节点置空
        return newhead // 返回尾节点即是新的头节点
    }
    
    // 4.合并两个有序链表
    func mergeTwoLists(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        guard let node1 = l1, let node2 = l2 else {
            if l1 == nil {
                return l2
            } else if l2 == nil {
                return l1
            } else {
                return nil
            }
        }
        
        if  node1.val < node2.val { // 当l10小于l20的时候,将l10放在前面,此时要返回的结果就是l1的剩下元素和l2的剩下元素的比较
            node1.next = self.mergeTwoLists(node1.next, l2)
            return node1
        } else {
            node2.next = self.mergeTwoLists(node1, node2.next) // 反之亦然
            return node2
        }
    }
    
    // 5.检测回文链表
    func isPalindrome(_ head: ListNode?) -> Bool {
        if head?.next == nil || head == nil {
            return false
        }
        
        var node = head
        
        var valArray = [Int]()
        
        while node!.next != nil {
            valArray.append(node!.val)
            node = node?.next
        }
        
        valArray.append(node!.val)
        
        var left = 0
        var right = valArray.count - 1
        
        while (left < right) {
            if valArray[left] != valArray[right] {
                return false
            } else {
                left += 1
                right -= 1
            }
        }
        return true
    }
    
    // 6.环形链表
    func hasCycle(_ head: ListNode?) -> Bool {
        if head == nil || head?.next == nil {
            return false
        }
        var slow = head
        var fast = head
        
        while fast != nil && fast?.next != nil {
            slow = slow?.next
            fast = fast?.next!.next
            if slow?.val == fast?.val {
                return true
            }
        }
        return false
    }
}

class SortSolution {
    // 1.合并两个数组并排序
    func merge(_ nums1: inout [Int], _ m: Int, _ nums2: [Int], _ n: Int) {
        nums1.removeSubrange(m..<nums1.count)
        nums1.append(contentsOf: nums2)
        nums1.sort { (num1, num2) -> Bool in
            num1 < num2
        }
    }

    // 2.第一个错误的版本
    func firstBadVersion(_ n: Int) -> Int {
        var leftVersion = 0
        var rightVersion = n
        while leftVersion < rightVersion {
            let mid: Int = leftVersion + (rightVersion - leftVersion) / 2
            if self.isBadVersion(mid) {
                rightVersion = mid
            } else {
                leftVersion = mid + 1
            }
        }
        return leftVersion
    }
    
    func isBadVersion(_ version: Int) -> Bool {
        return version >= 1
    }
}

let node1 = ListNode(1)
let node2 = ListNode(2)
let node3 = ListNode(3)
let node4 = ListNode(4)

node1.next = node2

LinkedListSolution().isPalindrome(node1)

