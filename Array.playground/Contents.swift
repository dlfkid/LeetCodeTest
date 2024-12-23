import Cocoa

class ArraySolution {
    
    /*
     给你一个数组 nums 和一个值 val，你需要 原地 移除所有数值等于 val 的元素，并返回移除后数组的新长度。

     不要使用额外的数组空间，你必须仅使用 O(1) 额外空间并 原地 修改输入数组。

     元素的顺序可以改变。你不需要考虑数组中超出新长度后面的元素。

      

     说明:

     为什么返回数值是整数，但输出的答案是数组呢?

     请注意，输入数组是以「引用」方式传递的，这意味着在函数里修改输入数组对于调用者是可见的。

     你可以想象内部操作如下:

     // nums 是以“引用”方式传递的。也就是说，不对实参作任何拷贝
     int len = removeElement(nums, val);

     // 在函数里修改输入数组对于调用者是可见的。
     // 根据你的函数返回的长度, 它会打印出数组中 该长度范围内 的所有元素。
     for (int i = 0; i < len; i++) {
         print(nums[i]);
     }
      

     示例 1：

     输入：nums = [3,2,2,3], val = 3
     输出：2, nums = [2,2]
     解释：函数应该返回新的长度 2, 并且 nums 中的前两个元素均为 2。你不需要考虑数组中超出新长度后面的元素。例如，函数返回的新长度为 2 ，而 nums = [2,2,3,3] 或 nums = [2,2,0,0]，也会被视作正确答案。


     来源：力扣（LeetCode）
     链接：https://leetcode.cn/problems/remove-element
     著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
     */
    func removeElement(_ nums: inout [Int], _ val: Int) -> Int {
        var slow = 0
        var fast = 0
        while fast < nums.count {
            // 当前遍历元素与目标不相同时，向前遍历
            if nums[fast] != val {
                nums[slow] = nums[fast]
                slow += 1
            }
            fast += 1
        }
        print(nums)
        return slow
    }
    
    /*80.给你一个有序数组 nums ，请你 原地 删除重复出现的元素，使得出现次数超过两次的元素只出现两次 ，返回删除后数组的新长度。
     
     不要使用额外的数组空间，你必须在 原地 修改输入数组 并在使用 O(1) 额外空间的条件下完成。

      

     说明：

     为什么返回数值是整数，但输出的答案是数组呢？

     请注意，输入数组是以「引用」方式传递的，这意味着在函数里修改输入数组对于调用者是可见的。

     你可以想象内部操作如下:

     // nums 是以“引用”方式传递的。也就是说，不对实参做任何拷贝
     int len = removeDuplicates(nums);

     // 在函数里修改输入数组对于调用者是可见的。
     // 根据你的函数返回的长度, 它会打印出数组中 该长度范围内 的所有元素。
     for (int i = 0; i < len; i++) {
         print(nums[i]);
     }
      

     示例 1：

     输入：nums = [1,1,1,2,2,3]
     输出：5, nums = [1,1,2,2,3]
     解释：函数应返回新长度 length = 5, 并且原数组的前五个元素被修改为 1, 1, 2, 2, 3。 不需要考虑数组中超出新长度后面的元素。
     示例 2：

     输入：nums = [0,0,1,1,1,1,2,3,3]
     输出：7, nums = [0,0,1,1,2,3,3]
     解释：函数应返回新长度 length = 7, 并且原数组的前七个元素被修改为 0, 0, 1, 1, 2, 3, 3。不需要考虑数组中超出新长度后面的元素。
*/
    func removeDuplicates(_ nums: inout [Int]) -> Int {
        guard nums.count > 2 else {
            return nums.count
        }
        var slow = 2
        var fast = 2
        while fast < nums.count {
            let val = nums[fast]
            let previous2 = nums[slow - 2]
            if val != previous2 {
                nums[slow] = nums[fast]
                slow += 1
            }
            fast += 1
        }
        print("result: \(nums)")
        return slow
    }
    
