import UIKit
import Combine

class SortStyles {
    // 1.冒泡排序
    func bubbleSort(nums: inout [Int]) {
        for index in 0 ..< nums.count {
            for index2 in 0 ..< nums.count - 1 - index {
                if nums[index2] > nums[index2 + 1] {
                    let temp = nums[index2]
                    nums[index2] = nums[index2 + 1]
                    nums[index2 + 1] = temp
                }
            }
        }
    }
    
    // 2.选择排序,有快慢两个指针,快指针的位置比慢指针多1
    func selectSort(nums: inout [Int]) {
        for i in 0 ..< nums.count {
            var minIndex = i // 这个索引表示更小的那个元素
            for j in i + 1 ..< nums.count {
                if nums[minIndex] > nums[j] {
                    minIndex = j
                }
            }
            // 比较出大小后按照排序顺序交换两个元素的值
            let temp = nums[i]
            nums[i] = nums[minIndex]
            nums[minIndex] = temp
        }
    }
    
    // 3.Shell排序
    func shellSort(nums: inout [Int]) {
        let length = nums.count
        if length == 0 {
            return
        }
        
        var gap = length / 2
        
        while gap > 0 {
            for i in gap ..< length {
                var j = i - gap
                while j >= 0 && nums[j] > nums[j + gap] {
                    let temp = nums[j]
                    nums[j] = nums[j + gap]
                    nums[j + gap] = temp
                    j = j - gap
                }
            }
            gap = gap / 2
        }
    }
    
    // 4.快速排序
    func quickSort(nums: inout [Int], low: Int, high: Int) {
        if low < high {
            let sortIndex = partition(nums: &nums, low: low, high: high) // 取基准元素将数组分为左右两边
            quickSort(nums: &nums, low: low, high: sortIndex - 1) // 对左边进行排序
            quickSort(nums: &nums, low: sortIndex + 1, high: high) // 对右边进行排序
        }
    }
    
    // 分区需要函数
    func partition(nums: inout [Int], low: Int, high: Int) -> Int {
        print("Low: \(low), High: \(high)")
        let sample = nums[high] // 取基准元素
        var position = low
        for index in low ... high {
            if nums[index] < sample { // 遍历中的元素小于基准元素,将被放到基准元素的左边
                if index != low {
                    nums.swapAt(position, index) // 只要不是下标相同,交换两个元素的位置
                }
                position += 1
            }
        }
        
        if nums[high] != nums[position] {
            nums.swapAt(high, position)
        }
        
        return position
    }
    
    // 5.获取最大的K个数
    func topK(_ nums: inout [Int], _ low: Int, _ high: Int, k: Int) -> [Int] {
        if nums.count > k {
            let index = partition2(&nums, low, high)
            if index > k {
                return topK(&nums, low, index - 1, k: k)
            } else if index < k {
                return topK(&nums, index + 1, high, k: k)
            } else {
                var result = [Int]()
                var count = 0
                while count < k {
                    result.append(nums[count])
                    count += 1
                }
                return result
            }
        } else {
            return nums
        }
    }
    
    // 6.堆排序
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
    
    
    // 默写冒泡
    func bubbleSort2(_ nums: inout [Int]) {
        for i in 0 ..< nums.count {
            for j in 0 ..< nums.count - 1 - i {
                if nums[j] > nums[j + 1] {
                    let temp = nums[j]
                    nums[j] = nums[j + 1]
                    nums[j + 1] = temp
                }
            }
        }
    }
    
    // 默写快排
    func quickSort2(_ nums: inout [Int], _ low: Int, _ high: Int) {
        if low < high {
            let index = partition2(&nums, low, high)
            quickSort2(&nums, low, index - 1)
            quickSort2(&nums, index + 1, high)
        }
    }
    
    func partition2(_ nums: inout [Int], _ low: Int, _ high: Int) -> Int {
        let sample = nums[high]
        var position = low
        for index in low ... high {
            if nums[index] < sample {
                if index != position {
                    nums.swapAt(index, position)
                }
                position += 1
            }
        }
        if nums[high] != nums[position] {
            nums.swapAt(high, position)
        }
        return position
    }
    
