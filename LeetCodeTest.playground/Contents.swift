import UIKit

/*
 
1. 给定一个整数数组 nums 和一个目标值 target，请你在该数组中找出和为目标值的那 两个 整数，并返回他们的数组下标。
 
 你可以假设每种输入只会对应一个答案。但是，你不能重复利用这个数组中同样的元素。
 
 示例:
 
 给定 nums = [2, 7, 11, 15], target = 9
 
 因为 nums[0] + nums[1] = 2 + 7 = 9
 所以返回 [0, 1]
 
 以下的解法是暴力破解法，更优秀的算法应该使用哈希表来实现
 
 */

let nums = [2, 7, 11, 15], target = 9

func sumElement(nums: [Int], target: Int) -> [Int] {
    for index in 0 ..< nums.count {
        let num = nums[index]
        let otherNum = target - num
        for subIndex in 0 ..< nums.count {
            let subNum = nums[subIndex]
            if otherNum == subNum && index != subIndex {
                return [index, subIndex]
            }
        }
    }
    return [0, 0]
}

sumElement(nums: nums, target: target)

