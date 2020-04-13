# LeetCodeTest
力扣的测试题

## 数组

### 1.删除排序数组中的重复项
给定一个排序数组，你需要在 原地 删除重复出现的元素，使得每个元素只出现一次，返回移除后数组的新长度。
不要使用额外的数组空间，你必须在 原地 修改输入数组 并在使用 O(1) 额外空间的条件下完成。
 
```
示例 1:

给定数组 nums = [1,1,2], 

函数应该返回新的长度 2, 并且原数组 nums 的前两个元素被修改为 1, 2。 

你不需要考虑数组中超出新长度后面的元素。
```
```
示例 2:

给定 nums = [0,0,1,1,1,2,2,3,3,4],

函数应该返回新的长度 5, 并且原数组 nums 的前五个元素被修改为 0, 1, 2, 3, 4。

你不需要考虑数组中超出新长度后面的元素。
```

**答案**
```swift
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
```

**思路**
这个考的是数组去重，在这里使用的是快慢指针法，首先定义慢指针(只有出现的值和之前不同的时候才进位)， 然后定义快指针(正常的迭代下标), 实例化用于输出的数组，并第一位赋值为参数数组的第一位，对参数数组执行循环的时候，当快指针迭代到的数字与慢指针不同时，慢指针+1并且将新数组慢指针下标的值赋值为参数数组此时快指针指向的数字

### 2.买卖股票的最大利润
给定一个数组，它的第 i 个元素是一支给定股票第 i 天的价格。

设计一个算法来计算你所能获取的最大利润。你可以尽可能地完成更多的交易（多次买卖一支股票）。

注意：你不能同时参与多笔交易（你必须在再次购买前出售掉之前的股票）。
```
示例 1:

输入: [7,1,5,3,6,4]
输出: 7
解释: 在第 2 天（股票价格 = 1）的时候买入，在第 3 天（股票价格 = 5）的时候卖出, 这笔交易所能获得利润 = 5-1 = 4 。
     随后，在第 4 天（股票价格 = 3）的时候买入，在第 5 天（股票价格 = 6）的时候卖出, 这笔交易所能获得利润 = 6-3 = 3 。
```
```
示例 2:

输入: [1,2,3,4,5]
输出: 4
解释: 在第 1 天（股票价格 = 1）的时候买入，在第 5 天 （股票价格 = 5）的时候卖出, 这笔交易所能获得利润 = 5-1 = 4 。
     注意你不能在第 1 天和第 2 天接连购买股票，之后再将它们卖出。
     因为这样属于同时参与了多笔交易，你必须在再次购买前出售掉之前的股票。
```
```
示例 3:

输入: [7,6,4,3,1]
输出: 0
解释: 在这种情况下, 没有交易完成, 所以最大利润为 0。
```

**答案**
```swift
func maxProfit(_ stockPrice: [Int]) -> Int {
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
```

**思路**
由于没有买卖的次数限制，因此想要达到利润最大化，可以使用贪心算法的思路去解决问题由局部最优达到全局最优，简单来说就是对数组进行迭代，当发现后一天的价格比前一天要高的时候就卖出，这样就能得到最大利润。

### 3.旋转数组
给定一个数组，将数组中的元素向右移动 k 个位置，其中 k 是非负数。
```
示例 1:

输入: [1,2,3,4,5,6,7] 和 k = 3
输出: [5,6,7,1,2,3,4]
解释:
向右旋转 1 步: [7,1,2,3,4,5,6]
向右旋转 2 步: [6,7,1,2,3,4,5]
向右旋转 3 步: [5,6,7,1,2,3,4]
```
```
示例 2:

输入: [-1,-100,3,99] 和 k = 2
输出: [3,99,-1,-100]
解释: 
向右旋转 1 步: [99,-1,-100,3]
向右旋转 2 步: [3,99,-1,-100]
```
说明:

尽可能想出更多的解决方案，至少有三种不同的方法可以解决这个问题。
要求使用空间复杂度为 O(1) 的 原地 算法。

**答案**
```swift
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
```

**思路**
题目提示使用复杂度为O(1)的算法，意思是函数每行代码的执行次数与数组长度无关，可见最简单的做法就是使用数组切片方法了，这道题可以熟悉Swift的数组操作

