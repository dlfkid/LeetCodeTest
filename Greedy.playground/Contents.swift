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
     给定一个数组 prices ，它的第 i 个元素 prices[i] 表示一支给定股票第 i 天的价格。

     你只能选择 某一天 买入这只股票，并选择在 未来的某一个不同的日子 卖出该股票。设计一个算法来计算你所能获取的最大利润。

     返回你可以从这笔交易中获取的最大利润。如果你不能获取任何利润，返回 0 。

      

     示例 1：

     输入：[7,1,5,3,6,4]
     输出：5
     解释：在第 2 天（股票价格 = 1）的时候买入，在第 5 天（股票价格 = 6）的时候卖出，最大利润 = 6-1 = 5 。
          注意利润不能是 7-1 = 6, 因为卖出价格需要大于买入价格；同时，你不能在买入前卖出股票。
     示例 2：

     输入：prices = [7,6,4,3,1]
     输出：0
     解释：在这种情况下, 没有交易完成, 所以最大利润为 0。
     */
    
    func maxProfit1(_ prices: [Int]) -> Int {
        // 遍历的时候假设如果我在第index天卖出, 那么相对于历史最低点我能赚多少钱
        var profit = 0 // 最高利润
        var minimumPriceIndex = -1 // 历史最低点下标
        for index in 0 ..< prices.count {
            let sellPrice = prices[index]
            if minimumPriceIndex == -1 || sellPrice < prices[minimumPriceIndex] {
                // 如果没有记录历史最低点, 记录一下
                minimumPriceIndex = index
            }
            let todayProfit = sellPrice - prices[minimumPriceIndex]
            if profit < todayProfit {
                profit = todayProfit
            }
        }
        return profit
    }
    
    /*
     122
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
    func maxProfit2(_ prices: [Int]) -> Int {
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
        // 使用贪心算法，不纠结具体的跳法，只需要计算在每个位置上的最远跳跃范围
        if nums.count <= 1 {
            // 一步以内的数组，根本不用跳
            return true
        }
        // 当前格子的覆盖范围
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
    
    /*
     给定一个长度为 n 的 0 索引整数数组 nums。初始位置为 nums[0]。

     每个元素 nums[i] 表示从索引 i 向前跳转的最大长度。换句话说，如果你在 nums[i] 处，你可以跳转到任意 nums[i + j] 处:

     0 <= j <= nums[i]
     i + j < n
     返回到达 nums[n - 1] 的最小跳跃次数。生成的测试用例可以到达 nums[n - 1]。

      

     示例 1:

     输入: nums = [2,3,1,1,4]
     输出: 2
     解释: 跳到最后一个位置的最小跳跃数是 2。
          从下标为 0 跳到下标为 1 的位置，跳 1 步，然后跳 3 步到达数组的最后一个位置。
     示例 2:

     输入: nums = [2,3,0,1,4]
     输出: 2

     来源：力扣（LeetCode）
     链接：https://leetcode.cn/problems/jump-game-ii
     著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
     */
    func jump(_ nums: [Int]) -> Int {
        guard nums.count > 1 else {
            return 0
        }
        var result = 0
        var currentRange = 0 // 当前能调到的范围
        var nextRange = 0 // 下次能跳到的范围
        var index =  0
        // 位置不能超过跳跃范围
        while index <= currentRange {
            // 赋值下次跳跃范围
            nextRange = max(index + nums[index], nextRange)
            // 如果位置已经是当前跳跃范围的极限
            if index == currentRange {
                // 未达到末尾
                if currentRange < nums.count - 1 {
                    // 更新当前范围，增加跳数
                    result += 1
                    currentRange = nextRange
                    if currentRange >= nums.count - 1 {
                        // 更新后范围触及末尾，说明这一跳足以结束
                        break
                    }
                } else {
                    // 已到达末尾，结束
                    break
                }
            }
            index += 1
        }
        return result
    }
    
    /*
     给你一个整数数组 nums 和一个整数 k ，按以下方法修改该数组：

     选择某个下标 i 并将 nums[i] 替换为 -nums[i] 。
     重复这个过程恰好 k 次。可以多次选择同一个下标 i 。

     以这种方式修改数组后，返回数组 可能的最大和 。

      

     示例 1：

     输入：nums = [4,2,3], k = 1
     输出：5
     解释：选择下标 1 ，nums 变为 [4,-2,3] 。
     示例 2：

     输入：nums = [3,-1,0,2], k = 3
     输出：6
     解释：选择下标 (1, 2, 2) ，nums 变为 [3,1,0,2] 。
     示例 3：

     输入：nums = [2,-3,-1,5,-4], k = 2
     输出：13
     解释：选择下标 (1, 4) ，nums 变为 [2,3,-1,5,4] 。

     来源：力扣（LeetCode）
     链接：https://leetcode.cn/problems/maximize-sum-of-array-after-k-negations
     著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
     */
    func largestSumAfterKNegations(_ nums: [Int], _ k: Int) -> Int {
        // 首先按照绝对值从大到小的顺序给数组排序
        var sortedNums = nums.sorted { a, b in
            return abs(a) > abs(b)
        }
        var leftChance = k
        // 第一次贪心，当遍历到小于0的数组，对它取反
        for index in 0 ..< sortedNums.count {
            if sortedNums[index] < 0 && leftChance > 0 {
                // 取反
                sortedNums[index] *= -1
                leftChance -= 1
            }
        }
        // 如果此时k没有消耗完，进行第二次贪心
        // 如果k是奇数，直接对最后一位取反，因为如果剩余偶数次的操作的话可以反复对一位数取反使得原数组不变
        if leftChance % 2 == 1 {
            sortedNums[sortedNums.count - 1] *= -1
        }
        // 输出数组和
        return sortedNums.reduce(0, {
            $0 + $1
        })
    }
    
    /*
     在一条环路上有 n 个加油站，其中第 i 个加油站有汽油 gas[i] 升。

     你有一辆油箱容量无限的的汽车，从第 i 个加油站开往第 i+1 个加油站需要消耗汽油 cost[i] 升。你从其中的一个加油站出发，开始时油箱为空。

     给定两个整数数组 gas 和 cost ，如果你可以绕环路行驶一周，则返回出发时加油站的编号，否则返回 -1 。如果存在解，则 保证 它是 唯一 的。

      

     示例 1:

     输入: gas = [1,2,3,4,5], cost = [3,4,5,1,2]
     输出: 3
     解释:
     从 3 号加油站(索引为 3 处)出发，可获得 4 升汽油。此时油箱有 = 0 + 4 = 4 升汽油
     开往 4 号加油站，此时油箱有 4 - 1 + 5 = 8 升汽油
     开往 0 号加油站，此时油箱有 8 - 2 + 1 = 7 升汽油
     开往 1 号加油站，此时油箱有 7 - 3 + 2 = 6 升汽油
     开往 2 号加油站，此时油箱有 6 - 4 + 3 = 5 升汽油
     开往 3 号加油站，你需要消耗 5 升汽油，正好足够你返回到 3 号加油站。
     因此，3 可为起始索引。
     示例 2:

     输入: gas = [2,3,4], cost = [3,4,3]
     输出: -1
     解释:
     你不能从 0 号或 1 号加油站出发，因为没有足够的汽油可以让你行驶到下一个加油站。
     我们从 2 号加油站出发，可以获得 4 升汽油。 此时油箱有 = 0 + 4 = 4 升汽油
     开往 0 号加油站，此时油箱有 4 - 3 + 2 = 3 升汽油
     开往 1 号加油站，此时油箱有 3 - 3 + 3 = 3 升汽油
     你无法返回 2 号加油站，因为返程需要消耗 4 升汽油，但是你的油箱只有 3 升汽油。
     因此，无论怎样，你都不可能绕环路行驶一周。

     来源：力扣（LeetCode）
     链接：https://leetcode.cn/problems/gas-station
     著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
     */
    func canCompleteCircuit(_ gas: [Int], _ cost: [Int]) -> Int {
        // 当前油量累加，计算从当前位置开始跑，是否会导致跑不完
        var tankRemainGas = 0
        // 开始位置
        var startIndex:Int = 0
        // 总油量累加，如果总消耗大于总补充，无论从哪里开始跑都不可能跑完，因为汽车起始油量是0
        var totalGasRemain = 0
        // 通过计算每个站点经过后油箱剩余油量累加是否大于0来判断是否能够绕环路行驶一周，如果不行，则切换起始位置为下一个站点
        for index in 0 ..< gas.count {
            // 每个站点的净油量变化
            let remainPetrol = gas[index] - cost[index]
            tankRemainGas += remainPetrol
            totalGasRemain += remainPetrol
            if tankRemainGas < 0 {
                // 如果从startIndex开始跑，这时候油箱已经空了，不可能跑完， 切换起始位置到当前位置的下一个位置
                startIndex = index + 1
                tankRemainGas = 0 // 清空剩余油量，从新开始累加
            }
        }
        if totalGasRemain < 0 { // 如果遍历一次后，总累加油量是负数， 说明不可能跑完一圈，返回-1
            return -1
        }
        return startIndex
    }
    
    /*
     n 个孩子站成一排。给你一个整数数组 ratings 表示每个孩子的评分。

     你需要按照以下要求，给这些孩子分发糖果：

     每个孩子至少分配到 1 个糖果。
     相邻两个孩子评分更高的孩子会获得更多的糖果。
     请你给每个孩子分发糖果，计算并返回需要准备的 最少糖果数目 。

      

     示例 1：

     输入：ratings = [1,0,2]
     输出：5
     解释：你可以分别给第一个、第二个、第三个孩子分发 2、1、2 颗糖果。
     示例 2：

     输入：ratings = [1,2,2]
     输出：4
     解释：你可以分别给第一个、第二个、第三个孩子分发 1、2、1 颗糖果。
          第三个孩子只得到 1 颗糖果，这满足题面中的两个条件。
      

     提示：

     来源：力扣（LeetCode）
     链接：https://leetcode.cn/problems/candy
     著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
     */
    
    func candy(_ ratings: [Int]) -> Int {
        // 声明结果数组
        var candyDistribute = Array(repeating: 1, count: ratings.count)
        // 从前向后遍历
        var index = 0;
        while index < candyDistribute.count {
            if index == 0 {
                // 第一个孩子肯定能拿到一个糖果
                candyDistribute[index] = 1
            } else {
                // 如果当前孩子比上一个孩子的分数高，就得到上一个孩子的糖果数量 + 1， 否则得到1个
                candyDistribute[index] = ratings[index] > ratings[index - 1] ? candyDistribute[index - 1] + 1 : 1
            }
            index += 1
        }
        // 从后向前遍历
        var lastIndex = candyDistribute.count - 1
        while lastIndex >= 0 {
            if lastIndex < candyDistribute.count - 1 && ratings[lastIndex] > ratings[lastIndex + 1] {
                // 取上一个值加1或保留当前值之中大的那个值，只有大的那个值才能同时满足和左边和右边小朋友比较的糖果数条件。
                candyDistribute[lastIndex] = max(candyDistribute[lastIndex + 1] + 1, candyDistribute[lastIndex])
            }
            lastIndex -= 1
        }
        return candyDistribute.reduce(0, +)
    }
    
    /*
     在柠檬水摊上，每一杯柠檬水的售价为 5 美元。顾客排队购买你的产品，（按账单 bills 支付的顺序）一次购买一杯。

     每位顾客只买一杯柠檬水，然后向你付 5 美元、10 美元或 20 美元。你必须给每个顾客正确找零，也就是说净交易是每位顾客向你支付 5 美元。

     注意，一开始你手头没有任何零钱。

     给你一个整数数组 bills ，其中 bills[i] 是第 i 位顾客付的账。如果你能给每位顾客正确找零，返回 true ，否则返回 false 。

      

     示例 1：

     输入：bills = [5,5,5,10,20]
     输出：true
     解释：
     前 3 位顾客那里，我们按顺序收取 3 张 5 美元的钞票。
     第 4 位顾客那里，我们收取一张 10 美元的钞票，并返还 5 美元。
     第 5 位顾客那里，我们找还一张 10 美元的钞票和一张 5 美元的钞票。
     由于所有客户都得到了正确的找零，所以我们输出 true。
     示例 2：

     输入：bills = [5,5,10,10,20]
     输出：false
     解释：
     前 2 位顾客那里，我们按顺序收取 2 张 5 美元的钞票。
     对于接下来的 2 位顾客，我们收取一张 10 美元的钞票，然后返还 5 美元。
     对于最后一位顾客，我们无法退回 15 美元，因为我们现在只有两张 10 美元的钞票。
     由于不是每位顾客都得到了正确的找零，所以答案是 false。

     来源：力扣（LeetCode）
     链接：https://leetcode.cn/problems/lemonade-change
     著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
     */
    func lemonadeChange(_ bills: [Int]) -> Bool {
        var result = true
        // 用三个变量储存每种面值纸币的张数
        var fiveBucks = 0, tenBucks = 0, twentyBucks = 0
        for bill in bills {
            // 针对客户每次付账的面值，计算每种面值纸币的剩余张数
            if bill == 5 {
                // 5刀的话不用找零， 直接加1
                fiveBucks += 1
            } else if bill == 10 {
                // 10刀的话要找零一张5刀，10刀+1，5刀-1
                tenBucks += 1
                fiveBucks -= 1
            } else if bill == 20 {
                // 如果是20刀， 优先用10刀+5刀的组合去找零，没有的话用三张5刀来找零。 这里局部最优是尽可能保留通用性更好的5刀，全局最优是对每个客户都能找零。
                twentyBucks += 1
                if tenBucks > 0 {
                    tenBucks -= 1
                    fiveBucks -= 1
                } else {
                    fiveBucks -= 3
                }
            }
            // 每次结账后检查库存， 如果有纸币的面值是负数，说明初始不带零钱是找不开的。
            if fiveBucks < 0 || tenBucks < 0 {
                result = false
                break
            }
        }
        return result
    }
    
    /*
     假设有打乱顺序的一群人站成一个队列，数组 people 表示队列中一些人的属性（不一定按顺序）。每个 people[i] = [hi, ki] 表示第 i 个人的身高为 hi ，前面 正好 有 ki 个身高大于或等于 hi 的人。

     请你重新构造并返回输入数组 people 所表示的队列。返回的队列应该格式化为数组 queue ，其中 queue[j] = [hj, kj] 是队列中第 j 个人的属性（queue[0] 是排在队列前面的人）。

      

     示例 1：

     输入：people = [[7,0],[4,4],[7,1],[5,0],[6,1],[5,2]]
     输出：[[5,0],[7,0],[5,2],[6,1],[4,4],[7,1]]
     解释：
     编号为 0 的人身高为 5 ，没有身高更高或者相同的人排在他前面。
     编号为 1 的人身高为 7 ，没有身高更高或者相同的人排在他前面。
     编号为 2 的人身高为 5 ，有 2 个身高更高或者相同的人排在他前面，即编号为 0 和 1 的人。
     编号为 3 的人身高为 6 ，有 1 个身高更高或者相同的人排在他前面，即编号为 1 的人。
     编号为 4 的人身高为 4 ，有 4 个身高更高或者相同的人排在他前面，即编号为 0、1、2、3 的人。
     编号为 5 的人身高为 7 ，有 1 个身高更高或者相同的人排在他前面，即编号为 1 的人。
     因此 [[5,0],[7,0],[5,2],[6,1],[4,4],[7,1]] 是重新构造后的队列。
     示例 2：

     输入：people = [[6,0],[5,0],[4,0],[3,2],[2,2],[1,4]]
     输出：[[4,0],[5,0],[2,2],[3,2],[1,4],[6,0]]

     来源：力扣（LeetCode）
     链接：https://leetcode.cn/problems/queue-reconstruction-by-height
     著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
     */
    func reconstructQueue(_ people: [[Int]]) -> [[Int]] {
        typealias PeopleInfo = (height: Int, higherThanOrEqualto: Int)
        // 入参是二维数组，第一个值是身高，第二个值是排在自己前面比自己高的人，因此我们声明一个元组来存放排队信息
        var sortedInfos = [PeopleInfo]()
        for info: [Int] in people {
            let peopleInfo: PeopleInfo = (info[0], info[1])
            sortedInfos.append(peopleInfo)
        }
        // 对所有人进行排序，身高从高到低排，相同身高时前面人数越少的排前面。
        sortedInfos.sort { (info1, info2) -> Bool in
            if info1.height == info2.height {
                return info1.higherThanOrEqualto < info2.higherThanOrEqualto
            }
            return info1.height > info2.height
        }
        // 构造结果数组
        var result = [[Int]]()
        for (_, targetPeople) in sortedInfos.enumerated() {
            // 把每个人按照他前面的人数定为插入位置，插入到队列中
            let position = targetPeople.higherThanOrEqualto;
            result.insert([targetPeople.height, targetPeople.higherThanOrEqualto], at: result.startIndex + position)
        }
        // 输出结果队列
        return result
    }
    
    /*
     有一些球形气球贴在一堵用 XY 平面表示的墙面上。墙面上的气球记录在整数数组 points ，其中points[i] = [xstart, xend] 表示水平直径在 xstart 和 xend之间的气球。你不知道气球的确切 y 坐标。

     一支弓箭可以沿着 x 轴从不同点 完全垂直 地射出。在坐标 x 处射出一支箭，若有一个气球的直径的开始和结束坐标为 xstart，xend， 且满足  xstart ≤ x ≤ xend，则该气球会被 引爆 。可以射出的弓箭的数量 没有限制 。 弓箭一旦被射出之后，可以无限地前进。

     给你一个数组 points ，返回引爆所有气球所必须射出的 最小 弓箭数 。

      
     示例 1：

     输入：points = [[10,16],[2,8],[1,6],[7,12]]
     输出：2
     解释：气球可以用2支箭来爆破:
     -在x = 6处射出箭，击破气球[2,8]和[1,6]。
     -在x = 11处发射箭，击破气球[10,16]和[7,12]。
     示例 2：

     输入：points = [[1,2],[3,4],[5,6],[7,8]]
     输出：4
     解释：每个气球需要射出一支箭，总共需要4支箭。
     示例 3：

     输入：points = [[1,2],[2,3],[3,4],[4,5]]
     输出：2
     解释：气球可以用2支箭来爆破:
     - 在x = 2处发射箭，击破气球[1,2]和[2,3]。

     来源：力扣（LeetCode）
     链接：https://leetcode.cn/problems/minimum-number-of-arrows-to-burst-balloons
     著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
     */
    func findMinArrowShots(_ points: [[Int]]) -> Int {
        if points.count == 0 {
            return 0
        }
        // 按照气球的结束位置排序
        let sortedPoints = points.sorted { (point1, point2) -> Bool in
            return point1[0] < point2[0]
        }
        // 记录射箭的次数
        var count = 1
        // 记录射箭的位置
        var position = sortedPoints[0][1]
        for point in sortedPoints {
            // 如果气球的开始位置大于射箭的位置，说明这支箭不能射爆这个气球，需要再射一支箭
            if point[0] > position {
                position = point[1]
                count += 1
            }
        }
        return count
    }
    
    /*
     给定一个区间的集合 intervals ，其中 intervals[i] = [starti, endi] 。返回 需要移除区间的最小数量，使剩余区间互不重叠 。

      

     示例 1:

     输入: intervals = [[1,2],[2,3],[3,4],[1,3]]
     输出: 1
     解释: 移除 [1,3] 后，剩下的区间没有重叠。
     示例 2:

     输入: intervals = [ [1,2], [1,2], [1,2] ]
     输出: 2
     解释: 你需要移除两个 [1,2] 来使剩下的区间没有重叠。
     示例 3:

     输入: intervals = [ [1,2], [2,3] ]
     输出: 0
     解释: 你不需要移除任何区间，因为它们已经是无重叠的了。
      

     来源：力扣（LeetCode）
     链接：https://leetcode.cn/problems/non-overlapping-intervals
     著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
     */
    func eraseOverlapIntervals(_ intervals: [[Int]]) -> Int {
        // 一个区间以下的直接不用排序了
        if intervals.count <= 1 {
            return 0
        }
        // 核心思路是先对所有区间进行排序, 然后删除那些有重叠的区间.
        var sortedIntervals = intervals.sorted {
            // 对区间进行左边界排序
            $0[0] < $1[0]
        }
        var result = 0;
        // 遍历排序后的区间
        for index in 0 ..< sortedIntervals.count {
            // 第一个区间不用遍历
            if (index == 0) {
                continue
            }
            // 当前区间
            var currentInterval = sortedIntervals[index]
            // 上一个区间
            let lastInterval = sortedIntervals[index - 1]
            // 如果上一个区间的右边界大于当前区间的左边界, 判定为重叠
            if lastInterval[1] > currentInterval[0] {
                // 计数增加
                result += 1
                // 修正当前区间的右边界, 取当前区间和上一个区间右边界的最小值, 相当于两个区间只保留一个, 再和下一个区间做重叠比较
                currentInterval[1] = min(currentInterval[1], lastInterval[1])
                // 赋值回去
                sortedIntervals[index] = currentInterval
            }
        }
        return result
    }
    
    /*
     给你一个字符串 s 。我们要把这个字符串划分为尽可能多的片段，同一字母最多出现在一个片段中。

     注意，划分结果需要满足：将所有划分结果按顺序连接，得到的字符串仍然是 s 。

     返回一个表示每个字符串片段的长度的列表。

      

     示例 1：
     输入：s = "ababcbacadefegdehijhklij"
     输出：[9,7,8]
     解释：
     划分结果为 "ababcbaca"、"defegde"、"hijhklij" 。
     每个字母最多出现在一个片段中。
     像 "ababcbacadefegde", "hijhklij" 这样的划分是错误的，因为划分的片段数较少。
     示例 2：

     输入：s = "eccbbbbdec"
     输出：[10]

     来源：力扣（LeetCode）
     链接：https://leetcode.cn/problems/partition-labels
     著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
     */
    
    func partitionLabels(_ s: String) -> [Int] {
        var left = 0
        var right = -1
        // 结果集
        var results = [Int]()
        // 记录每个字母的最后出现位置
        var hashTable = [Character: Int]()
        // 根据左区间判断是否还要继续循环
        while left <= s.count - 1 {
            // 对字符串遍历
            for (index, chara) in s.enumerated() {
                // 我们对右区间赋值-1, 避免在未初始化右区间的时候就被break
                if right >= 0 && index >= right {
                    break
                }
                // 如果这个字母已经被查找过了, 直接跳过
                if hashTable[chara] != nil {
                    continue
                }
                // 查找当前字母在字符串最后出现的位置, 这里偷懒用系统函数
                let lastIndex = s.lastIndex(of: chara)
                let lstIndexOfInt: Int = s.distance(from: s.startIndex, to: lastIndex!)
                // 存入哈希表
                hashTable[chara] = lstIndexOfInt
                // 判断当前的最后位置是不是超过了右区间, 如果是就更新右区间位置
                if lstIndexOfInt > right {
                    right = lstIndexOfInt
                }
            }
            // 一轮遍历过后, 得到一个区间, 加入结果集
            results.append(right - left + 1)
            // 将左区间移动到上一个区间的分界线, 并对右区间再次初始化
            left = right + 1
            right = -1
        }
        return results
    }
    
    /*
     当且仅当每个相邻位数上的数字 x 和 y 满足 x <= y 时，我们称这个整数是单调递增的。

     给定一个整数 n ，返回 小于或等于 n 的最大数字，且数字呈 单调递增 。

      

     示例 1:

     输入: n = 10
     输出: 9
     示例 2:

     输入: n = 1234
     输出: 1234
     示例 3:

     输入: n = 332
     输出: 299

     来源：力扣（LeetCode）
     链接：https://leetcode.cn/problems/monotone-increasing-digits
     著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
     */
    func monotoneIncreasingDigits(_ n: Int) -> Int {
    // 将数字转换为字符串
            let numString = String(n)
            // 将字符串转化为Int数组
            let numStringArray = Array(numString)
            var nums = numStringArray.compactMap { character in
                Int(String(character))
            }
            var index = numString.count - 1
            var mark = -1
            while index > 0 {
                let numCurrent = nums[index]
                let numPre = nums[index - 1]
                // 前一位大于当前位, 不符合单调递增, 所以要把前一位的值给拉下来
                if numPre > numCurrent {
                    nums[index - 1] = numPre > 0 ? (numPre - 1) : 9
                    mark = index
                }
                index -= 1
            }
            // 将数组转换为数字, 从标志位开始全部变成9
            for index in 0 ..< numString.count {
                if mark > -1 && index >= mark {
                    nums[index] = 9
                }
            }
            let numString2 = nums.compactMap { num in
                return String(num)
            }.joined()
            return Int(numString2) ?? 0
        }
    
    /*
     给定一个二叉树，我们在树的节点上安装摄像头。

     节点上的每个摄影头都可以监视其父对象、自身及其直接子对象。

     计算监控树的所有节点所需的最小摄像头数量。

      

     示例 1：



     输入：[0,0,null,0,0]
     输出：1
     解释：如图所示，一台摄像头足以监控所有节点。
     示例 2：



     输入：[0,0,null,0,null,0,null,null,0]
     输出：2
     解释：需要至少两个摄像头来监视树的所有节点。 上图显示了摄像头放置的有效位置之一。

     来源：力扣（LeetCode）
     链接：https://leetcode.cn/problems/binary-tree-cameras
     著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
     */
    func minCameraCover(_ root: TreeNode?) -> Int {
        var result = 0
        let rootStatus = backwardTraversal(root, &result)
        if rootStatus == SurveilanceCameraStatus.notCovered {
            // 情况4, 根节点未覆盖, 它自己应该装一个摄像头
            result += 1
        }
        return result
    }
    
    func backwardTraversal(_ root: TreeNode?, _ result: inout Int) -> SurveilanceCameraStatus  {
        // 情况0, 空节点
        guard let tempRoot = root else {
            print("情况1, 空节点")
            return SurveilanceCameraStatus.covered
        }
        let statusLeft = backwardTraversal(tempRoot.left, &result)
        let statusRight = backwardTraversal(tempRoot.right, &result)
        // 情况3, 足有子节点都是已覆盖
        if statusLeft == SurveilanceCameraStatus.covered && statusRight == SurveilanceCameraStatus.covered {
            print("情况4, 未覆盖")
            return SurveilanceCameraStatus.notCovered
        }
        // 情况2, 左右子节点有一个没覆盖
        if statusLeft == SurveilanceCameraStatus.notCovered || statusRight == SurveilanceCameraStatus.notCovered {
            print("情况3, 装摄像")
            result += 1
            return SurveilanceCameraStatus.hasSurveilanceCamera
        }
        // 情况1, 左右子节点有摄像头, 自己是已覆盖
        if statusLeft == SurveilanceCameraStatus.hasSurveilanceCamera || statusRight == SurveilanceCameraStatus.hasSurveilanceCamera {
            print("情况2, 已覆盖")
            return SurveilanceCameraStatus.covered
        }
        return SurveilanceCameraStatus.undefined
    }
    
    /*
     69. x 的平方根
     给你一个非负整数 x ，计算并返回 x 的 算术平方根 。

     由于返回类型是整数，结果只保留 整数部分 ，小数部分将被 舍去 。

     注意：不允许使用任何内置指数函数和算符，例如 pow(x, 0.5) 或者 x ** 0.5 。

      

     示例 1：

     输入：x = 4
     输出：2
     示例 2：

     输入：x = 8
     输出：2
     解释：8 的算术平方根是 2.82842..., 由于返回类型是整数，小数部分将被舍去。
     */
    func mySqrt(_ x: Int) -> Int {
        var l = 0
        var r = x
        var ans = 0
        while l <= r {
            let mid = l  + ((r - l) >> 1)
            if mid * mid <= x {
                ans = mid
                l = mid + 1
            } else {
                r = mid - 1
            }
        }
        return ans
    }
    
    /*
     50. Pow(x, n)
     实现 pow(x, n) ，即计算 x 的整数 n 次幂函数（即，xn ）。

      

     示例 1：

     输入：x = 2.00000, n = 10
     输出：1024.00000
     示例 2：

     输入：x = 2.10000, n = 3
     输出：9.26100
     示例 3：

     输入：x = 2.00000, n = -2
     输出：0.25000
     解释：2-2 = 1/22 = 1/4 = 0.25

     */
    func myPow(_ x: Double, _ n: Int) -> Double {
        guard n != 0 else {
            return 1
        }
        guard n != 1 else {
            return x
        }
        return myPowHelper(x, n)
    }
    
    func myPowHelper(_ x: Double, _ n: Int) -> Double {
        guard n != 0 else {
            return 1
        }
        guard n != 1 else {
            return x
        }
        guard n > 0 else {
            return myPowHelper(1/x, abs(n))
        }
        var result: Double = 0.0
        if n % 2 == 0 {
            let left = myPowHelper(x, n >> 1)
            let right = myPowHelper(x, n >> 1)
            result = left + right
        } else {
            let left = myPowHelper(x, n >> 1)
            let right = myPowHelper(x, (n >> 1) + 1)
            result = left + right
        }
        return result
    }
}

GreedySolutions().myPow(2, 10)

enum SurveilanceCameraStatus: Int {
    case undefined = -1
    case notCovered = 0
    case covered = 1
    case hasSurveilanceCamera = 2
}

public class TreeNode {
    var val: Int
    var left: TreeNode?
    var right: TreeNode?
    init() { self.val = 0; self.left = nil; self.right = nil; }
    init(_ val: Int) { self.val = val; self.left = nil; self.right = nil; }
    init(_ val: Int, _ left: TreeNode?, _ right: TreeNode?) {
        self.val = val
        self.left = left
        self.right = right
    }
}

GreedySolutions().monotoneIncreasingDigits(10)

