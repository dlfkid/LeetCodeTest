import Cocoa

var greeting = "Hello, playground"

/*
 739.每日温度 https://leetcode.cn/problems/daily-temperatures/description/
 给定一个整数数组 temperatures ，表示每天的温度，返回一个数组 answer ，其中 answer[i] 是指对于第 i 天，下一个更高温度出现在几天后。如果气温在这之后都不会升高，请在该位置用 0 来代替。*/

class Solution {
    static func dailyTemperatures(_ temperatures: [Int]) -> [Int] {
        // 结果数组
        var result = Array(repeating: 0, count: temperatures.count)
        // 单调栈
        var monotonicStack = [Int]()
        // 入栈第一个元素
        monotonicStack.append(0)
        // 遍历数组
        for index in 1 ..< temperatures.count {
            // 栈顶下标元素和当前元素比较, 如果当前元素小于等于栈顶下标元素, 将该元素的下标入栈
            let current = temperatures[index]
            if let stackTop = monotonicStack.last, temperatures[stackTop] > current {
                monotonicStack.append(index)
                continue
            }
            // 如果当前元素大于栈顶下标的元素, 对栈做循环出栈操作, 直到栈为空或当前栈顶下标元素大于当前元素
            while let topStack = monotonicStack.last, !monotonicStack.isEmpty, temperatures[topStack] < current {
                print("栈顶元素 = \(temperatures[topStack]), 当前元素 = \(current)")
                let length = index - topStack
                result[topStack] = length
                monotonicStack.popLast()
            }
            // 将当前天数入栈
            monotonicStack.append(index)
            print("当前栈 = \(monotonicStack)")
        }
        return result
    }
}

let temperatures = [73,74,75,71,69,72,76,73]

let result = Solution.dailyTemperatures(temperatures)

print("最终结果 = \(result)")