    func bubbleSort3(_ nums: inout [Int]) {
        for i in 0 ..< nums.count {
            for j in 0 ..< nums.count - 1 - i {
                if nums[j] < nums[j + 1] {
                    nums.swapAt(j, j + 1)
                }
            }
        }
    }
    
    func partition3(_ nums: inout [Int], low: Int, high: Int) -> Int {
        let sample = nums[high]
        var position = low
        for index in low ... high {
            if sample > nums[index] {
                if index != position {
                    nums.swapAt(index, position)
                }
                position += 1
            }
        }
        if nums[high] != nums[position] {
            nums.swapAt(position, high)
        }
        return position
    }
    
    func partition4(nums: inout [Int], low: Int, high: Int) -> Int {
        let sample = nums[high]
        var position = low
        for index in low ... high {
            if sample < nums[index] {
                if index != position {
                    nums.swapAt(position, index)
                }
            }
            position += 1
        }
        if nums[high] != nums[position] {
            nums.swapAt(high, position)
        }
        return position
    }
    
    func quickSort4(_ nums: inout [Int], low: Int, high: Int) {
        if low < high {
            let index = partition4(nums: &nums, low: low, high: high)
            quickSort4(&nums, low: low, high: index - 1)
            quickSort4(&nums, low: index + 1, high: high)
        }
    }
    
    func bubbleSort4(_ nums: inout [Int]) {
        for i in 0 ..< nums.count {
            for j in 0 ..< nums.count - 1 - i {
                if nums[j] < nums[j + 1] {
                    nums.swapAt(j, j + 1)
                }
            }
        }
    }
    
    func bubbleSort5(_ nums: inout [Int]) {
        for i in 0 ..< nums.count {
            for j in 0 ..< nums.count - 1 - i {
                if nums[j] < nums[j + 1] {
                    nums.swapAt(j, j + 1)
                }
            }
        }
    }
    
    func partition5(_ nums: inout [Int], _ low: Int, _ high: Int) -> Int {
        let sample = nums[high]
        var position = low
        for index in low ... high {
            if sample > nums[index] {
                if position != index {
                    nums.swapAt(index, position)
                }
                position += 1
            }
        }
        if nums[position] != nums[high] {
            nums.swapAt(position, high)
        }
        return position
    }
    
    func quickSort5(_ nums: inout [Int], _ low: Int, _ high: Int) {
        if low < high {
            let index = partition5(&nums, low, high)
            quickSort5(&nums, low, index - 1)
            quickSort5(&nums, index + 1, high)
        }
    }
    
    // 计算一个整形数的二进制形式中1的个数
    func countOneInNumber(num: Int) -> Int {
        var target = num
        var result = 0
        while target > 0 {
            result += 1
            target = target & (target - 1)
        }
        return result
    }
    
    func bubbleSort6(_ nums: inout [Int]) {
        for i in 0 ..< nums.count {
            for j in 0 ..< nums.count - 1 -  i {
                if nums[j] > nums[j + 1] {
                    nums.swapAt(j, j + 1)
                }
            }
        }
    }
    
    func bubbleSort7(_ nums: inout [Int]) {
        for i in 0 ..< nums.count {
            for j in 0 ..< nums.count - 1 - i {
                if nums[j] > nums[j + 1] {
                    nums.swapAt(j, j + 1)
                }
            }
        }
    }
    
    func partition6(_ nums: inout [Int], _ low: Int, _ high: Int) -> Int {
        let sample = nums[high]
        var position = low
        for index in low ... high {
            if sample > nums[index] {
                if position != index {
                    nums.swapAt(position, index)
                }
                position += 1
            }
        }
        if nums[position] != nums[high] {
            nums.swapAt(position, high)
        }
        return position
    }
    
    func quickSort6(_ nums: inout [Int], _ low: Int, _ high: Int) {
        if low < high {
            let index = partition6(&nums, low, high)
            quickSort6(&nums, low, index - 1)
            quickSort6(&nums, index + 1, high)
        }
    }
    
    func partition7(_ nums: inout [Int], _ low: Int, _ high: Int) -> Int {
        let sample = nums[high]
        var position = low
        for index in low ... high {
            if sample > nums[index] {
                if position != index {
                    nums.swapAt(position, index)
                }
                position += 1
            }
        }
        return position
    }
    