    /*
     给定一个 n 个元素有序的（升序）整型数组 nums 和一个目标值 target  ，写一个函数搜索 nums 中的 target，如果目标值存在返回下标，否则返回 -1。


     示例 1:

     输入: nums = [-1,0,3,5,9,12], target = 9
     输出: 4
     解释: 9 出现在 nums 中并且下标为 4
     示例 2:

     输入: nums = [-1,0,3,5,9,12], target = 2
     输出: -1
     解释: 2 不存在 nums 中因此返回 -1
      

     来源：力扣（LeetCode）
     链接：https://leetcode.cn/problems/binary-search
     著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
     */
    func search(_ nums: [Int], _ target: Int) -> Int {
        // 采用左闭右开规则
        var resultIndex = -1
        // 起始左边界是0， 右边界是数组长度
        var left = 0, right = nums.count
        // 因为是左闭右开，所以这里左边界必须小于右边界
        while left < right {
            // 计算出中间下标，左右下标除以2
            var middle = (right + left) / 2
            // 根据和目标值的关系重新获取区间
            if nums[middle] < target {
                // 因为是左闭右开区间left不变的话会再次把这个下标判断一次，这里left必须+1。
                left = middle + 1
            } else if nums[middle] > target {
                right = middle
            } else {
                // 找到目标值退出循环
                resultIndex = middle
                break
            }
        }
        return resultIndex
    }
    
    /*
     给你一个按 非递减顺序 排序的整数数组 nums，返回 每个数字的平方 组成的新数组，要求也按 非递减顺序 排序。

      

     示例 1：

     输入：nums = [-4,-1,0,3,10]
     输出：[0,1,9,16,100]
     解释：平方后，数组变为 [16,1,0,9,100]
     排序后，数组变为 [0,1,9,16,100]
     示例 2：

     输入：nums = [-7,-3,2,3,11]
     输出：[4,9,9,49,121]

     来源：力扣（LeetCode）
     链接：https://leetcode.cn/problems/squares-of-a-sorted-array
     著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
     */
    func sortedSquares(_ nums: [Int]) -> [Int] {
        var results = Array(repeating: 0, count: nums.count)
        var index = nums.count - 1
        var left = 0, right = nums.count - 1
        while left <= right {
            let leftValue = nums[left] * nums[left]
            let rightValue = nums[right] * nums[right]
            if leftValue >= rightValue {
                results[index] = leftValue
                left += 1
            } else {
                results[index] = rightValue
                right -= 1
            }
            index -= 1
        }
        return results
    }
    
    /*
     给定一个含有 n 个正整数的数组和一个正整数 target 。

     找出该数组中满足其和 ≥ target 的长度最小的 连续子数组 [numsl, numsl+1, ..., numsr-1, numsr] ，并返回其长度。如果不存在符合条件的子数组，返回 0 。

      

     示例 1：

     输入：target = 7, nums = [2,3,1,2,4,3]
     输出：2
     解释：子数组 [4,3] 是该条件下的长度最小的子数组。
     示例 2：

     输入：target = 4, nums = [1,4,4]
     输出：1
     示例 3：

     输入：target = 11, nums = [1,1,1,1,1,1,1,1]
     输出：0

     来源：力扣（LeetCode）
     链接：https://leetcode.cn/problems/minimum-size-subarray-sum
     著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
     */
    
    func minSubArrayLen(_ target: Int, _ nums: [Int]) -> Int {
        // 双指针法，也是滑动窗口法，遍历下标作为滑动窗口的终止位置
        var left = 0
        var sum = 0
        var result = Int.max
        for right in 0 ..< nums.count {
            sum += nums[right]
            print("left:\(left) right:\(right) sum:\(sum)")
            // 向右移动左区间是个持续操作, 通过这个动作不断缩小滑动窗口
            while sum >= target {
                // 窗口左区间右移了，所以总和要减去移出窗口的那些值
                sum -= nums[left]
                let subArrayLength = right - left + 1
                if subArrayLength < result {
                    result = subArrayLength
                }
                // 更新下一个起始位置
                left += 1
            }
        }
        // 如果结果值还是大于数组个数，说明没有合法值
        if (result > nums.count) {
            result = 0
        }
        return result
    }
    
