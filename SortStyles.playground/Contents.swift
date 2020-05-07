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
        let sample = nums[low] // 取基准元素
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
            let index = partition4(nums: &nums, low: 0, high: nums.count - 1)
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
}

var sampleArray = [9,8,7,10,5,4,6,2,3]

//SortSyles().bubbleSort(nums: &sampleArray)
//SortSyles().selectSort(nums: &sampleArray)
//SortSyles().shellSort(nums: &sampleArray)
SortSyles().quickSort(nums: &sampleArray, low: 0, high: sampleArray.count - 1)
SortSyles().bubbleSort4(&sampleArray)
SortSyles().topK(&sampleArray, 0, sampleArray.count - 1, k: 5)