    func quickSort7(_ nums: inout [Int], _ low: Int, _ high: Int) {
        guard low < high else {
            return
        }
        let index = partition7(&nums, low, high)
        quickSort7(&nums, low, index - 1)
        quickSort7(&nums, index + 1, high)
    }
    
    func bubbleSort8(_ nums: inout [Int]) {
        for i in 0 ..< nums.count {
            for j in 0 ..< nums.count - 1 - i {
                if nums[j] > nums[j + 1] {
                    nums.swapAt(j, j + 1)
                }
            }
        }
    }
    
    func partition8(_ nums: inout [Int], _ low: Int, _ high: Int) -> Int {
        let sample = nums[high]
        var position = low
        for index in low ... high {
            if sample > nums[index] {
                if position != index {
                    nums.swapAt(position, index)
                }
                position += 1
            }
        }
        if nums[high] != nums[position] {
            nums.swapAt(high, position)
        }
        return position
    }
    
    func quickSort8(_ nums: inout [Int], _ low: Int, _ high: Int) {
        if low < high {
            let index = partition8(&nums, low, high)
            quickSort8(&nums, low, index - 1)
            quickSort8(&nums, index + 1, high)
        }
    }
    
    func bubbleSort9(_ nums: inout [Int]) {
        for i in 0 ..< nums.count {
            for j in 0 ..< nums.count - 1 - i {
                if nums[j] > nums[j + 1] {
                    nums.swapAt(j, j + 1)
                }
            }
        }
    }
    
    func bubbleSort10(_ nums: inout [Int]) {
        for i in 0 ..< nums.count {
            for j in 0 ..< nums.count - 1 - i {
                if nums[j] > nums[j + 1] {
                    nums.swapAt(j, j + 1)
                }
            }
        }
    }
    
    func partition9(_ nums: inout [Int], _ high: Int, _ low: Int) -> Int {
        let sample = nums[high]
        var position = low
        for index in low ... high {
            if sample > nums[index] {
                if position != index {
                    nums.swapAt(position, index)
                }
                position += 1
            }
        }
        
        if nums[high] != nums[position] {
            nums.swapAt(high, position)
        }
        
        return position
    }
    
    func quickSort9(_ nums: inout [Int], _ high: Int, _ low: Int) {
        if low < high {
            let index = partition9(&nums, high, low)
            quickSort9(&nums, index - 1, low)
            quickSort9(&nums, high, index + 1)
        }
    }
    
    func partition10(_ nums: inout [Int], _ low: Int, _ high: Int) -> Int {
        let sample = nums[high]
        var position = low
        for index in low ... high {
            if sample > nums[index] {
                if index != position {
                    nums.swapAt(index, position)
                }
                position += 1
            }
        }
        if nums[position] != nums[high] {
            nums.swapAt(position, high)
        }
        return position
    }
    
    func quickSort10(_ nums: inout [Int], _ low: Int, _ high: Int) {
        if low < high {
            let index = partition10(&nums, low, high)
            quickSort10(&nums, low, index  - 1)
            quickSort10(&nums, index + 1, high)
        }
    }
    
    func bucketSort(_ nums: [Int], _ min: Int, _ max: Int, _ size: Int) -> [Int] {
        let bucketCount = size
        let range = (max - min + 1) / 10
        var result = [Int]()
        var buckets = [[Int]]()
        for _ in 0 ..< bucketCount {
            buckets.append([Int]())
        }
        
        for num in nums {
            let index = (num - min) / range
            buckets[index].append(num)
        }
        
        for i in 0 ..< buckets.count {
            quickSort6(&buckets[i], 0, buckets[i].count - 1)
            for number in buckets[i] {
                result.append(number)
            }
        }
        return result
    }
    
    func insertSort(_ nums: inout [Int]) {
        var current = 0
        var preIndex = 0
        for (index, num) in nums.enumerated() {
            current = num
            preIndex = index - 1
            while preIndex >= 0 && nums[preIndex] > current {
                nums[preIndex + 1] = nums[preIndex]
                preIndex -= 1
            }
            nums[preIndex + 1] = current
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

SortStyles().shuffleSort(&shuffleNums)
