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
    
    /*
     给你一个整数数组 nums ，请你找出一个具有最大和的连续子数组（子数组最少包含一个元素），返回其最大和。

     子数组 是数组中的一个连续部分。

      

     示例 1：

     输入：nums = [-2,1,-3,4,-1,2,1,-5,4]
     输出：6
     解释：连续子数组 [4,-1,2,1] 的和最大，为 6 。
     示例 2：

     输入：nums = [1]
     输出：1
     示例 3：

     输入：nums = [5,4,-1,7,8]
     输出：23
      

     来源：力扣（LeetCode）
     链接：https://leetcode.cn/problems/maximum-subarray
     著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
     */
    func maxSubArray(_ nums: [Int]) -> Int {
        // 采用贪心算法解题，首先要知道局部最优是指当前子序列是否小于0，如果小于0，说明累加只会导致和越来越小，应该跳过，在数组是全负数的情况下，空数组的和最大，也就是0，所以这里可以将count初始化为0
        var result = Int.min
        var count = 0
        for index in 0 ..< nums.count {
            count += nums[index]
            if count > result {
                result = count
            }
            if count < 0 {
                count = 0
            }
        }
        return result
    }
    
    /*
     给你一个整数数组 prices ，其中 prices[i] 表示某支股票第 i 天的价格。

     在每一天，你可以决定是否购买和/或出售股票。你在任何时候 最多 只能持有 一股 股票。你也可以先购买，然后在 同一天 出售。

     返回 你能获得的 最大 利润 。

      

     示例 1：

     输入：prices = [7,1,5,3,6,4]
     输出：7
     解释：在第 2 天（股票价格 = 1）的时候买入，在第 3 天（股票价格 = 5）的时候卖出, 这笔交易所能获得利润 = 5 - 1 = 4 。
          随后，在第 4 天（股票价格 = 3）的时候买入，在第 5 天（股票价格 = 6）的时候卖出, 这笔交易所能获得利润 = 6 - 3 = 3 。
          总利润为 4 + 3 = 7 。
     示例 2：

     输入：prices = [1,2,3,4,5]
     输出：4
     解释：在第 1 天（股票价格 = 1）的时候买入，在第 5 天 （股票价格 = 5）的时候卖出, 这笔交易所能获得利润 = 5 - 1 = 4 。
          总利润为 4 。
     示例 3：

     输入：prices = [7,6,4,3,1]
     输出：0
     解释：在这种情况下, 交易无法获得正利润，所以不参与交易可以获得最大利润，最大利润为 0 。
      

     来源：力扣（LeetCode）
     链接：https://leetcode.cn/problems/best-time-to-buy-and-sell-stock-ii
     著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
     */
    func maxProfit(_ prices: [Int]) -> Int {
        // 使用贪心算法，如果今天的价格比昨天要高，就立刻卖出，积累利润
        var profix = 0
        for day in 1 ..< prices.count  {
            if prices[day] > prices[day -  1] {
                profix += prices[day] - prices[day -  1]
            }
        }
        return profix
    }
    
    /*
     给定一个非负整数数组 nums ，你最初位于数组的 第一个下标 。

     数组中的每个元素代表你在该位置可以跳跃的最大长度。

     判断你是否能够到达最后一个下标。

      

     示例 1：

     输入：nums = [2,3,1,1,4]
     输出：true
     解释：可以先跳 1 步，从下标 0 到达下标 1, 然后再从下标 1 跳 3 步到达最后一个下标。
     示例 2：

     输入：nums = [3,2,1,0,4]
     输出：false
     解释：无论怎样，总会到达下标为 3 的位置。但该下标的最大跳跃长度是 0 ， 所以永远不可能到达最后一个下标。
      

     来源：力扣（LeetCode）
     链接：https://leetcode.cn/problems/jump-game
     著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
     */
    func canJump(_ nums: [Int]) -> Bool {
        // 使用贪心算法，不纠结具体的跳法，只需要计算在每个位置上的最远跳跃
        if nums.count <= 1 {
            return true
        }
        var cover = nums[0]
        var index = 0
        var result = false
        while index <= cover {
            cover = max(index + nums[index], cover)
            if cover >= nums.count - 1 {
                result = true
                break
            }
            index += 1
        }
        return result
    }
}

GreedySolutions().canJump([3,2,1,0,4])
