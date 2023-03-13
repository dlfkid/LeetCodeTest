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
}

GreedySolutions().minNumberOfHours(5, 3, [1, 4, 3, 2], [2, 6, 3, 1])
