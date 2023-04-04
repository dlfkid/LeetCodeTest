import Cocoa

extension Array where Element == Int {
    func quickSort() -> [Int] {
        var result = Array(self)
        quickSortInternal(result: &result, high: result.count - 1, low: 0)
        return result
    }
    
    func quickSortInternal(result: inout [Int], high: Int, low: Int) {
        guard high >= low else {
            return
        }
        var tempHigh = high
        var tempLow = low
        let baseValue = result[low]
        while tempHigh > tempLow && result[tempHigh] >= baseValue {
            tempHigh -= 1
        }
        if tempHigh > tempLow {
            result[tempLow] = result[tempHigh]
        }
        while tempHigh > tempLow && result[tempLow] <= baseValue {
            tempLow += 1
        }
        if tempHigh > tempLow {
            result[tempHigh] = result[tempLow]
        }
        result[tempLow] = baseValue
        quickSortInternal(result: &result, high: high, low: tempLow + 1)
        quickSortInternal(result: &result, high: tempLow - 1, low: low)
    }
}

class GreedySolutions {
    /*
     No. 554
     假设你是一位很棒的家长，想要给你的孩子们一些小饼干。但是，每个孩子最多只能给一块饼干。

     对每个孩子 i，都有一个胃口值 g[i]，这是能让孩子们满足胃口的饼干的最小尺寸；并且每块饼干 j，都有一个尺寸 s[j] 。如果 s[j] >= g[i]，我们可以将这个饼干 j 分配给孩子 i ，这个孩子会得到满足。你的目标是尽可能满足越多数量的孩子，并输出这个最大数值。
     */
    func findContentChildren(_ g: [Int], _ s: [Int]) -> Int {
        // 饼干大小排序
        var sortedBuscitSize = s.quickSort()
        // 小孩胃口排序
        var sortedGluttony = g.quickSort()
        
        var gluttonyIndex = 0
        var buscitIndex = 0
        
        while gluttonyIndex < g.count && buscitIndex < s.count { //当其中一个遍历就结束
                    if (sortedGluttony[gluttonyIndex] <= sortedBuscitSize[buscitIndex]){ //当用当前饼干可以满足当前孩子的需求，可以满足的孩子数量+1
                        gluttonyIndex += 1
                    }
                    buscitIndex += 1; // 饼干只可以用一次，因为饼干如果小的话，就是无法满足被抛弃，满足的话就是被用了
                }
        return gluttonyIndex;
    }
    
    /*
     你正在参加一场比赛，给你两个 正 整数 initialEnergy 和 initialExperience 分别表示你的初始精力和初始经验。

     另给你两个下标从 0 开始的整数数组 energy 和 experience，长度均为 n 。

     你将会 依次 对上 n 个对手。第 i 个对手的精力和经验分别用 energy[i] 和 experience[i] 表示。当你对上对手时，需要在经验和精力上都 严格 超过对手才能击败他们，然后在可能的情况下继续对上下一个对手。

     击败第 i 个对手会使你的经验 增加 experience[i]，但会将你的精力 减少  energy[i] 。

     在开始比赛前，你可以训练几个小时。每训练一个小时，你可以选择将增加经验增加 1 或者 将精力增加 1 。

     返回击败全部 n 个对手需要训练的 最少 小时数目。

     来源：力扣（LeetCode）
     链接：https://leetcode.cn/problems/minimum-hours-of-training-to-win-a-competition
     著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
     */
    
    func minNumberOfHours(_ initialEnergy: Int, _ initialExperience: Int, _ energy: [Int], _ experience: [Int]) -> Int {
        var finalEnergy = initialEnergy
        var finalExperience = initialExperience
        var exerciseHour = 0
        guard energy.count == experience.count else {
            return 0
        }
        for index in 0 ..< energy.count {
            if finalEnergy <= energy[index] || finalExperience <= experience[index] {
                // 失败的情况
                if finalEnergy <= energy[index] {
                    let lackEnergy = (energy[index] - finalEnergy) + 1
                    // 计算出缺少的训练量并强化主角
                    finalEnergy += lackEnergy
                    exerciseHour += lackEnergy
                }
                if finalExperience <= experience[index] {
                    let lackExperience = (experience[index] - finalExperience) + 1
                    // 计算出缺少的训练量并强化主角
                    finalExperience += lackExperience
                    exerciseHour += lackExperience
                }
            }
            // 模拟打赢了的结果
            finalEnergy -= energy[index]
            finalExperience += experience[index]
        }
        return exerciseHour
    }
    
    /*
     如果连续数字之间的差严格地在正数和负数之间交替，则数字序列称为 摆动序列 。第一个差（如果存在的话）可能是正数或负数。仅有一个元素或者含两个不等元素的序列也视作摆动序列。

     例如， [1, 7, 4, 9, 2, 5] 是一个 摆动序列 ，因为差值 (6, -3, 5, -7, 3) 是正负交替出现的。

     相反，[1, 4, 7, 2, 5] 和 [1, 7, 4, 5, 5] 不是摆动序列，第一个序列是因为它的前两个差值都是正数，第二个序列是因为它的最后一个差值为零。
     子序列 可以通过从原始序列中删除一些（也可以不删除）元素来获得，剩下的元素保持其原始顺序。

     给你一个整数数组 nums ，返回 nums 中作为 摆动序列 的 最长子序列的长度 。

      

     示例 1：

     输入：nums = [1,7,4,9,2,5]
     输出：6
     解释：整个序列均为摆动序列，各元素之间的差值为 (6, -3, 5, -7, 3) 。
     示例 2：

     输入：nums = [1,17,5,10,13,15,10,5,16,8]
     输出：7
     解释：这个序列包含几个长度为 7 摆动序列。
     其中一个是 [1, 17, 10, 13, 10, 16, 8] ，各元素之间的差值为 (16, -7, 3, -3, 6, -8) 。
     示例 3：

     输入：nums = [1,2,3,4,5,6,7,8,9]
     输出：2

     来源：力扣（LeetCode）
     链接：https://leetcode.cn/problems/wiggle-subsequence
     著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
     */
    func wiggleMaxLength(_ nums: [Int]) -> Int {
        // 解题思路，当有两个元素以上时，首尾都算一个峰
        // 计算两个元素之间的差，如果符号位相反，说明发生了摆动，此时再更新上一个差值
        // 差值的初始值为0，可以视为数组首个元素前面还有一个相同的值，导致差值为0
        // 因为差值计算是i减去i + 1遍历范围不能包括最后一个元素
        // 如果没有发生摆动，不用更新上一个差值，因为会有可能发生单调递增数组的平坡，这种不被视为摆动
        var result = 1
        var preDiff = 0
        var currentDiff = 0
        for index in 0 ..< nums.count - 1 {
            currentDiff = nums[index + 1] - nums[index]
            if (preDiff >= 0 && currentDiff < 0) || (preDiff <= 0 && currentDiff > 0) {
                result += 1
                preDiff = currentDiff
            }
        }
        return result
    }
}

GreedySolutions().minNumberOfHours(5, 3, [1, 4, 3, 2], [2, 6, 3, 1])