    /*
     给你一个正整数 n ，生成一个包含 1 到 n2 所有元素，且元素按顺时针顺序螺旋排列的 n x n 正方形矩阵 matrix 。

      

     示例 1：


     输入：n = 3
     输出：[[1,2,3],[8,9,4],[7,6,5]]
     示例 2：

     输入：n = 1
     输出：[[1]]
      

     来源：力扣（LeetCode）
     链接：https://leetcode.cn/problems/spiral-matrix-ii
     著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
     */
    func generateMatrix(_ n: Int) -> [[Int]] {
        var result = [[Int]](repeating: [Int](repeating: 0, count: n), count: n)
        // 设定起始变量
        var startRow = 0, startColumn = 0
        // 总圈数 = 矩阵边长 / 2
        var loopCount = n / 2
        // 矩阵中间的坐标
        let mid = loopCount
        // 当前填入螺旋矩阵的进度数字
        var count = 1
        // 因为是螺旋矩阵，每转一圈遍历的边长都会缩小1
        var offset = 1
        
        while loopCount > 0 {
            var phase1Column = startColumn
            var phase2Row = startRow
            while phase1Column < n - offset {
                result[phase2Row][phase1Column] = count
                count += 1
                phase1Column += 1
            }
            while phase2Row < n - offset {
                result[phase2Row][phase1Column] = count
                count += 1
                phase2Row += 1
            }
            while phase1Column > startColumn {
                result[phase2Row][phase1Column] = count
                count += 1
                phase1Column -= 1
            }
            while phase2Row > startRow {
                result[phase2Row][phase1Column] = count
                count += 1
                phase2Row -= 1
            }
            startRow += 1
            startColumn += 1
            offset += 1
            loopCount -= 1
        }
        // 如果n是奇数，中间会留下一个位置， 这里直接填入他的值
        if (n % 2) != 0 {
            result[mid][mid] = count
        }
        return result
    }
    
    /*
     169.给定一个大小为 n 的数组 nums ，返回其中的多数元素。多数元素是指在数组中出现次数 大于 ⌊ n/2 ⌋ 的元素。

     你可以假设数组是非空的，并且给定的数组总是存在多数元素。

      

     示例 1：

     输入：nums = [3,2,3]
     输出：3
     示例 2：

     输入：nums = [2,2,1,1,1,2,2]
     输出：2
     */
    
    func majorityElement(_ nums: [Int]) -> Int {
        // 先对数组排序
        let sortedNums = nums.sorted()
        var result = 0
        var longgest = 0
        var fast = 0
        var slow = 0
        while fast < sortedNums.count {
            let val = sortedNums[fast]
            let pre = sortedNums[slow]
            // 出现快指针元素和慢指针不同的时候, 说明重复元素的遍历结束了, 更新慢指针位置
            if val != pre {
                // 重复元素的长度
                let indexLength = fast - slow
                // 更新最长元素
                if longgest < indexLength {
                    result = sortedNums[fast - 1]
                    print("result = \(result)")
                    longgest = indexLength
                }
                slow = fast
            }
            fast += 1
        }
        // 遍历结束之后, 计算最后一个值是否可能为高频数
        let lastPath = sortedNums.count - slow
        if lastPath > longgest {
            result = sortedNums[slow]
        }
        print("result = \(result)")
        return result
    }
    
    func majorityElement2(_ nums: [Int]) -> Int {
        // 设置哈希表, key是数组元素, value是重复出现次数
        var dict = [Int: Int]()
        var result = 0
        for index in 0 ..< nums.count {
            let val = nums[index]
            // 如果已经记载在字典上
            if let repeatCount = dict[val] {
                let newRepeatCount = repeatCount + 1
                // 更新结果
                dict[val] = newRepeatCount
            } else {
                // 没有记载过, 新增一个
                dict[val] = 1
            }
            // 字典更新完毕, 检查当前result取出的值是否大于当前更新的值
            let currentRepeatCount = dict[val]
            // 如果旧值存在且大于新值, 不做处理, 否则用新值替换旧值
            guard let maxRepeatCount = dict[result], maxRepeatCount > currentRepeatCount ?? 0 else {
                result = val
                continue
            }
        }
        return result
    }
    
    /*
     274. H指数
     给你一个整数数组 citations ，其中 citations[i] 表示研究者的第 i 篇论文被引用的次数。计算并返回该研究者的 h 指数。

     根据维基百科上 h 指数的定义：h 代表“高引用次数” ，一名科研人员的 h 指数 是指他（她）至少发表了 h 篇论文，并且 至少 有 h 篇论文被引用次数大于等于 h 。如果 h 有多种可能的值，h 指数 是其中最大的那个。

      

     示例 1：

     输入：citations = [3,0,6,1,5]
     输出：3
     解释：给定数组表示研究者总共有 5 篇论文，每篇论文相应的被引用了 3, 0, 6, 1, 5 次。
          由于研究者有 3 篇论文每篇 至少 被引用了 3 次，其余两篇论文每篇被引用 不多于 3 次，所以她的 h 指数是 3。
     示例 2：

     输入：citations = [1,3,1]
     输出：1
     */
    
