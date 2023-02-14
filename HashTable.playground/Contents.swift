import Cocoa

var greeting = "Hello, playground"

extension Array where Element == Int {
    func quickSortArray() -> [Int] {
        var result = Array(self)
        quickSortInternal(input: &result, left: 0, right: self.count - 1)
        return result
    }
    
    func quickSortInternal(input: inout [Int], left: Int, right: Int) {
        guard right > left else {
            return
        }
        var tempLeft = left
        var tempRight = right
        let baseValue = input[left]
        while tempRight > tempLeft {
            while tempRight > tempLeft && input[tempRight] >= baseValue {
                tempRight -= 1
            }
            if tempRight > tempLeft {
                input[tempLeft] = input[tempRight]
            }
            while tempRight > tempLeft && input[tempLeft] < baseValue {
                tempLeft += 1
            }
            if tempRight > tempLeft {
                input[tempRight] = input[tempLeft]
            }
        }
        let divide = tempLeft
        quickSortInternal(input: &input, left: left, right: divide - 1)
        quickSortInternal(input: &input, left: divide + 1, right: right)
    }
}

class HashTableSolution {
    /* No. 242
     给定两个字符串 s 和 t ，编写一个函数来判断 t 是否是 s 的字母异位词。

     注意：若 s 和 t 中每个字符出现的次数都相同，则称 s 和 t 互为字母异位词。

      

     示例 1:

     输入: s = "anagram", t = "nagaram"
     输出: true
     示例 2:

     输入: s = "rat", t = "car"
     输出: false
      

     提示:

     1 <= s.length, t.length <= 5 * 104
     s 和 t 仅包含小写字母
     */
    func isAnagram(_ s: String, _ t: String) -> Bool {
        guard s.count == t.count else {
            return false
        }
        var result = true
        var alphabet: [Int] = Array(repeating: 0, count: 26)
        for (_, letter) in s.enumerated() {
            let index: Int = Int(letter.asciiValue! - Character("a").asciiValue!)
            let frequency = alphabet[index]
            alphabet[index] = frequency + 1
        }
        for (_, letter) in t.enumerated() {
            let index: Int = Int(letter.asciiValue! - Character("a").asciiValue!)
            let frequency = alphabet[index]
            alphabet[index] = frequency - 1
        }
        for (_, value) in alphabet.enumerated() {
            if value != 0 {
                result = false
                break
            }
        }
        return result
    }
    
    /* No.349
     给定两个数组 nums1 和 nums2 ，返回 它们的交集 。输出结果中的每个元素一定是 唯一 的。我们可以 不考虑输出结果的顺序 。

      

     示例 1：

     输入：nums1 = [1,2,2,1], nums2 = [2,2]
     输出：[2]
     示例 2：

     输入：nums1 = [4,9,5], nums2 = [9,4,9,8,4]
     输出：[9,4]
     解释：[4,9] 也是可通过的
      

     提示：

     1 <= nums1.length, nums2.length <= 1000
     0 <= nums1[i], nums2[i] <= 1000
     */
    func intersection(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
        var nums1Set = Set(nums1)
        var resultSet = Set<Int>()
        for number in nums2 {
            if nums1Set.contains(number) {
                resultSet.insert(number)
            }
        }
        return Array(resultSet)
    }
    
    /*
     给定一个整数数组 nums 和一个整数目标值 target，请你在该数组中找出 和为目标值 target  的那 两个 整数，并返回它们的数组下标。

     你可以假设每种输入只会对应一个答案。但是，数组中同一个元素在答案里不能重复出现。

     你可以按任意顺序返回答案。

      

     示例 1：

     输入：nums = [2,7,11,15], target = 9
     输出：[0,1]
     解释：因为 nums[0] + nums[1] == 9 ，返回 [0, 1] 。
     示例 2：

     输入：nums = [3,2,4], target = 6
     输出：[1,2]
     示例 3：

     输入：nums = [3,3], target = 6
     输出：[0,1]
      

     提示：

     2 <= nums.length <= 104
     -109 <= nums[i] <= 109
     -109 <= target <= 109
     只会存在一个有效答案
     */
    
