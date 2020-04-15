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

```swift
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
```

**思路**
线性代数中有转置矩阵的概念，就是将每个二位数组的行列下标交换，转置完成后对每个数组取反，就得到了旋转数组

## 字符串

### 1.反转字符串
编写一个函数，其作用是将输入的字符串反转过来。输入字符串以字符数组 char[] 的形式给出。

不要给另外的数组分配额外的空间，你必须原地修改输入数组、使用 O(1) 的额外空间解决这一问题。

你可以假设数组中的所有字符都是 ASCII 码表中的可打印字符。

```
示例 1：

输入：["h","e","l","l","o"]
输出：["o","l","l","e","h"]
示例 2：

输入：["H","a","n","n","a","h"]
输出：["h","a","n","n","a","H"]
```

**答案**
```swift
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
```

**思路**
这是非常基础的数组位换算，没什么好说的，但这里的解法并不是最优解，应该尝试怎样提升算法的性能


### 2.整数反转
给出一个 32 位的有符号整数，你需要将这个整数中每位上的数字进行反转。
```
示例 1:

输入: 123
输出: 321
```
```
 示例 2:

输入: -123
输出: -321
```
```
示例 3:

输入: 120
输出: 21
```
注意:

假设我们的环境只能存储得下 32 位的有符号整数，则其数值范围为 [−231,  231 − 1]。请根据这个假设，如果反转后整数溢出那么就返回 0。

**答案**
```swift
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
```

**思路**
简单来说就是把整形的个位单独取出，随后每增加一位前面的数都乘10，但根据题目提示我们要吧里面数字超出32位整型的限制即可

### 3.字符串中的第一个唯一字符

给定一个字符串，找到它的第一个不重复的字符，并返回它的索引。如果不存在，则返回 -1。
```
案例:

s = "leetcode"
返回 0.

s = "loveleetcode",
返回 2.
```

注意事项：您可以假定该字符串只包含小写字母。

**答案**
```swift
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
```
**思路**
使用双重循环是比较简单的办法，首先排除没有和只有一个字符的情况，然后执行双重循环，计算每个子循环中出现重复字符的情况，大于1就说明该索引字母有重复，马上结束本循环，返回没有循环的那个索引。但是本解法性能不佳。

### 4.有效的字母异位词

给定两个字符串 s 和 t ，编写一个函数来判断 t 是否是 s 的字母异位词。
```
示例 1:

输入: s = "anagram", t = "nagaram"
输出: true
```
```
示例 2:

输入: s = "rat", t = "car"
输出: false
```
说明:
你可以假设字符串只包含小写字母。

进阶:
如果输入字符串包含 unicode 字符怎么办？你能否调整你的解法来应对这种情况？

**答案**
```swift
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
```

**思路**
不要想得太复杂，既然是异位同词，那么按照一定的顺序排序后必定是相同的字符串。


### 5.验证回文字符串

给定一个字符串，验证它是否是回文串，只考虑字母和数字字符，可以忽略字母的大小写。

说明：本题中，我们将空字符串定义为有效的回文串。
```
示例 1:

输入: "A man, a plan, a canal: Panama"
输出: true
```
```
示例 2:

输入: "race a car"
输出: false
```

**答案**
```swift
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
```

**思路**
不要使用原生方法去除字符串里的空格和标点，直接在循环中去除可以提高筛查效率

### 6.字符串转换整数 (atoi)
请你来实现一个 atoi 函数，使其能将字符串转换成整数。

首先，该函数会根据需要丢弃无用的开头空格字符，直到寻找到第一个非空格的字符为止。接下来的转化规则如下：

如果第一个非空字符为正或者负号时，则将该符号与之后面尽可能多的连续数字字符组合起来，形成一个有符号整数。
假如第一个非空字符是数字，则直接将其与之后连续的数字字符组合起来，形成一个整数。
该字符串在有效的整数部分之后也可能会存在多余的字符，那么这些字符可以被忽略，它们对函数不应该造成影响。
注意：假如该字符串中的第一个非空格字符不是一个有效整数字符、字符串为空或字符串仅包含空白字符时，则你的函数不需要进行转换，即无法进行有效转换。

在任何情况下，若函数不能进行有效的转换时，请返回 0 。

提示：

本题中的空白字符只包括空格字符 ' ' 。
假设我们的环境只能存储 32 位大小的有符号整数，那么其数值范围为 [−231,  231 − 1]。如果数值超过这个范围，请返回  INT_MAX (231 − 1) 或 INT_MIN (−231) 。
 