    func hIndex(_ citations: [Int]) -> Int {
        var left = 0
        var right = citations.count
        while left < right {
            let mid = (left + right + 1) >> 1
            var count = 0
            for index in 0 ..< citations.count {
                let val = citations[index]
                if val >= mid {
                    count += 1
                }
            }
            if count >= mid {
                // h指数在右区间
                left = mid
            } else {
                // h指数在左区间
                right = mid - 1
            }
        }
        return left
    }
    
    /*
     58. 最后一个单词长度
     给你一个字符串 s，由若干单词组成，单词前后用一些空格字符隔开。返回字符串中 最后一个 单词的长度。

     单词 是指仅由字母组成、不包含任何空格字符的最大
     子字符串
     。

      

     示例 1：

     输入：s = "Hello World"
     输出：5
     解释：最后一个单词是“World”，长度为 5。
     示例 2：

     输入：s = "   fly me   to   the moon  "
     输出：4
     解释：最后一个单词是“moon”，长度为 4。
     示例 3：

     输入：s = "luffy is still joyboy"
     输出：6
     解释：最后一个单词是长度为 6 的“joyboy”。
     */
    func lengthOfLastWord(_ s: String) -> Int {
        let charaArray = Array(s)
        var n = 0
        var startIndex = charaArray.count - 1
        while startIndex - n >= 0 {
            if charaArray[startIndex] == " " {
                startIndex -= 1
                continue
            }
            let chara = charaArray[startIndex - n]
            if chara == " " {
                break
            }
            n += 1
        }
        return n
    }
    
    /*
     35.搜索插入位置
     给定一个排序数组和一个目标值，在数组中找到目标值，并返回其索引。如果目标值不存在于数组中，返回它将会被按顺序插入的位置。

     请必须使用时间复杂度为 O(log n) 的算法。
     */
    func searchInsert(_ nums: [Int], _ target: Int) -> Int {
        var left = 0
        var right = nums.count - 1
        var result = -1
        while left <= right {
            let mid = ((right - left) >> 1) + left
            print("left = \(left) right = \(right) mid = \(mid)")
            let val = nums[mid]
            if target <= val {
                result = mid
                // 目标在左边
                right = mid - 1
            } else {
                // 目标在右边
                left = mid + 1
            }
        }
        if result == -1 {
            // 整个循环跑完都没有, 说明应该插入最右边
            result = nums.count
        }
        return result
    }
    