### 4.存在重复元素
给定一个整数数组，判断是否存在重复元素。

如果任意一值在数组中出现至少两次，函数返回 true 。如果数组中每个元素都不相同，则返回 false 。
```
示例 1:

输入: [1,2,3,1]
输出: true
```
```
示例 2:

输入: [1,2,3,4]
输出: false
示例 3:

输入: [1,1,1,3,3,4,3,2,4,2]
输出: true
```

**答案**
```swift
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
```

**思路**
这个题目和第1题相似,区别是第一题的数组是排序好的，而这一题是乱序的，很容易想到再使用快慢指针法去解题，但因为是乱序数组，首先要做的是对数组进行排序，具体排序方式因人而异，我尝试过使用冒泡排序但是时间超时了，在这里就偷懒用了Swift原生的排序方法，不得不说性能比我自己写的要高，排序完毕后和第一题一样使用双指针法就可以解题了。

### 5.只出现一次的数字
给定一个非空整数数组，除了某个元素只出现一次以外，其余每个元素均出现两次。找出那个只出现了一次的元素。

说明：

你的算法应该具有线性时间复杂度。 你可以不使用额外空间来实现吗？
```
示例 1:

输入: [2,2,1]
输出: 1
```
```
示例 2:

输入: [4,1,2,1,2]
输出: 4
```

**答案**
```swift
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
```
**思路**
这个问题用到了Set的特性，Set不允许重复元素存在，为了取出唯一没有重复的元素，首先需要将所有的可能性用Set归纳，随后遍历数组，对每个元素尝试插入到一个新的Set中，如果返回的元组中表示插入失败，则这个数字是重复的，应该从归纳的Set中移除，最后剩下的就是没有重复的那个数字了。

### 6.两个数组的交集

给定两个数组，编写一个函数来计算它们的交集。
```
示例 1:

输入: nums1 = [1,2,2,1], nums2 = [2,2]
输出: [2,2]
```
```
示例 2:

输入: nums1 = [4,9,5], nums2 = [9,4,9,8,4]
输出: [4,9]
```
说明：

输出结果中每个元素出现的次数，应与元素在两个数组中出现的次数一致。
我们可以不考虑输出结果的顺序。

**答案**
```swift
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
```
**思路**
这题需要同时遍历两个数组，但是注意在遍历开始之前必须先排序，排序后就可以在同样的位置上比较两个数是否相等，相等即可添加到结果数组

### 7.加一

给定一个由整数组成的非空数组所表示的非负整数，在该数的基础上加一。

最高位数字存放在数组的首位， 数组中每个元素只存储单个数字。

你可以假设除了整数 0 之外，这个整数不会以零开头。
```
示例 1:

输入: [1,2,3]
输出: [1,2,4]
解释: 输入数组表示数字 123。
```
```
示例 2:

输入: [4,3,2,1]
输出: [4,3,2,2]
解释: 输入数组表示数字 4321。
```

**答案**
```swift
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
```
**思路**
这道题看似简单，其实重点在于最后一位为9的情况下前面一位就要进1，这样如果参数数组是9999的话整个数组长度要+1，首先对数组进行反向遍历，将最后一位+1，然后检查前一位是否是10，如果是则自身所在位要进1。遍历完毕后，根据第一位是否是10来判断是否要将整个数组的长度加1，否则只需要将数组中的10替换为0即可。

### 8.移动零

给定一个数组 nums，编写一个函数将所有 0 移动到数组的末尾，同时保持非零元素的相对顺序。
```
示例:

输入: [0,1,0,3,12]
输出: [1,3,12,0,0]
```
说明:

必须在原数组上操作，不能拷贝额外的数组。
尽量减少操作次数。

**答案**
```swift
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
```
**思路**
这题非常简单，首先实例化一个全是0的同样长度的数组，然后用快慢指针，当遇到不是0的时候慢指针+1且新数组慢指针的位置替换为快指针的数，最后的0自然保留即可

### 9.两数之和

给定一个整数数组 nums 和一个目标值 target，请你在该数组中找出和为目标值的那 两个 整数，并返回他们的数组下标。

