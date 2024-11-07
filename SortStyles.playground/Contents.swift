import UIKit
import Combine

class SortStyles {
    // 冒泡排序, 时间复杂度O(n²)， 空间复杂度O(1)， 稳定算法
    func bubbleSort(nums: inout [Int]) {
        for _ in 0 ..< nums.count {
            for j in 0 ..< nums.count - 1 {
                if nums[j] > nums[j + 1] {
                    nums.swapAt(j, j + 1)
                }
            }
        }
    }
    
    // 选择排序,每次在范围内选出最大或最小值， 逐一排到数组末尾, 时间复杂度O(n²)， 空间复杂度O(1)， 非稳定算法
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
    
    // 快速排序, 时间复杂度最坏O(n²), 最好O(Logn)， 非稳定算法
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
    
    // 堆排序时间复杂度O(nLogn), 空间复杂度O(1)，非稳定算法
    func heapify(_ nums: inout [Int], _ root: Int, _ range: Int) {
        let leftSon = root * 2 + 1
        let rightSon = root * 2 + 2
        var tempRoot = root
        if leftSon < range && nums[leftSon] < nums[tempRoot] {
            tempRoot = leftSon
        }
        if rightSon < range && nums[rightSon] < nums[tempRoot] {
            tempRoot = rightSon
        }
        if tempRoot != root {
            nums.swapAt(tempRoot, root)
            heapify(&nums, tempRoot, range)
        }
    }
    
    // 小顶堆构建
    private func minHeapify(_ heap: inout [Int], _ n: Int, _ i: Int) {
        var smallest = i
        let left = 2 * i + 1
        let right = 2 * i + 2
        
        if left < n && heap[left] < heap[smallest] {
            smallest = left
        }
        
        if right < n && heap[right] < heap[smallest] {
            smallest = right
        }
        
        if smallest != i {
            heap.swapAt(i, smallest)
            minHeapify(&heap, n, smallest)
        }
    }
    
    // 大顶堆构建
    private func maxHeapify(_ heap: inout [Int], _ n: Int, _ i: Int) {
        var largest = i
        let left = 2 * i + 1
        let right = 2 * i + 2
        
        if left < n && heap[left] > heap[largest] {
            largest = left
        }
        
        if right < n && heap[right] > heap[largest] {
            largest = right
        }
        
        if largest != i {
            heap.swapAt(i, largest)
            maxHeapify(&heap, n, largest)
        }
    }
    
    func heapSort(_ nums: inout [Int]) {
        // 把数组调成大顶堆
        var heapRoot = ((nums.count - 1) - 1) / 2
        while heapRoot >= 0 {
            minHeapify(&nums, nums.count, heapRoot)
            heapRoot -= 1
        }
        // 得到大顶堆后开始排序
        var sortIndex = nums.count - 1
        while sortIndex >= 0 {
            nums.swapAt(0, sortIndex)
            minHeapify(&nums, sortIndex, 0)
            sortIndex -= 1
        }
    }
    
    /// 插入排序， 时间复杂度最好O(n), 最坏O(n²)， 它是稳定的算法
    /// - Parameter nums: 入参数组
    func insertSort(_ nums: inout [Int]) {
        // 对数组进行遍历
        for index in 0 ..< nums.count {
            // 取当前遍历值为基准值
            let baseValue = nums[index]
            var preIndex = index
            // 声明一个逐渐向左移动的指针，如果该指针的前一个元素大于基准值，说明当前下标要换成前一个元素
            while preIndex > 0 && nums[preIndex - 1] > baseValue {
                nums[preIndex] = nums[preIndex - 1]
                preIndex -= 1
            }
            // 移动结束后， 指针所在的位置应该填上基准值
            nums[preIndex] = baseValue
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
    
    // 洗牌算法, 时间复杂度O(n), 空间复杂度O(1)
    func shuffleSort(_ nums: inout [Int]) {
        for (index, _) in nums.enumerated() {
            let randomIndex = Int.random(in: index ..< nums.count)
            nums.swapAt(index, randomIndex)
        }
    }
}

var sortedNums = [9, 9, 8, 9, 5, 7, 3, 1, 5, 6, 3, 8, 8, 9, 7, 6, 7, 9, 5, 1, 3, 3, 4]

var shuffleNums = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]

SortStyles().heapSort(&sortedNums)
