import UIKit

// MARK: - Array

class ArraySolution {
    // 使数组的奇数位位于偶数位前面
    func exchange(_ nums: [Int]) -> [Int] {
        var ji = [Int]()
        var ou = [Int]()
        for num in nums {
            if num & 1 == 1 {
                // 奇数
                ji.append(num)
            } else {
                ou.append(num)
            }
        }
        ji.append(contentsOf: ou)
        return ji
    }
    
    // 旋转递增数组的最小元素
    func minArray(_ numbers: [Int]) -> Int {
        var leftIndex = 0
        var rightIndex = numbers.count - 1
        while leftIndex < rightIndex {
            if numbers[leftIndex] > numbers[leftIndex + 1] {
                return numbers[leftIndex + 1]
            }
            if numbers[rightIndex] < numbers[rightIndex - 1] {
                return numbers[rightIndex]
            }
            leftIndex += 1
            rightIndex -= 1
        }
        return numbers[0]
    }
    
    // 移除数组中的指定元素并返回新的数组长度
    func removeElement(_ nums: inout [Int], _ val: Int) -> Int {
        var length = 0
        for j in 0 ..< nums.count {
            if nums[j] != val {
                nums[length] = nums[j]
                length += 1
            }
        }
        return length
    }
    
    // 数组中的重复数字
    func findRepeatNumber(_ nums: [Int]) -> Int {
        let sortedArray = nums.sorted { (num1, num2) -> Bool in
            return num1 < num2
        }
        var slowIndex = 0
        for fastIndex in 1 ..< sortedArray.count {
            if sortedArray[fastIndex] != sortedArray[slowIndex] {
                slowIndex += 1
            } else {
                return sortedArray[fastIndex]
            }
        }
        return 0
    }
    
    // 查找矩阵中是否有目标数字
    func findNumberIn2DArray(_ matrix: [[Int]], _ target: Int) -> Bool {
        for array in matrix.reversed() {
            print(array)
            guard let firstNum = array.first else {
                return false
            }
            if target > firstNum {
                if self.findNumberInArray(array, target) {
                    return true
                } else {
                    continue
                }
            } else if target == firstNum {
                return true
            }
        }
        return false
    }
    
    func findNumberInArray(_ nums: [Int], _ target:Int) -> Bool {
        for index in 0 ..< nums.count {
            if target == nums[index] {
                return true
            }
        }
        return false
    }
    
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
    
    // 一次股票买卖的最大收益
    func maxProfit(_ prices: [Int]) -> Int {
        var result = 0
        for i in 0  ..< prices.count {
            for j in i + 1 ..< prices.count {
                let profit = prices[j] - prices[i]
                if profit > result {
                    result = profit
                }
            }
        }
        return result
    }
    
    // 0 ~ n - 1 找出数组中不连贯的那个数
    func missingNumber(_ nums: [Int]) -> Int {
        var left = 0
        var right = nums.count - 1
        while left <= right {
            let mid = (left + right) / 2
            if nums[mid] != mid {
                right = mid - 1
            } else {
                left = mid + 1
            }
        }
        return left
    }
    
    // 数组中重复次数超过长度一半的数字
    func majorityElement(_ nums: [Int]) -> Int {
        var results = [Int: Int]()
        for (_, num) in nums.enumerated() {
            if results[num] == nil {
                results.updateValue(1, forKey: num)
            } else {
                let count = results[num]
                results.updateValue(count! + 1, forKey: num)
                let result = results[num]
                if result! > nums.count / 2 {
                    return num
                }
            }
        }
        return 0
    }
    
    // 统计一个数字在排序数组中出现的次数
    func search(_ nums: [Int], _ target: Int) -> Int {
        var slowIndex = -1
        var result = 0
        for fastIndex in 0 ..< nums.count {
            if nums[fastIndex] == target && slowIndex < 0 { // 找到目标数的索引,将慢指针指向第一个出现的索引
                slowIndex = fastIndex
                result = 1
            }
            if slowIndex >= 0 && fastIndex != slowIndex {
                if nums[slowIndex] == nums[fastIndex] {
                    result += 1
                }
            }
        }
        return result
    }
    
