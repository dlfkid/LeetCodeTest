import Cocoa

var greeting = "Hello, playground"

class Solution {
    
    /*
     739.每日温度 https://leetcode.cn/problems/daily-temperatures/description/
     给定一个整数数组 temperatures ，表示每天的温度，返回一个数组 answer ，其中 answer[i] 是指对于第 i 天，下一个更高温度出现在几天后。如果气温在这之后都不会升高，请在该位置用 0 来代替。*/
    
    static func dailyTemperatures(_ temperatures: [Int]) -> [Int] {
        // 结果数组
        var result = Array(repeating: 0, count: temperatures.count)
        // 单调栈
        var monotonicStack = [Int]()
        // 入栈第一个元素
        monotonicStack.append(0)
        // 遍历数组
        for index in 1 ..< temperatures.count {
            // 栈顶下标元素和当前元素比较, 如果当前元素小于等于栈顶下标元素, 将该元素的下标入栈
            let current = temperatures[index]
            if let stackTop = monotonicStack.last, temperatures[stackTop] > current {
                monotonicStack.append(index)
                continue
            }
            // 如果当前元素大于栈顶下标的元素, 对栈做循环出栈操作, 直到栈为空或当前栈顶下标元素大于当前元素
            while let topStack = monotonicStack.last, !monotonicStack.isEmpty, temperatures[topStack] < current {
                print("栈顶元素 = \(temperatures[topStack]), 当前元素 = \(current)")
                let length = index - topStack
                result[topStack] = length
                monotonicStack.popLast()
            }
            // 将当前天数入栈
            monotonicStack.append(index)
            print("当前栈 = \(monotonicStack)")
        }
        return result
    }
    
    /*
     
     https://leetcode.cn/problems/next-greater-element-i/description/
     给你两个 没有重复元素 的数组 nums1 和 nums2 ，下标从 0 开始计数，其中nums1 是 nums2 的子集。

     对于每个 0 <= i < nums1.length ，找出满足 nums1[i] == nums2[j] 的下标 j ，并且在 nums2 确定 nums2[j] 的 下一个更大元素 。如果不存在下一个更大元素，那么本次查询的答案是 -1 。

     返回一个长度为 nums1.length 的数组 ans 作为答案，满足 ans[i] 是如上所述的 下一个更大元素 。

      

     示例 1：

     输入：nums1 = [4,1,2], nums2 = [1,3,4,2].
     输出：[-1,3,-1]
     解释：nums1 中每个值的下一个更大元素如下所述：
     - 4 ，用加粗斜体标识，nums2 = [1,3,4,2]。不存在下一个更大元素，所以答案是 -1 。
     - 1 ，用加粗斜体标识，nums2 = [1,3,4,2]。下一个更大元素是 3 。
     - 2 ，用加粗斜体标识，nums2 = [1,3,4,2]。不存在下一个更大元素，所以答案是 -1 。
     示例 2：

     输入：nums1 = [2,4], nums2 = [1,2,3,4].
     输出：[3,-1]
     解释：nums1 中每个值的下一个更大元素如下所述：
     - 2 ，用加粗斜体标识，nums2 = [1,2,3,4]。下一个更大元素是 3 。
     - 4 ，用加粗斜体标识，nums2 = [1,2,3,4]。不存在下一个更大元素，所以答案是 -1 。
     */
    func nextGreaterElement(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
        // 结果数组, 根据题意, 默认值为-1
        var result = Array(repeating: -1, count: nums1.count)
        // 单调栈
        var monotonicStack = [Int]()
        // 如果Nums1的长度为0, 不用计算直接返回
        guard nums1.count > 0 else {
            return result
        }
        // 创建一个映射表, key是nums2的元素值, value是它在nums1中的下标位置
        var mapping = [Int: Int]()
        for index in 0 ..< nums1.count {
            let key = nums1[index]
            mapping[key] = index
        }
        // 入栈nums2的第一个下标
        monotonicStack.append(0)
        for index in 1 ..< nums2.count {
            // 由于是递增单调栈, 如果栈顶元素大于等于当前元素, 直接将下标入栈
            let currentValue = nums2[index]
            guard let stackTop = monotonicStack.last, nums2[stackTop] < currentValue else {
                monotonicStack.append(index)
                continue
            }
            // 如果当前元素大于栈顶下标的元素, 对栈做循环出栈操作, 直到栈为空或当前栈顶下标元素大于当前元素
            while let topStack = monotonicStack.last, !monotonicStack.isEmpty, nums2[topStack] < currentValue {
                // 此时当前遍历元素大于栈顶元素, 符合第一个比数组1要大的值的要求, 因此可以采集结果
                // 获取栈顶的元素
                let topStackValue = nums2[topStack]
                // 获取栈顶元素是否在nums1中出现, 如果有则会有下标
                if let location = mapping[topStackValue] {
                    // 采集结果, 当前元素比栈顶元素大
                    result[location] = currentValue
                }
                // 弹出元素
                monotonicStack.popLast()
            }
            // 将当前元素的下标入栈
            monotonicStack.append(index)
        }
        return result
    }
    
    /*
     https://leetcode.cn/problems/next-greater-element-ii/description/
     给定一个循环数组 nums （ nums[nums.length - 1] 的下一个元素是 nums[0] ），返回 nums 中每个元素的 下一个更大元素 。

     数字 x 的 下一个更大的元素 是按数组遍历顺序，这个数字之后的第一个比它更大的数，这意味着你应该循环地搜索它的下一个更大的数。如果不存在，则输出 -1 。

      

     示例 1:

     输入: nums = [1,2,1]
     输出: [2,-1,2]
     解释: 第一个 1 的下一个更大的数是 2；
     数字 2 找不到下一个更大的数；
     第二个 1 的下一个最大的数需要循环搜索，结果也是 2。
     示例 2:

     输入: nums = [1,2,3,4,3]
     输出: [2,3,4,-1,4]
     */
    func nextGreaterElements(_ nums: [Int]) -> [Int] {
        // 结果数组, 根据题意, 默认值为-1
        var result = Array(repeating: -1, count: nums.count)
        // 如果Nums的长度为0, 不用计算直接返回
        guard nums.count > 0 else {
            return result
        }
        // 单调栈
        var monotonicStack = [Int]()
        // 入栈nums的第一个值
        monotonicStack.append(0)
        // 确定总循环次数
        let iterationTimes = nums.count * 2
        for rawIndex in 1 ..< iterationTimes {
            // 因为数组是成环的, 相当于一个数组要遍历两遍, 为了节省空间复杂度, 我们只需要对i取模, 就可以遍历两遍而不越界
            let actualIndex = rawIndex % nums.count
            let currentValue = nums[actualIndex]
            guard let stackTop = monotonicStack.last, currentValue > nums[stackTop] else {
                monotonicStack.append(actualIndex)
                continue
            }
            // 如果当前元素大于栈顶下标的元素, 对栈做循环出栈操作, 直到栈为空或当前栈顶下标元素大于当前元素
            while let topStackValue = monotonicStack.last, !monotonicStack.isEmpty, nums[topStackValue] < currentValue {
                // 采集结果, 当前元素比栈顶元素大
                result[topStackValue] = currentValue
                // 弹出元素
                monotonicStack.popLast()
            }
            // 将当前值入栈
            monotonicStack.append(actualIndex)
        }
        return result
    }
}

let nums = [1,2,1]

let solution = Solution()

let anwser = solution.nextGreaterElements(nums)