    /// 用哈希表的算法去解题
    /// - Parameters:
    ///   - nums: 素材素组
    ///   - target: 目标数
    /// - Returns: 结果数组
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        // 创建哈希表
        var usedMap = [Int: Int]()
        var result = [Int]()
        for (index, number) in nums.enumerated() {
            let anotherNumber = target - number
            // 如果在哈希表中找到了能相加等于目标的值, 直接取它的下标出来组成结果返回
            if let anotherIndex = usedMap[anotherNumber] {
                result = [anotherIndex, index]
                break
            }
            // 如果在哈希表中查不到, 把遍历过的这个数存入哈希表
            usedMap[number] = index
        }
        return result
    }
    
    
    /// 用回溯算法去解题
    /// - Parameters:
    ///   - nums: 素材数组
    ///   - target: 目标数
    /// - Returns: 结果数组
    func twoSum2(_ nums: [Int], _ target: Int) -> [Int] {
        var result = [Int]()
        var path = [Int]()
        twoSumBackTracking(result: &result, path: &path, nums: nums, target: target, startIndex: 0)
        return result
    }
    
    func twoSumBackTracking(result: inout [Int], path: inout [Int], nums: [Int], target: Int, startIndex: Int) {
        guard path.count < 2 else {
            result = path
            return
        }
        for (index, value) in nums.enumerated() {
            guard index >= startIndex else {
                continue
            }
            var isAppended = true
            if let firstIndex = path.first {
                if nums[firstIndex] + value != target {
                    isAppended = false
                }
            }
            if isAppended {
                path.append(index)
                twoSumBackTracking(result: &result, path: &path, nums: nums, target: target, startIndex: index + 1)
                path.removeLast()
            }
        }
    }
    
    /* No.454
     给你四个整数数组 nums1、nums2、nums3 和 nums4 ，数组长度都是 n ，请你计算有多少个元组 (i, j, k, l) 能满足：

     0 <= i, j, k, l < n
     nums1[i] + nums2[j] + nums3[k] + nums4[l] == 0
      

     示例 1：

     输入：nums1 = [1,2], nums2 = [-2,-1], nums3 = [-1,2], nums4 = [0,2]
     输出：2
     解释：
     两个元组如下：
     1. (0, 0, 0, 1) -> nums1[0] + nums2[0] + nums3[0] + nums4[1] = 1 + (-2) + (-1) + 2 = 0
     2. (1, 1, 0, 0) -> nums1[1] + nums2[1] + nums3[0] + nums4[0] = 2 + (-1) + (-1) + 0 = 0
     示例 2：

     输入：nums1 = [0], nums2 = [0], nums3 = [0], nums4 = [0]
     输出：1
      

       提示：

     n == nums1.length
     n == nums2.length
     n == nums3.length
     n == nums4.length
     1 <= n <= 200
     -228 <= nums1[i], nums2[i], nums3[i], nums4[i] <= 228
     */
    
    func fourSumCount(_ nums1: [Int], _ nums2: [Int], _ nums3: [Int], _ nums4: [Int]) -> Int {
        // 首先保证四个数组长度一样, 不然题干不成立, 运行就crash
        guard nums1.count == nums2.count && nums3.count == nums4.count && nums1.count == nums3.count else {
            return 0
        }
        var result = 0;
        let length = nums1.count
        var resultMap = [Int: Int]()
        // 原理是先取前两个数组, 一个数组的每个元素和另一个数组的每个元素相加一次, 将结果放入结果集, 统计每种结果分别出现了几次
        for (_, value1) in nums1.enumerated() {
            for (_, value2) in nums2.enumerated() {
                let valuePair = value1 + value2
                let currentCount = resultMap[valuePair] ?? 0
                resultMap[valuePair] = currentCount + 1
            }
        }
        // 然后取后两个数组做同样的操作, 当产生一个和的时候能在结果集里找到绝对值相同的, 就说明找到了一个符合要求的元祖, 统计数增加 '结果集里结果的出现次数'
        for (_, value3) in nums3.enumerated() {
            for (_, value4) in nums4.enumerated() {
                let valuePair = value3 + value4
                if let matchedPair = resultMap[(0 - valuePair)] {
                    result += matchedPair
                }
            }
        }
        return result
    }
    
    /* No.15 三数之和
     给你一个整数数组 nums ，判断是否存在三元组 [nums[i], nums[j], nums[k]] 满足 i != j、i != k 且 j != k ，同时还满足 nums[i] + nums[j] + nums[k] == 0 。请

     你返回所有和为 0 且不重复的三元组。

     注意：答案中不可以包含重复的三元组。

      

      

     示例 1：

     输入：nums = [-1,0,1,2,-1,-4]
     输出：[[-1,-1,2],[-1,0,1]]
     解释：
     nums[0] + nums[1] + nums[2] = (-1) + 0 + 1 = 0 。
     nums[1] + nums[2] + nums[4] = 0 + 1 + (-1) = 0 。
     nums[0] + nums[3] + nums[4] = (-1) + 2 + (-1) = 0 。
     不同的三元组是 [-1,0,1] 和 [-1,-1,2] 。
     注意，输出的顺序和三元组的顺序并不重要。
     示例 2：

     输入：nums = [0,1,1]
     输出：[]
     解释：唯一可能的三元组和不为 0 。
     示例 3：

     输入：nums = [0,0,0]
     输出：[[0,0,0]]
     解释：唯一可能的三元组和为 0 。
      

     提示：

     3 <= nums.length <= 3000
     -105 <= nums[i] <= 105
     
    */
    func threeSum(_ nums: [Int]) -> [[Int]] {
        var result = [[Int]]()
        // 当数组允许重复元素的时候, 一定要先排序, 否则无法去重
        let sortedNums = nums.sorted()
        for baseIndex in 0 ..< sortedNums.count {
            // 剪枝操作, 如果排序后的入参值大于0, 那后面更大的值怎么加都是大于0了, 不满足题干, 返回结果即可,
            guard sortedNums[baseIndex] <= 0 else {
                return result
            }
            // 去重操作, 如果当前遍历下标的值和上一个相同, 那么这个下标需要的组合已经在上一个迭代遍历过了, 直接continue
            if baseIndex > 0 && sortedNums[baseIndex - 1] == sortedNums[baseIndex] {
                continue
            }
            // 这里用三指针法, 左游标是Index + 1, 右游标是数组末位
            var left = baseIndex + 1
            var right = sortedNums.count - 1
            while left < right  {
                let sum = sortedNums[baseIndex] + sortedNums[left] + sortedNums[right]
                // 非零结果根据需要移动游标
                if sum > 0 {
                    right -= 1
                } else if sum < 0 {
                    left += 1
                } else {
                    // 得到结果加入结果集, 同时由于当前游标已经记录过结果了, 因此分别向中间移动一格
                    result.append([sortedNums[left], sortedNums[right], sortedNums[baseIndex]])
                    // 剪枝操作, 相同值的计算结果相同了, 直接跳过
                    while right > left && sortedNums[left + 1] == sortedNums[left] {
                        left += 1
                    }
                    // 剪枝操作, 相同值的计算结果相同了, 直接跳过
                    while right > left && sortedNums[right] == sortedNums[right - 1] {
                        right -= 1
                    }
                    left += 1
                    right -= 1
                }
            }
        }
        return result
    }
    
    /* No.18
     给你一个由 n 个整数组成的数组 nums ，和一个目标值 target 。请你找出并返回满足下述全部条件且不重复的四元组 [nums[a], nums[b], nums[c], nums[d]] （若两个四元组元素一一对应，则认为两个四元组重复）：

     0 <= a, b, c, d < n
     a、b、c 和 d 互不相同
     nums[a] + nums[b] + nums[c] + nums[d] == target
     你可以按 任意顺序 返回答案 。

      

     示例 1：

     输入：nums = [1,0,-1,0,-2,2], target = 0
     输出：[[-2,-1,1,2],[-2,0,0,2],[-1,0,0,1]]
     示例 2：

     输入：nums = [2,2,2,2,2], target = 8
     输出：[[2,2,2,2]]
      

     提示：

     1 <= nums.length <= 200
     -109 <= nums[i] <= 109
     -109 <= target <= 109
     */
    
    func fourSum(_ nums: [Int], _ target: Int) -> [[Int]] {
        var result = [[Int]]()
        let sortedNums = nums.sorted()
        for k in 0 ..< sortedNums.count {
            // 考虑到target和数组内有可能有负数, 这里必须判断下是大于零才可以剪枝
            if sortedNums[k] > 0 && target > 0 && sortedNums[k] > target {
                break
            }
            // 相同的去重原理
            if k > 0 && sortedNums[k - 1] == sortedNums[k] {
                continue
            }
            // 到这里和上题的三数之和一样了
            for i in k + 1 ..< sortedNums.count {
                // 二级剪枝, 原理和上面一样
                let valuesSum = sortedNums[i] + sortedNums[k]
                if valuesSum > 0 && target > 0 && valuesSum > target {
                    break
                }
                if i > k + 1 && sortedNums[i] == sortedNums[i - 1] {
                    continue
                }
                var left = i + 1
                var right = sortedNums.count - 1
                while right > left {
                    if valuesSum + sortedNums[left] + sortedNums[right] > target {
                        right -= 1
                    } else if valuesSum + sortedNums[left] + sortedNums[right] < target {
                        left += 1
                    } else {
                        result.append([sortedNums[k], sortedNums[i], sortedNums[left], sortedNums[right]])
                        while right > left && sortedNums[left] == sortedNums[left + 1] {
                            left += 1
                        }
                        while right > left && sortedNums[right] == sortedNums[right - 1] {
                            right -= 1
                        }
                        left += 1
                        right -= 1
                    }
                }
            }
        }
        return result
    }
    
    /*
     给定一个已按照 升序排列  的整数数组 numbers ，请你从数组中找出两个数满足相加之和等于目标数 target 。

     函数应该以长度为 2 的整数数组的形式返回这两个数的下标值。numbers 的下标 从 0 开始计数 ，所以答案数组应当满足 0 <= answer[0] < answer[1] < numbers.length 。

     假设数组中存在且只存在一对符合条件的数字，同时一个数字不能使用两次。

      

     示例 1：

     输入：numbers = [1,2,4,6,10], target = 8
     输出：[1,3]
     解释：2 与 6 之和等于目标数 8 。因此 index1 = 1, index2 = 3 。
     示例 2：

     输入：numbers = [2,3,4], target = 6
     输出：[0,2]
     示例 3：

     输入：numbers = [-1,0], target = -1
     输出：[0,1]
     
     */
    func twoSumReview(_ numbers: [Int], _ target: Int) -> [Int] {
        var results = [Int]() // 结果数组
        var usedNums = [Int: Int]() // 构造一个数组值为Key, index为Value的Map
        for (index, value) in numbers.enumerated() {
            let subTarget = target - value
            if let storedIndex = usedNums[subTarget] {
                results = [storedIndex, index]
                break
            }
            usedNums[value] = index
        }
        return results
    }
}

HashTableSolution().fourSum([-2,-1,-1,1,1,2,2], 0)