    // 给定两个整数 n 和 k，返回范围 [1, n] 中所有可能的 k 个数的组合。 你可以按 任何顺序 返回答案.
    func combine(_ n: Int, _ k: Int) -> [[Int]] {
        var result = [[Int]]()
        var firstPath = [Int]()
        var tempArray = [Int](1...n)
        combineBackTrack(results: &result, numbers: &firstPath, startIndex: 0, tempArray: &tempArray, length: k)
        return result
    }
    
    func combineBackTrack(results: inout [[Int]], numbers: inout [Int], startIndex: Int, tempArray: inout [Int], length: Int) {
        // 设置终止条件
        guard numbers.count < length else {
            let newPath = Array(numbers)
            // 收集本次递归的结果
            results.append(newPath)
            return
        }
        // 构造用于查询的数组
        for (index, value) in tempArray.enumerated() {
            // 从startIndex的后一个值开始填充临时数组
            if (index < startIndex) {
                continue
            }
            // 剪枝操作, 减少不必要的循环次数
            if (index > tempArray.count - (length - numbers.count)) {
                break;
            }
            // 将元素加入临时数组
            numbers.append(value)
            // 递归调用, 查询下一层的叶子节点
            combineBackTrack(results: &results, numbers: &numbers, startIndex: index + 1, tempArray: &tempArray, length: length)
            // 递归完毕后, 执行回溯, 将本层递归改变的临时数组还原
            numbers.removeLast()
        }
    }
}

ArraySolution().combine(10, 3)

// MARK: - String

class StringSolution {
    // 将输入的字符串的大小写反转
    func cassedReversed(_ words: String) -> String {
        var result = [Character]()
        for (_, letter) in words.enumerated() {
            var newLetter = letter
            guard let ascValue = letter.asciiValue else {
                // 字符不是ascii字符,忽略
                result.append(newLetter)
                continue
            }
            // 通过将原字符按位与10000可以得知符号位的值是0还是1,如果1则是小写,0则是大写
            let ascIIZ = Character("Z").asciiValue!
            let ascIIz = Character("z").asciiValue!
            let ascIIA = Character("A").asciiValue!
            let ascIIa = Character("a").asciiValue!
            
            guard ascValue >= ascIIA && ascValue <= ascIIZ || ascValue >= ascIIa && ascValue <= ascIIz else {
                // 字符不是字母,忽略
                result.append(newLetter)
                continue
            }
            
            if (ascValue & 32) > 0 {
                // 原字符小写
                let scalar = UnicodeScalar(ascValue & 223)
                newLetter = Character(scalar) // 通过与运算使符号位变0,从小写变大写
            } else {
                // 原字符大写
                let scalar = UnicodeScalar(ascValue | 32)
                newLetter = Character(scalar) // 通过或运算使符号位变1,从大写变小写
            }
            
            result.append(newLetter)
        }
        return String(result)
    }
    
    func firstUniqChar2(_ s: String) -> Character {
        var charaHash = [Character: Int]()
        let characterArray = Array(s)
        for (index, chara) in characterArray.enumerated() {
            if charaHash[chara] == nil { // 如果字典中没有这个字符的索引则添加
                print("Index:\(index) Chara:\(chara)")
                charaHash[chara] = index
            } else { // 如果是已有的则将索引无效
                charaHash.updateValue(-1, forKey: chara)
            }
        }
        print(charaHash)
        var finalValue = characterArray.count - 1
        var finalKey = Character(" ")
        for (_, dict) in charaHash.enumerated() {
            guard dict.value >= 0 else {
                continue
            }
            if dict.value <= finalValue {
                finalValue = dict.value
                finalKey = dict.key
            }
        }
        return finalKey
    }
    
    // 替换字符串中的空格为%20
    func replaceSpace(_ s: String) -> String {
        let stringArray = Array(s)
        var resultString = [Character]()
        let replaceString = "%20"
        let replaceStringArray = Array(replaceString)
        for character in stringArray {
            if character.isWhitespace {
                resultString.append(contentsOf: replaceStringArray)
            } else {
                resultString.append(character)
            }
        }
        return String(resultString)
    }
    
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
    