```
示例 1:

输入: "42"
输出: 42
```
```
示例 2:

输入: "   -42"
输出: -42
解释: 第一个非空白字符为 '-', 它是一个负号。
     我们尽可能将负号与后面所有连续出现的数字组合起来，最后得到 -42 。
```
```
示例 3:

输入: "4193 with words"
输出: 4193
解释: 转换截止于数字 '3' ，因为它的下一个字符不为数字。
```
```
示例 4:

输入: "words and 987"
输出: 0
解释: 第一个非空字符是 'w', 但它不是数字或正、负号。
     因此无法执行有效的转换。
```
```
示例 5:

输入: "-91283472332"
输出: -2147483648
解释: 数字 "-91283472332" 超过 32 位有符号整数范围。 
     因此返回 INT_MIN (−231) 。
```

**答案**

```swift
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
```

**思路**
这个解法的性能非常差，但是好歹是自己想的，起码容易记住，首先去除字符串中的空格，随后转换成数组进行遍历，遍历的过程中将数字和+-号分别存放到两个数组中，一旦数字的队列已经开始，再遍历到非数字的字符就马上停止遍历，随后根据符号数组进行判断，超过一个正负符合转换都将作废，只有一个的情况下保留负号用于取反，最后得到的数字字符串再转换成数字同时计算有误超出Int32的范围就可以了。

### 7.实现strStr()
实现 strStr() 函数。

给定一个 haystack 字符串和一个 needle 字符串，在 haystack 字符串中找出 needle 字符串出现的第一个位置 (从0开始)。如果不存在，则返回  -1。
```
示例 1:

输入: haystack = "hello", needle = "ll"
输出: 2
```
```
示例 2:

输入: haystack = "aaaaa", needle = "bba"
输出: -1
```
说明:

当 needle 是空字符串时，我们应当返回什么值呢？这是一个在面试中很好的问题。

对于本题而言，当 needle 是空字符串时我们应当返回 0 。这与C语言的 strstr() 以及 Java的 indexOf() 定义相符。

**答案**

```swift
func strStr(_ haystack: String, _ needle: String) -> Int {
        if needle.count == 0 {
            return 0
        }
        let haystack = Array(haystack), needle = Array(needle)
        var i = 0, j = 0
        while i < haystack.count-needle.count+1 {
            while j < needle.count && i < haystack.count { // 这里得加上i < haystack.count，防止haystack越界
                if haystack[i] == needle[j] {
                    if j == needle.count-1 {
                        return i-j
                    }
                    i+=1
                    j+=1
                } else {
                    i=i-j+1
                    j=0
                    break
                }
            }
        }
        return -1
    }
```

**思路**
首先指针数组长度为0就直接返回0，然后将两个字符串数组化开始遍历，这里展示的是比较高效的算法，但是原理上都是确保指针数组的每个元素都能和原数组对的上

### 8.外观数列
「外观数列」是一个整数序列，从数字 1 开始，序列中的每一项都是对前一项的描述。前五项如下：

1.     1
2.     11
3.     21
4.     1211
5.     111221
1 被读作  "one 1"  ("一个一") , 即 11。
11 被读作 "two 1s" ("两个一"）, 即 21。
21 被读作 "one 2",  "one 1" （"一个二" ,  "一个一") , 即 1211。

给定一个正整数 n（1 ≤ n ≤ 30），输出外观数列的第 n 项。

注意：整数序列中的每一项将表示为一个字符串。

 
```
示例 1:

输入: 1
输出: "1"
解释：这是一个基本样例。
```
```
示例 2:

输入: 4
输出: "1211"
解释：当 n = 3 时，序列是 "21"，其中我们有 "2" 和 "1" 两组，"2" 可以读作 "12"，也就是出现频次 = 1 而 值 = 2；类似 "1" 可以读作 "11"。所以答案是 "12" 和 "11" 组合在一起，也就是 "1211"。
```

**答案**

```swift
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
```

**思路**
本体可以采用递归方式处理，首先获取上一个描述字符串，随后对字符串进行遍历，每一个索引下的字符必须与前一个相同，否则就要添加描述字符，分别是count数字的个数和索引下的数字，当遍历到最后一个索引的时候，将最后一个count和索引数字添加到字符串的结尾即可。

### 9.最长公共前缀
编写一个函数来查找字符串数组中的最长公共前缀。

如果不存在公共前缀，返回空字符串 ""。
```
示例 1:

输入: ["flower","flow","flight"]
输出: "fl"
```
```
示例 2:

输入: ["dog","racecar","car"]
输出: ""
解释: 输入不存在公共前缀。
```
说明:

所有输入只包含小写字母 a-z 。

**答案**
```swift
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
```

**思路**
这题比较优秀的解法就是取数组的第一个元素，然后对之后的每一个元素进行遍历，当发现有不同的元素的时候就将第一个元素的长度-1，最后剩下的就是最长前缀了

## 链表

