import UIKit
import Combine

class SortStyles {
    // 冒泡排序, 时间复杂度O(n²)， 空间复杂度O(1)
    func bubbleSort(nums: inout [Int]) {
        for _ in 0 ..< nums.count {
            for j in 0 ..< nums.count - 1 {
                if nums[j] > nums[j + 1] {
                    nums.swapAt(j, j + 1)
                }
            }
        }
    }
    
    // 选择排序,每次在范围内选出最大或最小值， 逐一排到数组末尾, 时间复杂度O(n²)， 空间复杂度O(1)
    func selectSort(nums: inout [Int]) {
        guard nums.count > 0 else {
            return
        }
        for sorted in 0 ..< nums.count {
            var max = nums[0]
            var maxIndex = 0
            for index in 0 ..< nums.count - sorted {
                if nums[index] > max {
                    max = nums[index]
                    maxIndex = index
                }
            }
            let sortIndex = nums.count - 1 - sorted
            let tempValue = nums[sortIndex]
            nums[sortIndex] = max
            nums[maxIndex] = tempValue
        }
    }
    
    // 快速排序, 时间复杂度最坏O(n²), 最好O(Logn)
    func quickSort(_ nums: inout [Int], _ left: Int, _ right: Int) {
        guard left >= 0 && right < nums.count && left < right else {
            return
        }
        var tempLeft = left
        var tempRight = right
        let baseValue = nums[tempLeft]
        while tempRight > tempLeft {
            while tempRight > tempLeft && nums[tempRight] >= baseValue {
                tempRight -= 1
            }
            if tempRight > tempLeft {
                nums[tempLeft] = nums[tempRight]
            }
            while tempRight > tempLeft && nums[tempLeft] < baseValue {
                tempLeft += 1
            }
            if tempRight > tempLeft {
                nums[tempRight] = nums[tempLeft]
            }
        }
        let baseIndex = tempLeft
        nums[baseIndex] = baseValue
        quickSort(&nums, left, baseIndex - 1)
        quickSort(&nums, baseIndex + 1, right)
    }
    
    // 堆排序时间复杂度O(nLogn), 空间复杂度O(1)
    func heapSort(_ nums: inout [Int]) {
        // 建堆, 从最后一个叶子节点的父节点开始遍历, 父节点公式: n = (i - 1) / 2
        let lastIndex = nums.count - 1
        var index = (lastIndex - 1) / 2
        while index >= 0 {
            adjustHeap(&nums, index, nums.count)
            index -= 1
        }
        // 排序, 把最后一个节点和堆顶交换, 然后重新从堆顶维护剩余堆
        var sortIndex = lastIndex
        while sortIndex >= 0 {
            nums.swapAt(0, sortIndex)
            // 重新维护, 每次都把堆顶放到数组后部, 然后维护堆的时候将其排除在堆长度之外, 就实现了在一个数组内排序
            adjustHeap(&nums, 0, sortIndex)
            sortIndex -= 1
        }
    }
    
    /// 调堆函数
    /// - Parameters:
    ///   - nums: 如参数组
    ///   - i: 调堆开始的父节点
    ///   - length: 调堆范围
    func adjustHeap(_ nums: inout [Int], _ i: Int, _ length: Int) {
        var fatherIndex = i // 父节点
        var leftSon = fatherIndex * 2 + 1 // 左子节点公式
        var rightSon = fatherIndex * 2 + 2 // 右子节点公式
        // 分别检查父节点的左右子节点是否大于父节点值, 如果大了那就无法满足大顶堆, 需要调整父子节点的下标位置
        if leftSon < length && nums[fatherIndex] < nums[leftSon] {
            fatherIndex = leftSon
        }
        if rightSon < length && nums[fatherIndex] < nums[rightSon] {
            fatherIndex = rightSon
        }
        // 父节点如果已经和入参不同了, 说明堆需要维护
        if fatherIndex != i {
            // 交换两个下标的值
            nums.swapAt(fatherIndex, i)
            // 维护后递归检查新的节点值, 继续维护
            adjustHeap(&nums, fatherIndex, length)
        }
    }
    
    /// 插入排序， 时间复杂度最好O(n), 最坏O(n²)
    /// - Parameter nums: 入参数组
    func insertSort(_ nums: inout [Int]) {
        var preIndex = 0
        // 对数组进行遍历
        for index in 0 ..< nums.count {
            preIndex = index - 1
            // 每遍历到一个新的位置，都循环检后退查前面的一个值是不是比当前数大，如果是, 就把前一个数赋值给后一个位置
            while preIndex >= 0 && nums[preIndex] > nums[index] {
                nums[preIndex + 1] = nums[preIndex]
                preIndex -= 1
            }
            // 最后把当前数赋值给指针后退到的位置
            nums[preIndex + 1] = nums[index]
        }
    }
    
    /// 另一种快排, 时间复杂度最好O(nLogn), 最差O(n²), 空间复杂度O(1), 不稳定
    /// - Parameter nums: 被排数组
    func customQuickSort(_ nums: inout [Int]) {
        // 决定快排分界线
        var minimalIndex = 0
        var maximalIndex = nums.count - 1
        // 走进子函数进行排序
        quickSortDivide(nums: &nums, high: maximalIndex, low: minimalIndex)
    }
    
