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
}

ArraySolution().generateMatrix(5)