你可以假设每种输入只会对应一个答案。但是，你不能重复利用这个数组中同样的元素。
```
示例:

给定 nums = [2, 7, 11, 15], target = 9

因为 nums[0] + nums[1] = 2 + 7 = 9
所以返回 [0, 1]
```
**答案**
```swift
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
```
**思路**
这道题有两个重点，1是求两个数的和等于目标，2是找出对应的下标，那操作就很简单，首先遍历数组已值为键以下标为值生成字典，随后再遍历一次数组，目标数减去数组的某个值，刚好可以在字典中找到对应的下标时，当前的下标和字典中的值就是返回的数组，但是注意有一个陷阱，若数组中有值刚好是目标的一半时，函数会返回两个相同的下标，为了避免这种情况应当将相同下标的情况排除。

### 10.有效的数独

判断一个 9x9 的数独是否有效。只需要根据以下规则，验证已经填入的数字是否有效即可。

数字 1-9 在每一行只能出现一次。
数字 1-9 在每一列只能出现一次。
数字 1-9 在每一个以粗实线分隔的 3x3 宫内只能出现一次。


上图是一个部分填充的有效的数独。

数独部分空格内已填入了数字，空白格用 '.' 表示。
```
示例 1:

输入:
[
  ["5","3",".",".","7",".",".",".","."],
  ["6",".",".","1","9","5",".",".","."],
  [".","9","8",".",".",".",".","6","."],
  ["8",".",".",".","6",".",".",".","3"],
  ["4",".",".","8",".","3",".",".","1"],
  ["7",".",".",".","2",".",".",".","6"],
  [".","6",".",".",".",".","2","8","."],
  [".",".",".","4","1","9",".",".","5"],
  [".",".",".",".","8",".",".","7","9"]
]
输出: true
```
```
示例 2:

输入:
[
  ["8","3",".",".","7",".",".",".","."],
  ["6",".",".","1","9","5",".",".","."],
  [".","9","8",".",".",".",".","6","."],
  ["8",".",".",".","6",".",".",".","3"],
  ["4",".",".","8",".","3",".",".","1"],
  ["7",".",".",".","2",".",".",".","6"],
  [".","6",".",".",".",".","2","8","."],
  [".",".",".","4","1","9",".",".","5"],
  [".",".",".",".","8",".",".","7","9"]
]
输出: false
```
解释: 除了第一行的第一个数字从 5 改为 8 以外，空格内其他数字均与 示例1 相同。
     但由于位于左上角的 3x3 宫内有两个 8 存在, 因此这个数独是无效的。
说明:

一个有效的数独（部分已被填充）不一定是可解的。
只需要根据以上规则，验证已经填入的数字是否有效即可。
给定数独序列只包含数字 1-9 和字符 '.' 。
给定数独永远是 9x9 形式的。

**答案**
```swift
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
```
**思路**
首先这道题要明白数独有效的条件:1.每一行没有重复的数字 2.每一列没有重复的数字 3.每个九宫格没有重复的数字 ，理解了这一点之后，就可以利用之前实现过的判断没有重复数字的函数去检查，难点就在于将这些数字组成相应的数组，这里采用的方式是将整个数组版分为9个宫，后计算每个宫符合要求的行数和列数，在遍历的过程中将符合要求的数字放进新的数组中。时间复杂度是O(9n²)

### 11.旋转图像

给定一个 n × n 的二维矩阵表示一个图像。

将图像顺时针旋转 90 度。

说明：

你必须在原地旋转图像，这意味着你需要直接修改输入的二维矩阵。请不要使用另一个矩阵来旋转图像。
```
示例 1:

给定 matrix = 
[
  [1,2,3],
  [4,5,6],
  [7,8,9]
],

原地旋转输入矩阵，使其变为:
[
  [7,4,1],
  [8,5,2],
  [9,6,3]
]
```
```
示例 2:

给定 matrix =
[
  [ 5, 1, 9,11],
  [ 2, 4, 8,10],
  [13, 3, 6, 7],
  [15,14,12,16]
], 

原地旋转输入矩阵，使其变为:
[
  [15,13, 2, 5],
  [14, 3, 4, 1],
  [12, 6, 8, 9],
  [16, 7,10,11]
]
```

**答案**

**思路**