    /// 快速排序子函数
    /// - Parameters:
    ///   - nums: 数组
    ///   - high: 右游标, 负责取大于基准值的数
    ///   - low: 左游标, 负责取小于基准数的值
    func quickSortDivide(nums: inout [Int], high: Int, low: Int) {
        guard high > low else {
            return
        }
        let baseVal = nums[low]
        var left = low
        var right = high
        while right > left {
            while right > left && nums[right] >= baseVal {
                right -= 1
            }
            if right > left {
                nums[left] = nums[right]
            }
            while right > left && nums[left] < baseVal {
                left += 1
            }
            if right > left {
                nums[right] = nums[left]
            }
        }
        let baseIndex = left
        nums[baseIndex] = baseVal
        quickSortDivide(nums: &nums, high: high, low: baseIndex + 1)
        quickSortDivide(nums: &nums, high: baseIndex - 1, low: low)
    }
    
    /*
     给你一个字符串数组 names ，和一个由 互不相同 的正整数组成的数组 heights 。两个数组的长度均为 n 。

     对于每个下标 i，names[i] 和 heights[i] 表示第 i 个人的名字和身高。

     请按身高 降序 顺序返回对应的名字数组 names 。

      

     示例 1：

     输入：names = ["Mary","John","Emma"], heights = [180,165,170]
     输出：["Mary","Emma","John"]
     解释：Mary 最高，接着是 Emma 和 John 。
     示例 2：

     输入：names = ["Alice","Bob","Bob"], heights = [155,185,150]
     输出：["Bob","Alice","Bob"]
     解释：第一个 Bob 最高，然后是 Alice 和第二个 Bob 。
      

     提示：

     n == names.length == heights.length
     1 <= n <= 103
     1 <= names[i].length <= 20
     1 <= heights[i] <= 105
     names[i] 由大小写英文字母组成
     heights 中的所有值互不相同

     */
    
    func sortPeople(_ names: [String], _ heights: [Int]) -> [String] {
        if names.count != heights.count {
            return []
        }
        var nameResult = names
        var heightResult = heights
        // 由于快速排序的思想是不断交换数组中不同元素的位置, 因此我们可以在交换身高数组的同时也按相同的规则交换姓名数组, 输出我们要的结果
        quickSortPeople(names: &nameResult, heights: &heightResult, high: heights.count - 1, low: 0)
        return nameResult.reversed()
    }
    
    func quickSortPeople(names: inout [String], heights: inout [Int],  high: Int, low: Int) {
        guard high > low else {
            return
        }
        let baseHeight = heights[low]
        let baseName = names[low]
        var tempHigh = high
        var tempLow = low
        while tempHigh > tempLow {
            while tempHigh > tempLow && heights[tempHigh] >= baseHeight {
                tempHigh -= 1
            }
            if tempHigh > tempLow {
                heights[tempLow] = heights[tempHigh]
                names[tempLow] = names[tempHigh]
            }
            while tempHigh > tempLow && heights[tempLow] < baseHeight {
                tempLow += 1
            }
            if tempHigh > tempLow {
                heights[tempHigh] = heights[tempLow]
                names[tempHigh] = names[tempLow]
            }
        }
        heights[tempLow] = baseHeight
        names[tempLow] = baseName
        quickSortPeople(names: &names, heights: &heights, high: high, low: tempLow + 1)
        quickSortPeople(names: &names, heights: &heights, high: tempLow - 1, low: low)
    }
    
    // 复习堆排序
    
    func heapify(nums: inout [Int], index: Int, length: Int) {
        // 以入参为默认父节点
        var father = index
        // 根据公式计算出左右子节点
        var lson = index * 2 + 1
        var rson = index * 2 + 2
        // 如果lson存在且大于父节点, 交换父节点位置
        if lson < length && nums[lson] > nums[father] {
            father = lson
        }
        // 如果rson存在且大于父节点, 再次交换父节点位置
        if rson < length && nums[rson] > nums[father] {
            father = rson
        }
        // 如果父节点和一开始不同, 则需要数组调整堆顶值, 并递归重新调整整个堆
        if father != index {
            nums.swapAt(father, index)
            heapify(nums: &nums, index: father, length: length)
        }
    }
    
    /// 堆排序, 时间复杂度O(nLogn), 空间复杂度O(1), 不稳定
    /// - Parameter nums: 被排序数组
    func heapSortReview(nums: inout [Int]) {
        // 建堆, 从最后一个叶子结点的父节点开始建堆
        let lastIndex = nums.count - 1
        // 父节点公式 n = (i - 1) / 2
        var heapIndex = (lastIndex - 1) / 2
        while heapIndex >= 0 {
            // 逐个传入调堆函数调堆
            heapify(nums: &nums, index: heapIndex, length: nums.count)
            heapIndex -= 1
        }
        // 开始排序, 方式是逐个把堆顶的元素放到数组尾部
        var sortIndex = lastIndex
        while sortIndex >= 0 {
            nums.swapAt(0, sortIndex)
            // 重新从堆顶调堆, 调堆的时候把调整过的元素排除在外
            heapify(nums: &nums, index: 0, length: sortIndex)
            sortIndex -= 1
        }
    }
    
    // 洗牌算法
    func shuffleSort(_ nums: inout [Int]) {
        for (index, _) in nums.enumerated() {
            let randomIndex = Int.random(in: index ..< nums.count)
            nums.swapAt(index, randomIndex)
        }
    }
}

var sortedNums = [9, 9, 8, 9, 5, 7, 3, 1, 5, 6, 3, 8, 8, 9, 7, 6, 7, 9, 5, 1, 3, 3, 4]

var shuffleNums = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]

SortStyles().insertSort(&sortedNums)