    /*
     661. 图片平滑器
     图像平滑器 是大小为 3 x 3 的过滤器，用于对图像的每个单元格平滑处理，平滑处理后单元格的值为该单元格的平均灰度。

     每个单元格的  平均灰度 定义为：该单元格自身及其周围的 8 个单元格的平均值，结果需向下取整。（即，需要计算蓝色平滑器中 9 个单元格的平均值）。

     如果一个单元格周围存在单元格缺失的情况，则计算平均灰度时不考虑缺失的单元格（即，需要计算红色平滑器中 4 个单元格的平均值）。
     给你一个表示图像灰度的 m x n 整数矩阵 img ，返回对图像的每个单元格平滑处理后的图像 。
     示例 1:
     输入:img = [[1,1,1],[1,0,1],[1,1,1]]
     输出:[[0, 0, 0],[0, 0, 0], [0, 0, 0]]
     解释:
     对于点 (0,0), (0,2), (2,0), (2,2): 平均(3/4) = 平均(0.75) = 0
     对于点 (0,1), (1,0), (1,2), (2,1): 平均(5/6) = 平均(0.83333333) = 0
     对于点 (1,1): 平均(8/9) = 平均(0.88888889) = 0
     示例 2:


     输入: img = [[100,200,100],[200,50,200],[100,200,100]]
     输出: [[137,141,137],[141,138,141],[137,141,137]]
     解释:
     对于点 (0,0), (0,2), (2,0), (2,2): floor((100+200+200+50)/4) = floor(137.5) = 137
     对于点 (0,1), (1,0), (1,2), (2,1): floor((200+200+50+200+100+100)/6) = floor(141.666667) = 141
     对于点 (1,1): floor((50+200+200+200+200+100+100+100+100)/9) = floor(138.888889) = 138
     */
    func imageSmoother(_ img: [[Int]]) -> [[Int]] {
        guard img.count > 0, let firstLine = img.first, firstLine.count > 0 else {
            return img
        }
        let line = img.count
        let column = firstLine.count
        if column == 1, line == 1 {
            return img
        }
        let lineCount = img.count
        let columnCount = firstLine.count
        var result = Array(repeating: Array(repeating: 0, count: columnCount), count: lineCount)
        for lineIndex in 0 ..< lineCount {
            for columnIndex in 0 ..< columnCount {
                // 需要被求平均值的数字
                let gridNum = img[lineIndex][columnIndex]
                var sum = gridNum
                var totalCount = 1
                // 求周围一圈数字和自己的平均数
                if lineIndex - 1 >= 0, columnIndex - 1 >= 0 {
                    let topLeft = img[lineIndex - 1][columnIndex - 1]
                    sum += topLeft
                    totalCount += 1
                }
                if lineIndex - 1 >= 0 {
                    let top = img[lineIndex - 1][columnIndex]
                    sum += top
                    totalCount += 1
                }
                if lineIndex - 1 >= 0, columnIndex + 1 < columnCount {
                    let topRight = img[lineIndex - 1][columnIndex + 1]
                    sum += topRight
                    totalCount += 1
                }
                if columnIndex - 1 >= 0 {
                    let left = img[lineIndex][columnIndex - 1]
                    sum += left
                    totalCount += 1
                }
                if columnIndex + 1 < columnCount {
                    let right = img[lineIndex][columnIndex + 1]
                    sum += right
                    totalCount += 1
                }
                if columnIndex - 1 >= 0, lineIndex + 1 < lineCount {
                    let bottomLeft = img[lineIndex + 1][columnIndex - 1]
                    sum += bottomLeft
                    totalCount += 1
                }
                if lineIndex + 1 < lineCount {
                    let bottom = img[lineIndex + 1][columnIndex]
                    sum += bottom
                    totalCount += 1
                }
                if columnIndex + 1 < columnCount, lineIndex + 1 < lineCount {
                    let bottomRight = img[lineIndex + 1][columnIndex + 1]
                    sum += bottomRight
                    totalCount += 1
                }
                let avg = sum / totalCount
                if columnIndex == 1, lineIndex == 1 {
                    print("center sunm = \(sum), count = \(totalCount), avg = \(avg)")
                }
                result[lineIndex][columnIndex] = avg
            }
        }
        return result
    }
    
    /*
     167. 两数之和 II - 输入有序数组
     给你一个下标从 1 开始的整数数组 numbers ，该数组已按 非递减顺序排列  ，请你从数组中找出满足相加之和等于目标数 target 的两个数。如果设这两个数分别是 numbers[index1] 和 numbers[index2] ，则 1 <= index1 < index2 <= numbers.length 。

     以长度为 2 的整数数组 [index1, index2] 的形式返回这两个整数的下标 index1 和 index2。

     你可以假设每个输入 只对应唯一的答案 ，而且你 不可以 重复使用相同的元素。

     你所设计的解决方案必须只使用常量级的额外空间。
     */
    func twoSum3(_ numbers: [Int], _ target: Int) -> [Int] {
        var left = 0
        var right = numbers.count - 1
        var result = [Int]()
        while left <= right {
            let leftNum = numbers[left]
            let rightNum = numbers[right]
            if target == leftNum + rightNum {
                result.append(leftNum + 1)
                result.append(rightNum + 1)
                break
            } else if rightNum + leftNum < target {
                // 比目标小, 所以要增大入参, 左指针向右移动
                left += 1
            } else {
                // 比目标大, 所以要减小入参, 又指针向左移动
                right -= 1
            }
        }
        return result
    }
    