    func isPalindromeNum(_ x: Int) -> Bool {
        if x < 0 { // 负数不可能是回文数
            return false
        } else if x <= 0 && x < 10 { // 0 - 9都只有一位数当然是回文数
            return true
        } else if x % 10 == 0 { // 可以被10整除的数不是回文数
            return false
        } else {
            var num = x
            var revers = 0
            
            while num > revers {
                revers = revers * 10 + num % 10
                num = num / 10
            }
            
            return num == revers || num == revers / 10
        }
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
    
    // 将一个字符串中的大写字母放在数组前,非字母放在数组中,小写字母放在数组最后
    func sortString(_ words: inout String) {
        let wordArray: [Character] = Array(words)
        var upperCase: [Character] = [Character]()
        var lowerCase: [Character] = [Character]()
        var others: [Character] = [Character]()
        for (_, chara) in wordArray.enumerated() {
            if !chara.isLetter {
                others.append(chara) // 非字母字符放入数组
            } else {
                if chara.isUppercase {
                    upperCase.append(chara)
                } else { 
                    lowerCase.append(chara)
                }
            }
        }
        print("大写字母: \(upperCase)")
        print("小写字母: \(lowerCase)")
        print("其他字符: \(others)")
        let upper = String(upperCase)
        let lower = String(lowerCase)
        let other = String(others)
        words = String("\(upper)\(other)\(lower)")
        print(words)
    }
    
    // 反转单词
    func reverseWords(_ s: String) -> String {
        var resultString = [String]()
        var words = s.components(separatedBy:" ")
        
        words.removeAll { (word) -> Bool in
            return word.isEmpty
        }
        
        let wordsReverse: [String] = words.reversed()
        print("\(wordsReverse)")
        for i in 0 ..< wordsReverse.count {
            resultString.append(wordsReverse[i])
            if i < wordsReverse.count - 1 { // 不是最后一个单词
                resultString.append(" ")
            }
        }
        return resultString.joined()
    }
}

var sampleWords = "ZhuangBility"

StringSolution().cassedReversed(sampleWords)

// MARK: - ListNode

class ListNode {
    public var val: Int
    public var next: ListNode?
    
    public init(_ val: Int) {
        self.val = val
        self.next = nil
    }
}

class LinkedListSolution {
    // 删除有序链表中的重复节点,用快慢指针法
    func deleteDuplicates(_ head: ListNode?) -> ListNode? {
        var node = head // 慢指针
        var next = head?.next // 快指针
        while node != nil && next != nil { //
            if node!.val != next!.val { // 慢指针进一位
                node = next
            } else { // 删除节点
                node?.next = next?.next
            }
            next = next?.next
        }
        return head
    }
    
    // 反向遍历链表
    func reversePrint(_ head: ListNode?) -> [Int] {
        var resultNodes = [Int]()
        guard let headNode = head else {
            return resultNodes
        }
        resultNodes.append(headNode.val)
        var node = headNode.next
        while node != nil {
            resultNodes.append(node!.val)
            node = node?.next
        }
        return resultNodes.reversed()
    }
    
    // 1.删除链表中的节点
    func deleteNode(_ node: ListNode?) {
        if let nextVal = node?.next?.val {
            node?.val = nextVal
            node?.next = node?.next?.next
        } else {
            return
        }
    }
    
