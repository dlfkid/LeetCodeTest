import Cocoa

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
}

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
