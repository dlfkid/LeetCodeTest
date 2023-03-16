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
}

ArraySolution().search([5], 5)