    // 删除链表中的指定节点
    func deleteNode(_ head: ListNode?, _ val: Int) -> ListNode? {
        var node = head
        if node?.val == val { // 如果当前节点就是目标
            let target = node?.next
            node?.next = nil
            return target
        }
        while node != nil { // 当前节点不为空时继续循环
            if node?.next?.val == val { // 如果下个节点的值就是目标节点
                guard let nextNode = node?.next?.next else { // 如果没有下下个节点
                    node?.next = nil // 将下个节点置空
                    return head
                }
                node?.next = nextNode // 跳过下个节点将当前节点接到下下个节点上
            } else {
                node = node?.next
            }
        }
        return head
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
    
    // 链表倒数第K个节点
    func getKthFromEnd(_ head: ListNode?, _ k: Int) -> ListNode? {
        guard let node = head else {
            return nil
        }
        var nextNode: ListNode? = node
        var nodes = [ListNode]() // 创建数组
        while nextNode != nil {
            if nodes.count == k { // 数组最多只储存K个节点
                nodes.removeFirst()
            }
            nodes.append(nextNode!)
            nextNode = nextNode?.next
        }
        if nodes.count == k {
            return nodes[0]
        } else {
            return nil
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
    
    func reverseList2(_ head: ListNode?) -> ListNode? {
        var currentNode: ListNode? = head
        var preNode: ListNode? = nil
        var nextNode: ListNode? = nil
        while currentNode != nil {
            nextNode = currentNode!.next
            currentNode!.next = preNode
            preNode = currentNode
            currentNode = nextNode
        }
        return preNode
    }
    
    // 反转链表2
    func reverseBetween(_ head: ListNode?, _ m: Int, _ n: Int) -> ListNode? {
        if m == n {
            return head
        }
        var nodes = [ListNode]()
        var nodesVal = [Int]()
        var nextNode = head
        var appendBegin = false
        var position = 1
        while nextNode != nil {
            if position == m {
                nodes.append(nextNode!)
                nodesVal.append(nextNode!.val)
                appendBegin = true
            } else if position == n {
                nodes.append(nextNode!)
                nodesVal.append(nextNode!.val)
                appendBegin = false
            } else if appendBegin {
                nodesVal.append(nextNode!.val)
                nodes.append(nextNode!)
            }
            position += 1
            nextNode = nextNode!.next
        }
        
        print(nodesVal)
        
        let reversVals: [Int] = nodesVal.reversed()
        
        for i in 0 ..< nodes.count {
            nodes[i].val = reversVals[i]
        }
        
        return head
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
    
    // 检测环形链表的环节点
    func detectCycle(_ head: ListNode?) -> ListNode? {
        if head == nil {
            return nil
        }
        var fastIndex = head?.next
        var slowIndex = head?.next?.next
        while fastIndex != nil && slowIndex != nil {
            if fastIndex!.val == slowIndex!.val {
                
                var ringLength = 1
                var moveIndex = fastIndex?.next
                while moveIndex?.val != slowIndex?.val {
                    ringLength += 1
                    moveIndex = moveIndex?.next
                }
                
                return self.ringStart(head!, ringLength)
                
            } else {
                fastIndex = fastIndex!.next?.next
                slowIndex = slowIndex!.next
            }
        }
        return nil
    }
    
    func ringStart(_ head: ListNode, _ length: Int) -> ListNode {
        var slowIndex = head
        var fastIndex = head
        var tempLength = length
        while tempLength >= 0 {
            fastIndex = fastIndex.next!
            tempLength -= 1
        }
        
        while slowIndex.val != fastIndex.val {
            slowIndex = slowIndex.next!
            fastIndex = fastIndex.next!
        }
        return slowIndex
    }
}

// MARK: - Sort

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
    
    // 快速排序
    func partition(data:inout [Int],low:Int,high:Int) -> Int {
           let root = data[high]
           var index = low
           for i in low...high {
               if data[i] < root {
                   if i != index {
                    data.swapAt(i, index)
                   }
                   index = index+1
               }
           }
           
           if high != index {
            data.swapAt(high, index)
           }
           return index
       }
       
       func quickSort(data:inout [Int],low:Int,high:Int) -> Void {
           if low > high {
               return
           }
           let sortIndex = partition(data: &data, low: low, high: high)
           quickSort(data: &data, low: low, high: sortIndex-1)
           quickSort(data: &data, low: sortIndex+1, high: high)
       }
}

// MARK: - Tree

public class TreeNode {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?
    public init(_ val: Int) {
        self.val = val
        self.left = nil
        self.right = nil
    }
}

class TreeSolution {
    // 根据前序和中序遍历的结果重建二叉树
    func buildTree(_ preorder: [Int], _ inorder: [Int]) -> TreeNode? {
        if preorder.count == 0 {
            return nil
        }
        // 前序遍历的第一个节点一定是根节点
        guard let rootData = preorder.first else {
            return nil
        }
        for index in 0 ..< inorder.count {
            if inorder[index] == rootData { // 找到了根节点在中序遍历的位置
                let rootNode = TreeNode(rootData)
                rootNode.left = self.buildTree(Array(preorder[1 ..< 1 + index]), Array(inorder[0 ..< index]))
                rootNode.right = self.buildTree(Array(preorder[1 + index ..< preorder.count]), Array(inorder[index + 1 ..< inorder.count]))
                return rootNode
            }
        }
        return nil
    }
    
    func customMaxDepth(_ root: TreeNode?) -> Int {
        guard let node = root else {
            return 0
        }
        let leftDepth = customMaxDepth(node.left)
        let rightDepth = customMaxDepth(node.right)
        return 1 + max(leftDepth, rightDepth)
    }
    
    // 1.二叉树的最大深度
    func maxDepth(_ root: TreeNode?) -> Int {
        guard let rootNode = root else {
            return 0
        }
        
        let leftDepth = maxDepth(rootNode.left)
        let rightDepth = maxDepth(rootNode.right)
        
        return 1 + max(leftDepth, rightDepth)
    }
    
    
    func maxDepth2(_ head: TreeNode?) -> Int {
        guard let node = head else {
            return 0
        }
        let leftNode = maxDepth2(node.left)
        let rightNode = maxDepth2(node.right)
        
        return 1 + max(leftNode, rightNode)
    }
    
    func maxDepth3(_ head: TreeNode?) -> Int {
        guard let node = head else {
            return 0
        }
        let left = maxDepth3(node.left)
        let right = maxDepth3(node.right)
        return 1 + max(left, right)
    }
    
    func maxDepth4(_ root: TreeNode?) -> Int {
        guard let node = root else {
            return 0
        }
        let leftDepth = maxDepth(node.left)
        let rightDepth = maxDepth(node.right)
        return 1 + max(leftDepth, rightDepth)
    }
    
    func maxDepth5(_ root: TreeNode?) -> Int {
        guard let node = root else {
            return 0
        }
        let leftDepth = maxDepth(node.left)
        let rightDepth = maxDepth(node.right)
        return 1 + max(leftDepth, rightDepth)
    }
    
    func maxdepth6(_ root: TreeNode?) -> Int {
        guard let node = root else {
            return 0
        }
        
        let left = maxdepth6(node.left)
        let right = maxdepth6(node.right)
        
        return 1 + max(left, right)
    }
    
    func maxDepth7(_ root: TreeNode?) -> Int {
        guard let node = root else {
            return 0
        }
        let left = maxDepth7(node.left)
        let right = maxDepth7(node.right)
        return 1 + max(left, right)
    }
    
    func maxDepth8(_ root: TreeNode?) -> Int {
        guard let node = root else {
            return 0
        }
        let left = maxDepth8(node.left)
        let right = maxDepth8(node.right)
        return 1 + max(left, right)
    }
    
    func maxDepth9(_ root: TreeNode?) -> Int {
        guard let node = root else {
            return 0
        }
        return 1 + max(maxDepth9(node.left), maxDepth9(node.right))
    }
    
    // 2.验证二叉搜索树
    func isValidBST(_ root: TreeNode?) -> Bool {
        return isValidBSTUtil(root, Int.min, Int.max);
    }
    
    func isValidBSTUtil(_ node: TreeNode?,_ min: Int,_ max: Int) -> Bool {
        guard let node = node else {
            return true
        }
        //左节点需要小于根节点值，右节点需要大于根节点
        guard node.val > min && node.val < max else {
            return false
        }
        return isValidBSTUtil(node.left, min, node.val) && isValidBSTUtil(node.right, node.val, max)
    }
    
    // 3.对称二叉树
    func isSymmetric(_ root: TreeNode?) -> Bool {
        if root == nil {
            return true
        }
        return compareNode(root?.left, root?.right)
    }
    
    func compareNode(_ leftNode: TreeNode?, _ rightNode: TreeNode?) -> Bool {
        if leftNode == nil && rightNode == nil {
            return true
        } else if leftNode == nil && rightNode != nil {
            return false
        } else if leftNode != nil && rightNode == nil {
            return false
        } else {
            if (leftNode!.val != rightNode!.val) {
                return false
            }
            return compareNode(leftNode?.left, rightNode?.right) && compareNode(leftNode?.right, rightNode?.left)
        }
    }
    
    // 4.二叉树的层序遍历
    func levelOrder(_ root: TreeNode?) -> [[Int]] {
        guard root != nil else {
            return []
        }
        var queue = [TreeNode]()
        var res = [[Int]]()
        queue.append(root!)
        while !queue.isEmpty {
            let size = queue.count
            var level = [Int]() // 用于存放每一层的值
            for _ in 0 ..< size {
                let node = queue.removeFirst()
                level.append(node.val)
                if let leftSubNode = node.left {
                    queue.append(leftSubNode)
                }
                if let rightSubNode = node.right {
                    queue.append(rightSubNode)
                }
            }
            res.append(level)
        }
        return res
    }
    
    // 5.将有序数组转换为高度平衡的二叉搜索树
    func sortedArrayToBST(_ nums: [Int]) -> TreeNode? {
        if nums.isEmpty {
            return nil
        }
        return getTree(nums, 0, nums.count - 1)
    }
    
    func getTree(_ nums: [Int], _ left: Int, _ right: Int) -> TreeNode? {
        guard left <= right else {
            return nil
        }
        let mid = (left + right) / 2
        let node = TreeNode(nums[mid])
        //对mid索引的处理不能忘记
        node.left = getTree(nums, left, mid - 1)
        node.right = getTree(nums, mid + 1, right)
        return node
    }
    
    // 二叉树的前序遍历 (MLR)
    func preOrderTraversell(head: TreeNode?) -> [Int] {
        var result = [Int]() // 实例化结果数组
        var stack = [TreeNode]() // 用来缓存节点的栈
        var node = head
        
        while !stack.isEmpty || node != nil { // 栈或者节点不为空时循环
            if node != nil { // 节点不为空的情况
                result.append(node!.val) // 遍历节点值
                print("Node Val: \(node!.val)")
                stack.append(node!) // 本节点入栈
                node = node!.left // 按照前序遍历的顺序下一个应该是左节点
            } else {
                node = stack.removeLast().right // 已经到达叶节点,出栈,并开始遍历右节点
            }
        }
        return result
    }
    
    // 二叉树的中序遍历 (LMR)
    func midOrderTraversell(head: TreeNode?) -> [Int] {
        var result = [Int]() // 实例化结果数组
        var stack = [TreeNode]() // 用来缓存节点的栈
        var node = head
        
        while !stack.isEmpty || node != nil { // 栈或者节点不为空时循环
            while node != nil { // 节点不为空的情况
                stack.append(node!) // 节点入栈
                node = node?.left // 继续遍历左节点
            }
            if (!stack.isEmpty) { // 如果栈内非空
                node = stack.removeLast() // 取出栈顶的节点
                result.append(node!.val) // 遍历节点
                print("Node Val: \(node!.val)")
                node = node!.right // 遍历右节点
            }
        }
        
        return result
    }
    
    // 二叉树的后序遍历 (LRM)
    func postOrderTraversell(head: TreeNode?) -> [Int] {
        var result = [Int]() // 实例化结果数组
        var stack1 = [TreeNode]() // 实例化栈1
        var stack2 = [TreeNode]() // 实例化栈2
        var node = head
        if node != nil {
            stack1.append(node!) // 将参数节点压入栈1
            while !stack1.isEmpty {
                node = stack1.removeLast() // 从栈1取出节点
                stack2.append(node!) // 压入栈2
                if node!.left != nil { // 当节点仍有做子树时优先将左子树压入栈1
                    stack1.append(node!.left!)
                }
                if node!.right != nil {
                    stack1.append(node!.right!)
                }
            }
        }
        while !stack2.isEmpty {
            let sampleNode = stack2.removeLast() // 遍历栈2的每个节点,就是后续遍历
            result.append(sampleNode.val)
            print("Node Val: \(sampleNode.val)")
        }
        return result
    }
    
    // 二叉树的第K大节点
    
    // 思路: 因为二叉搜索树的值排序是左-根-右这样排的,因此使用中序遍历可以得出排序号的数组,然后取出对应位置的数即可
    
    func kthLargest(_ root: TreeNode?, _ k: Int) -> Int {
        var treeArray = [Int]()
        midPrint(&treeArray, node: root)
        print("TreeArray: \(treeArray)")
        if treeArray.count >= k {
            return treeArray[treeArray.count - k]
        } else {
           return 0
        }
    }
    // 中序遍历
    func midPrint(_ tree: inout [Int], node: TreeNode?) {
        guard let nextNode = node else {
            return
        }
        midPrint(&tree, node: nextNode.left)
        tree.append(nextNode.val)
        midPrint(&tree, node: nextNode.right)
    }
    
    // 将二叉树镜像
    func mirrorTree(_ root: TreeNode?) -> TreeNode? {
        guard let _ = root else {
            return nil
        }
        mirrorTree(root?.left)
        mirrorTree(root?.right)
        let leftNode: TreeNode? = root?.left
        root?.left = root?.right
        root?.right = leftNode
        return root
    }
    
    // 判断输入的数组是不是二叉搜索树的后序遍历
    func verifyPostorder(_ postorder: [Int]) -> Bool {
        if postorder.count == 0 || postorder.count == 1 {
            return true
        }
        var i = 0
        let length = postorder.count
        let rootNode = postorder.last!
        // 遍历根节点以外的所有节点
        for num in postorder[0 ..< length - 1] {
            if num > rootNode {
                break // 由于二叉搜索树是左子树都小于根节点,右子树都大于根节点,因此通过这个判断可以找到i就是数组中右子树开始的位置
            }
            i += 1
        }
        if i < length - 1 {
            for num in postorder[i ..< length - 1] { // 检查右子树
                if num < rootNode { // 如果右子树有小于根节点的,那就不是二叉搜索树的后序遍历
                    return false
                }
            }
        }
        
        var leftResult = true
        
        if i > 0 {
            leftResult = verifyPostorder(Array(postorder[0 ..< i]))
        }
        
        var rightResult = true
        
        if i < (length - 1) {
            rightResult = verifyPostorder(Array(postorder[i ..< length - 1]))
        }
        
        return leftResult && rightResult
    }
}

class DynamicSolution {
    
    // 构建结果数组,减少运算次数
    var results = [Int]()
    
    // 给出斐波那契数列中第n个数的值
    func fib(_ n: Int) -> Int {
        self.results.append(0)
        self.results.append(1)
        var index = 2
        while index <= n {
            let temp = results[index - 1] + results[index - 2] % 10_0000_0007
            results.append(temp)
            index += 1
        }
        return results[n]
    }
    
    func fib2(_ n: Int) -> Int {
        results.append(0)
        results.append(1)
        var index = 2
        while index <= n {
            let temp = results[index - 1] + results[index - 2]
            results.append(temp)
            index += 1
        }
        return results[n]
    }
    
    func tribonacci(_ n: Int) -> Int {
        results.append(0)
        results.append(1)
        results.append(1)
        var index = 3
        while index <= n {
            let temp = results[index - 1] + results[index - 2] + results[index - 3]
            results.append(temp)
            index += 1
        }
        return results[n]
    }
    
    func fib3(_ n: Int) -> Int {
        results.append(0)
        results.append(1)
        var index = 2
        while index <= n {
            let temp = results[index - 1] + results[index - 2]
            results.append(temp)
            index += 1
        }
        return results[n]
    }
    
    // 青蛙一次可以跳1或2级台阶,请问跳n级台阶有多少种跳法? 这是动态规划问题
    func numWays(_ n: Int) -> Int {
        results.append(1)
        results.append(1)
        var index = 2
        while index <= n {
            let temp = (results[index - 1] + results[index - 2]) % 10_0000_0007
            results.append(temp)
            index += 1
        }
        return results[n]
    }
}

class Stack {
    var array: [Int] = [Int]()
    
    var isEmpty: Bool {
        return array.isEmpty
    }
    
    var top: Int? {
        return self.array.last
    }
    
    func pop() -> Int {
        guard let last = array.last else {
            return -1
        }
        array.removeLast()
        return last
    }
    
    func push(_ n: Int) {
        array.append(n)
    }
}

class CQueue {
    let stackA = Stack()
    let stackB = Stack()
    
    init() {
        
    }
    
    func appendTail(_ value: Int) {
        stackA.push(value)
    }
    
    func deleteHead() -> Int {
        if stackB.isEmpty {
            while !stackA.isEmpty {
                stackB.push(stackA.pop())
            }
        }
        
        if stackB.isEmpty {
            return -1
        }
        return stackB.pop()
    }
}

class mathSolution {
    // 实现自己的次方运算
    func myPow(_ x: Double, _ n: Int) -> Double {
        if n == 0 { // 任何数的0次方都是1
            return 1
        }
        if n < 0 { // 小于0的次方运算等于其倒数的次方
            return myPow(1 / x, -n)
        }
        var bottom = x
        var square = n
        while square > 0 {
            if square & 1 == 1 { // 取次方值二进制形式的第一位,目的是判断是否是奇数次方,奇数次方无法通过左移的形式消除
                return bottom * myPow(bottom, square - 1)
            }
            bottom = bottom * bottom
            square >>= 1
        }
        return bottom
    }
    
    // 返回最大的n位数为最后一个元素的数组
    func printNumbers(_ n: Int) -> [Int] {
        var result = [Int]()
        let max = myPow(10, n)
        let finalElement = Int(max) - 1
        for num in 1 ... finalElement {
            result.append(num)
        }
        return result
    }
    
    // 构建乘积数组
    func constructArr(_ a: [Int]) -> [Int] {
        // 创建初始的结果数组
        var result = Array.init(repeating: 1, count: a.count)
        var left = 1
        for i in 0 ..< a.count {
            result[i] = left
            left *= a[i]
        }

        var right = 1
        for i in (0 ..< a.count).reversed() {
            result[i] *= right
            right *= a[i]
        }

        return result
    }
}

class matrixSolution {
    
    enum Direction {
        case right
        case down
        case left
        case up
    }
    
    struct Position {
        var row: Int
                var col: Int
                var loop: Int // 圈数
                var direction: Direction // 当前方向
    }
    
    func spiralOrder(_ matrix: [[Int]]) -> [Int] {
        var result = [Int]()
        if matrix.count == 0 || matrix[0].count == 0 {
            return result
        }
        var currentPosition: Position? = Position(row: 0, col: 0, loop: 0, direction: .right)
        while currentPosition != nil {
            result.append(matrix[currentPosition!.row][currentPosition!.col]) // 判断当前方向是否向右
            if currentPosition!.direction == .right {
                if currentPosition!.col + 1 < (matrix[currentPosition!.row].count - currentPosition!.loop) {
                    currentPosition!.col += 1
                    continue
                }
            }
            // 无法向右或是本来就向下的情况
            if currentPosition!.direction == .right || currentPosition!.direction == .down {
                if currentPosition!.row + 1 < matrix.count - currentPosition!.loop {
                    currentPosition!.row += 1
                    currentPosition?.direction = .down
                    continue
                }
            }
            // 无法向下或是本来就向左的情况
            if currentPosition!.direction == .down || currentPosition!.direction == .left {
                if currentPosition!.col - 1 >= 0 + currentPosition!.loop {
                    currentPosition!.col -= 1
                    currentPosition!.direction = .left
                    continue
                }
            }
            // 无法向左或是本来就向上的情况
            if currentPosition!.direction == .left || currentPosition!.direction == .up {
                if currentPosition!.row - 1 > 0 + currentPosition!.loop {
                    currentPosition!.row -= 1
                    currentPosition!.direction = .up
                    continue
                }
            }
            
            let loop = currentPosition!.loop + 1
            // 判断能否进入下一圈
            if currentPosition!.col + 1 < matrix[currentPosition!.row].count - loop && currentPosition!.row < matrix.count - loop {
                currentPosition!.col += 1
                currentPosition!.loop = loop
                currentPosition!.direction = .right
                continue
            }
            
            currentPosition = nil
        }
        return result
    }
}

matrixSolution().spiralOrder([[1,2,3],[4,5,6],[7,8,9]])
