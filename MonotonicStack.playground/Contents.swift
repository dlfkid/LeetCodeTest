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
    /*
     https://leetcode.cn/problems/trapping-rain-water/
     给定 n 个非负整数表示每个宽度为 1 的柱子的高度图，计算按此排列的柱子，下雨之后能接多少雨水。

      

     示例 1：



     输入：height = [0,1,0,2,1,0,1,3,2,1,2,1]
     输出：6
     解释：上面是由数组 [0,1,0,2,1,0,1,3,2,1,2,1] 表示的高度图，在这种情况下，可以接 6 个单位的雨水（蓝色部分表示雨水）。
     示例 2：

     输入：height = [4,2,0,3,2,5]
     输出：9
     */
    func trap(_ height: [Int]) -> Int {
        var finalResult = 0
        // 小于3个柱子根本不能接雨水
        guard height.count > 2 else {
            return finalResult
        }
        // 单调栈
        var monotonicStack = [Int]()
        // 入栈第一个元素, 存放遍历过的下标
        monotonicStack.append(0)
        for index in 1 ..< height.count {
            let currentValue = height[index]
            guard let stackTop = monotonicStack.last else {
                continue
            }
            // 小于和等于栈顶的值都符合单调递增栈, 可以直接入栈
            if currentValue < height[stackTop] {
                monotonicStack.append(index)
            } else if (currentValue == height[stackTop]) {
                monotonicStack.popLast()
                monotonicStack.append(index)
            } else {
                // 第一个大于边界的值出现, 弹出栈口值
                while let last = monotonicStack.last, currentValue > height[last], !monotonicStack.isEmpty {
                    let right = index
                    if let middle = monotonicStack.popLast() {
                        if let left = monotonicStack.popLast() {
                            let barrierValue = min(height[left], height[right])
                            let spaceHeight = barrierValue - height[middle]
                            let spaceWidth = right - left - 1
                            let tempResult = spaceHeight * spaceWidth
                            print(tempResult)
                            finalResult += tempResult
                            // 因为我们只是取栈顶后一个的下标而不是要它出栈, 这里要加回来
                            monotonicStack.append(left)
                        }
                    }
                }
                // 其余更小的都出栈完毕了, 这个下标可以入栈了
                monotonicStack.append(index)
            }
        }
        return finalResult
    }
    
    /*
     https://leetcode.cn/problems/largest-rectangle-in-histogram/description/
     给定 n 个非负整数，用来表示柱状图中各个柱子的高度。每个柱子彼此相邻，且宽度为 1 。

     求在该柱状图中，能够勾勒出来的矩形的最大面积。

      

     示例 1:



     输入：heights = [2,1,5,6,2,3]
     输出：10
     解释：最大的矩形为图中红色区域，面积为 10
     示例 2：



     输入： heights = [2,4]
     输出： 4
     */
    func largestRectangleArea(_ heights: [Int]) -> Int {
        var result = 0
        // 面积是底乘高, 数组为空直接返回0
        guard heights.count > 0 else {
            return 0
        }
        // 面积是底乘高, 数组数量为1, 那就是1 * 这个柱子的高度
        guard heights.count > 1 else {
            return heights.first!
        }
        // 因为边界的柱子也能形成矩形, 但用单调栈会因为缺少更小的元素导致无法形成边界, 这里手动给头尾加0来实现
        var sampleHeight = heights
        sampleHeight.insert(0, at: 0)
        sampleHeight.append(0)
        // 创建单调栈
        var monotonicStack = [Int]()
        // 入参第一个下标
        monotonicStack.append(0)
        for index in 1 ..< sampleHeight.count {
            let cuerrentHeight = sampleHeight[index]
            // 关键是要创建单调递增栈还是递减栈, 因为求的是柱子内部形成的最大矩形, 因此当前柱子遇到比它矮的柱子的时候就无法扩展了, 所以我们要找到左右边界, 要创建一个单调递减栈
            guard let lastHeightIndex = monotonicStack.last else {
                continue
            }
            let lastHeight = sampleHeight[lastHeightIndex]
            // 遇到大于栈顶值的柱子可以直接入栈
            if cuerrentHeight > lastHeight {
                monotonicStack.append(index)
            } else if cuerrentHeight == lastHeight {
            // 遇到等于的情况, 先弹出栈顶值再入栈, 减少重复计算
                monotonicStack.popLast()
                monotonicStack.append(index)
                continue
            } else {
                // 处理当前值小于栈顶值的情况, 采集结果
                while !monotonicStack.isEmpty, let stackTop = monotonicStack.last, cuerrentHeight < sampleHeight[stackTop] {
                    // 当前遍历的右边界
                    let right = index
                    // 栈顶是中间值, 也就是最大值
                    if let middle = monotonicStack.popLast() {
                        // 下一个栈顶是左边界
                        if let left = monotonicStack.last {
                            // 左右相减计算出矩形的底边长
                            let bottomLength = right - left - 1
                            // 矩形的高度, 两个比他矮的边界柱子中最矮的那个
                            let heigthLength = sampleHeight[middle]
                            // 计算出当前体积
                            let tempResult = bottomLength * heigthLength
                            // 临时结果相比较取大值
                            result = max(result, tempResult)
                        }
                    }
                }
                // 入栈
                monotonicStack.append(index)
            }
        }
        return result
    }
}

let nums = [2,4]

let solution = Solution()

let anwser = solution.largestRectangleArea(nums)
