import UIKit

class SortSyles {
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
        for i in (0...(nums.count/2 - 1)).reversed() {
            self.adjustHeap(&nums, i, nums.count)
        }
        // 2.得到大顶堆,就是根节点最大的树,根节点和原数组末位交换,继续调整堆顶
        for j in (1...(nums.count - 1)).reversed() {
            nums.swapAt(0, j)
            self.adjustHeap(&nums, 0, j)
        }
    }
    
    func adjustHeap(_ nums: inout [Int], _ i: Int, _ length: Int) {
        var index = i
        let temp = nums[index]
        var k = index * 2 + 1
        while k < length {
            if (k + 1 < length && nums[k] < nums[k + 1]) {
                k += 1
            }
            if (nums[k] > temp) {
                nums[index] = nums[k]
                index = k
            } else {
                break
            }
            k = k * 2 + 1
        }
        nums[index] = temp
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
    
    /// 另一种快排
    /// - Parameter nums: 被排数组
    func customQuickSort(_ nums: inout [Int]) {
        // 如果只有一个数的不需要排了
        guard nums.count > 1 else {
            return
        }
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
        guard high >= low else {
            return
        }
        var tempHigh = high
        var tempLow = low
        let baseNum = nums[low]
        while tempHigh > tempLow {
            while tempHigh > tempLow && nums[tempHigh] >= baseNum {
                tempHigh -= 1
            }
            if tempHigh > tempLow {
                nums[tempLow] = nums[tempHigh]
            }
            while tempHigh > tempLow && nums[tempLow] <= baseNum {
                tempLow += 1
            }
            if tempHigh > tempLow {
                nums[tempHigh] = nums[tempLow]
            }
        }
        let divide = tempHigh
        nums[divide] = baseNum
        quickSortDivide(nums: &nums, high: high, low: divide + 1)
        quickSortDivide(nums: &nums, high: divide - 1, low: low)
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
}