    /*
     238. 除自身以外数组的乘积
     给你一个整数数组 nums，返回 数组 answer ，其中 answer[i] 等于 nums 中除 nums[i] 之外其余各元素的乘积 。

     题目数据 保证 数组 nums之中任意元素的全部前缀元素和后缀的乘积都在  32 位 整数范围内。

     请 不要使用除法，且在 O(n) 时间复杂度内完成此题。

      

     示例 1:

     输入: nums = [1,2,3,4]
     输出: [24,12,8,6]
     示例 2:

     输入: nums = [-1,1,0,-3,3]
     输出: [0,0,9,0,0]

     */
    func productExceptSelf(_ nums: [Int]) -> [Int] {
        guard nums.count > 1 else {
            return nums
        }
        /* 设计构造两个数组, 
         其中左数组的每个元素, 是入参数组下标元素左边的所有元素的乘积
         右数组的每个元素, 是入参数组下标元素右边的所有元素的乘积
         左数组第0个元素是1, 因为入参数组左边没有元素了
         右数组第n-1个元素是1, 因为入参数组右边没有元素了
         数组构造完毕后, 进行一次遍历, 结果数组的每个元素, 都是左数组和右数组对应下标元素的乘积
         */
        var leftArray = Array(repeating: 0, count: nums.count)
        leftArray[0] = 1
        var rightArray = Array(repeating: 0, count: nums.count)
        rightArray[nums.count - 1] = 1
        var result = [Int]()
        for index in 0 ..< nums.count {
            if index - 1 >= 0 {
                leftArray[index] = leftArray[index - 1] * nums[index - 1]
            }
            let tempIndex = nums.count - 1 - index
            if tempIndex + 1 < nums.count {
                rightArray[tempIndex] = rightArray[tempIndex + 1] * nums[tempIndex + 1]
            }
            print("left = \(leftArray) right = \(rightArray)")
        }
        
        for index in 0 ..< nums.count {
            let tempRet = leftArray[index] * rightArray[index]
            result.append(tempRet)
        }
        return result
    }
    
    /*
     
     11. 盛最多水的容器
     给定一个长度为 n 的整数数组 height 。有 n 条垂线，第 i 条线的两个端点是 (i, 0) 和 (i, height[i]) 。

     找出其中的两条线，使得它们与 x 轴共同构成的容器可以容纳最多的水。

     返回容器可以储存的最大水量。

     说明：你不能倾斜容器。

      

     示例 1：



     输入：[1,8,6,2,5,4,8,3,7]
     输出：49
     解释：图中垂直线代表输入数组 [1,8,6,2,5,4,8,3,7]。在此情况下，容器能够容纳水（表示为蓝色部分）的最大值为 49。
     示例 2：

     输入：height = [1,1]
     输出：1
      
     */
    func maxArea(_ height: [Int]) -> Int {
        guard height.count > 1 else {
            return 0
        }
        var left = 0
        var right = height.count - 1
        var result = 0
        while left < right {
            let val1 = height[left]
            let val2 = height[right]
            let volume = min(val1, val2) * (right - left)
            if volume > result {
                result = volume
            }
            if val1 > val2 {
                right -= 1
            } else {
                left += 1
            }
        }
        return result
    }
    
    /*
     228. 汇总区间
     给定一个  无重复元素 的 有序 整数数组 nums 。

     返回 恰好覆盖数组中所有数字 的 最小有序 区间范围列表 。也就是说，nums 的每个元素都恰好被某个区间范围所覆盖，并且不存在属于某个范围但不属于 nums 的数字 x 。

     列表中的每个区间范围 [a,b] 应该按如下格式输出：

     "a->b" ，如果 a != b
     "a" ，如果 a == b
      

     示例 1：

     输入：nums = [0,1,2,4,5,7]
     输出：["0->2","4->5","7"]
     解释：区间范围是：
     [0,2] --> "0->2"
     [4,5] --> "4->5"
     [7,7] --> "7"
     示例 2：

     输入：nums = [0,2,3,4,6,8,9]
     输出：["0","2->4","6","8->9"]
     解释：区间范围是：
     [0,0] --> "0"
     [2,4] --> "2->4"
     [6,6] --> "6"
     [8,9] --> "8->9"
     */
    
    func summaryRanges(_ nums: [Int]) -> [String] {
        guard nums.count > 0 else {
            return []
        }
        var startIndex = 0
        var endIndex = 0
        let arrowMark = "->"
        var results = [String]()
        while startIndex <= endIndex, endIndex < nums.count, startIndex < nums.count {
            let valStart = nums[startIndex]
            let valEnd = nums[endIndex]
            // 判断窗口能否滑动： 1. end+1 < nums.count 2. nums[end + 1] = valEnd + 1
            guard endIndex + 1 < nums.count, nums[endIndex + 1] == valEnd + 1 else {
                // 采集结果
                if startIndex == endIndex {
                    results.append(String(valStart))
                } else {
                    results.append([String(valStart), arrowMark, String(valEnd)].joined())
                }
                // 滑动左边界
                startIndex = endIndex + 1
                endIndex = startIndex
                continue
            }
            // 可以继续滑动
            endIndex += 1
        }
        return results
    }
}
ArraySolution().summaryRanges([0,2,3,4,6,8,9])