### 1.删除链表中的节点

请编写一个函数，使其可以删除某个链表中给定的（非末尾）节点，你将只被给定要求被删除的节点。

现有一个链表 -- head = [4,5,1,9]，它可以表示为:

```
示例 1:

输入: head = [4,5,1,9], node = 5
输出: [4,1,9]
解释: 给定你链表中值为 5 的第二个节点，那么在调用了你的函数之后，该链表应变为 4 -> 1 -> 9.
```
```
示例 2:

输入: head = [4,5,1,9], node = 1
输出: [4,5,9]
解释: 给定你链表中值为 1 的第三个节点，那么在调用了你的函数之后，该链表应变为 4 -> 5 -> 9.
```

说明:

链表至少包含两个节点。
链表中所有节点的值都是唯一的。
给定的节点为非末尾节点并且一定是链表中的一个有效节点。
不要从你的函数中返回任何结果。

**答案**

```swift
func deleteNode(_ node: ListNode?) {
       if let nextVal = node?.next?.val {
            node?.val = nextVal
            node?.next = node?.next?.next
        } else {
            return
        }
    }
```

**思路**
传入的参数就是要删除的节点，那么很简单，只需要把这个节点承载的内容换成下一个节点的内容就可以了，相当于将链条的这一环替换成了下一环

### 2.删除链表的倒数第N个节点

给定一个链表，删除链表的倒数第 n 个节点，并且返回链表的头结点。

```
示例：

给定一个链表: 1->2->3->4->5, 和 n = 2.

当删除了倒数第二个节点后，链表变为 1->2->3->5.
```

说明：

给定的 n 保证是有效的。

进阶：

你能尝试使用一趟扫描实现吗？

**答案**

```swift
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
```

**思路**
使用一次遍历实现删除倒数第N个节点，意味着要在一次遍历的过程中将链表的长度和每个位置的节点都用数组储存起来，首先从头节点开始循环查找下一个，知道下一个节点不存在，这样链表就储存到数组里了，接着根据n来找到数组中第n个就是需要删除的目标，考虑三种情况，1是链表有下一个节点，此时只需要将被删除节点的值替换为下一个节点的值即可，另一种情况是链表没有下一个节点，此时要考虑是否有上一个节点，如果没有返回空，如果有则需要找到上一个节点并将它的下一个节点指针置空，这样就相当于删除了最后一个节点。

## 排序

### 1.给你两个有序整数数组 nums1 和 nums2，请你将 nums2 合并到 nums1 中，使 nums1 成为一个有序数组。

说明:

初始化 nums1 和 nums2 的元素数量分别为 m 和 n 。
你可以假设 nums1 有足够的空间（空间大小大于或等于 m + n）来保存 nums2 中的元素。
 
```
示例:

输入:
nums1 = [1,2,3,0,0,0], m = 3
nums2 = [2,5,6],       n = 3

输出: [1,2,2,3,5,6]
```

**答案**

```swift
func merge(_ nums1: inout [Int], _ m: Int, _ nums2: [Int], _ n: Int) {
        nums1.removeSubrange(m..<nums1.count)
        nums1.append(contentsOf: nums2)
        nums1.sort { (num1, num2) -> Bool in
            num1 < num2
        }
    }
```

**思路**
如果对Swift的数组切分操作很熟悉的话这题几乎是秒解，重点在给出的数组会在最后加上0填充位置，但传入的m值是不包含0在内的，因此由于Swift数组的方便特性，裁掉不用的0的部分然后简单的拼接排序即可。这种接法性能不是最好的，但是利用Swift的语言优势做解也未尝不可~

### 2.第一个错误的版本

你是产品经理，目前正在带领一个团队开发新的产品。不幸的是，你的产品的最新版本没有通过质量检测。由于每个版本都是基于之前的版本开发的，所以错误的版本之后的所有版本都是错的。

假设你有 n 个版本 [1, 2, ..., n]，你想找出导致之后所有版本出错的第一个错误的版本。

你可以通过调用 bool isBadVersion(version) 接口来判断版本号 version 是否在单元测试中出错。实现一个函数来查找第一个错误的版本。你应该尽量减少对调用 API 的次数。
```
示例:

给定 n = 5，并且 version = 4 是第一个错误的版本。

调用 isBadVersion(3) -> false
调用 isBadVersion(5) -> true
调用 isBadVersion(4) -> true

所以，4 是第一个错误的版本。 
```

**答案**

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

**思路**
这道题要通过活动边界的方式去解决，首先我们的范围是0到n，取中位数判断，若是错误版本，说明分界线在更前面或是刚好的位置，则将右边界缩小到mid的位置, 若是正确版本，说明分界线可能在更后的位置，要将左边界缩小到 mid + 1的位置
