import Cocoa

var greeting = "Hello, playground"

class DynamicProgramming {
    /*
     斐波那契数 （通常用 F(n) 表示）形成的序列称为 斐波那契数列 。该数列由 0 和 1 开始，后面的每一项数字都是前面两项数字的和。也就是：

     F(0) = 0，F(1) = 1
     F(n) = F(n - 1) + F(n - 2)，其中 n > 1
     给定 n ，请计算 F(n) 。

     来源：力扣（LeetCode）
     链接：https://leetcode.cn/problems/fibonacci-number
     著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
     */
    func fib(_ n: Int) -> Int {
        guard n > 0 else {
            return 0
        }
        guard n > 1 else {
            return 1
        }
        var last2 = 0
        var last1 = 1
        var current = 0
        for index in 0 ... n {
            if index == 0 || index == 1{
                continue
            }
            let tempLast1 = last1
            let tempLast2 = last2
            current = tempLast1 + tempLast2
            last1 = current
            last2 = tempLast1
        }
        return current
    }
    
    /*
     给你一个字符串 s ，它仅包含字符 'a' 和 'b'​​​​ 。

     你可以删除 s 中任意数目的字符，使得 s 平衡 。当不存在下标对 (i,j) 满足 i < j ，且 s[i] = 'b' 的同时 s[j]= 'a' ，此时认为 s 是 平衡 的。

     请你返回使 s 平衡 的 最少 删除次数。

     来源：力扣（LeetCode）
     链接：https://leetcode.cn/problems/minimum-deletions-to-make-string-balanced
     著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
     */
    func minimumDeletions(_ s: String) -> Int {
        var temp = 0
        var result = 0
        for chara in s {
            if chara == Character("a") {
                result =  min(temp, result + 1)
            } else {
                temp += 1
            }
        }
        return result
    }
    
    /*
     在一个 m*n 的棋盘的每一格都放有一个礼物，每个礼物都有一定的价值（价值大于 0）。你可以从棋盘的左上角开始拿格子里的礼物，并每次向右或者向下移动一格、直到到达棋盘的右下角。给定一个棋盘及其上面的礼物的价值，请计算你最多能拿到多少价值的礼物？

      

     示例 1:

     输入:
     [
       [1,3,1],
       [1,5,1],
       [4,2,1]
     ]
     输出: 12
     解释: 路径 1→3→5→2→1 可以拿到最多价值的礼物

     来源：力扣（LeetCode）
     链接：https://leetcode.cn/problems/li-wu-de-zui-da-jie-zhi-lcof
     著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
     */
    
    func maxValue(_ grid: [[Int]]) -> Int {
        /*
            1. 按照题目规则, 只能向下或向右走
            2. 创建一个走到每个位置的价值最大值的二维数组
            3. 第一行的格子, 只能从左边走过来, 所以当前值 + 左边格子的值就是累加值
            4. 第一列的格子, 只能从上边走过来, 所以当前值 + 上边格子的值是累加值
            5. 其他格子, 可以从上边或左边走过来, 所以当前值 + 上边或左边值的最大者是累加值
            6. 输出二维数组后, 右下角就是题目要求的值
         */
        let maxColumn = grid[0].count
        let maxLine = grid.count
        var dp = Array(repeating: Array(repeating: 0, count: maxColumn), count: maxLine)
        dp[0][0] = grid[0][0]
        for line in 0 ..< maxLine {
            for column in 0 ..< maxColumn {
                if line == 0 && column == 0 {
                    continue
                } else if line == 0 && column > 0 {
                    dp[line][column] = dp[0][column - 1] + grid[line][column]
                } else if line > 0 && column == 0 {
                    dp[line][column] = dp[line - 1][0] + grid[line][column]
                } else {
                    dp[line][column] = max(dp[line - 1][column], dp[line][column - 1]) + grid[line][column]
                }
            }
        }
        return dp[maxLine - 1][maxColumn - 1]
    }
    
    /*
     假设你正在爬楼梯。需要 n 阶你才能到达楼顶。

     每次你可以爬 1 或 2 个台阶。你有多少种不同的方法可以爬到楼顶呢？

      

     示例 1：

     输入：n = 2
     输出：2
     解释：有两种方法可以爬到楼顶。
     1. 1 阶 + 1 阶
     2. 2 阶
     示例 2：

     输入：n = 3
     输出：3
     解释：有三种方法可以爬到楼顶。
     1. 1 阶 + 1 阶 + 1 阶
     2. 1 阶 + 2 阶
     3. 2 阶 + 1 阶

     来源：力扣（LeetCode）
     链接：https://leetcode.cn/problems/climbing-stairs
     著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
     */
    func climbStairs(_ n: Int) -> Int {
        guard n > 0 else {
            return 0
        }
        guard n > 1 else {
            return 1
        }
        guard n > 2 else {
            return 2
        }
        var last2 = 1
        var last1 = 2
        var current = 0
        for index in 0 ... n {
            if index <= 2 {
                continue
            }
            let tempLast1 = last1
            let tempLast2 = last2
            current = tempLast1 + tempLast2
            last1 = current
            last2 = tempLast1
        }
        return current
    }
    
    /*
     给你一个整数数组 cost ，其中 cost[i] 是从楼梯第 i 个台阶向上爬需要支付的费用。一旦你支付此费用，即可选择向上爬一个或者两个台阶。

     你可以选择从下标为 0 或下标为 1 的台阶开始爬楼梯。

     请你计算并返回达到楼梯顶部的最低花费。

      

     示例 1：

     输入：cost = [10,15,20]
     输出：15
     解释：你将从下标为 1 的台阶开始。
     - 支付 15 ，向上爬两个台阶，到达楼梯顶部。
     总花费为 15 。
     示例 2：

     输入：cost = [1,100,1,1,1,100,1,1,100,1]
     输出：6
     解释：你将从下标为 0 的台阶开始。
     - 支付 1 ，向上爬两个台阶，到达下标为 2 的台阶。
     - 支付 1 ，向上爬两个台阶，到达下标为 4 的台阶。
     - 支付 1 ，向上爬两个台阶，到达下标为 6 的台阶。
     - 支付 1 ，向上爬一个台阶，到达下标为 7 的台阶。
     - 支付 1 ，向上爬两个台阶，到达下标为 9 的台阶。
     - 支付 1 ，向上爬一个台阶，到达楼梯顶部。
     总花费为 6 。

     来源：力扣（LeetCode）
     链接：https://leetcode.cn/problems/min-cost-climbing-stairs
     著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
     */
    func minCostClimbingStairs(_ cost: [Int]) -> Int {
        // dp数组的下标表示在第几个台阶, 值是到达这个台阶的最小消耗, 多了一个顶层所以数组长度比入参多一个
        var dp = Array(repeating: 0, count: cost.count + 1)
        // 按照题目描述, 起点可以选择0或者1, 这两个位置不需要花费, 所以dp0和dp1都是0
        dp[0] = 0
        dp[1] = 0
        for index in 2 ... cost.count {
            // 从上个台阶跳一步
            let minCost1 = dp[index - 1] + cost[index - 1]
            // 从上上个台阶跳两步
            let minCost2 = dp[index - 2] + cost[index - 2]
            // 花费较小的值输入数组
            dp[index] = min(minCost1, minCost2)
        }
        return dp[cost.count]
    }
    
    /*
     一个机器人位于一个 m x n 网格的左上角 （起始点在下图中标记为 “Start” ）。

     机器人每次只能向下或者向右移动一步。机器人试图达到网格的右下角（在下图中标记为 “Finish” ）。

     问总共有多少条不同的路径？

      

     示例 1：


     输入：m = 3, n = 7
     输出：28
     示例 2：

     输入：m = 3, n = 2
     输出：3
     解释：
     从左上角开始，总共有 3 条路径可以到达右下角。
     1. 向右 -> 向下 -> 向下
     2. 向下 -> 向下 -> 向右
     3. 向下 -> 向右 -> 向下

     来源：力扣（LeetCode）
     链接：https://leetcode.cn/problems/unique-paths
     著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
     */
    func uniquePaths(_ m: Int, _ n: Int) -> Int {
        // 列出DP数组，每个格子的值是走到这个格子的路径数
        var dp: [[Int]] = Array(repeating: Array(repeating: 0, count: n), count: m)
        // 行
        for lineIndex in 0 ..< m {
            // 列
            for columnIndex in 0 ..< n {
                // 毫无疑问，第一行的格子只能从左边向右走到达，所以路径都是1
                if lineIndex == 0 {
                    dp[lineIndex][columnIndex] = 1
                }
                // 同样，第一列的格子只能从上方向下走到达，所以路径也都是1
                else if columnIndex == 0 {
                    dp[lineIndex][columnIndex] = 1
                }
                // 行列都大于0的格子，可以从上方或者左方到达，所以是上方格子的走法 + 左方格子的走法
                else {
                    dp[lineIndex][columnIndex] = dp[lineIndex][columnIndex - 1] + dp[lineIndex - 1][columnIndex]
                }
            }
        }
        return dp[m - 1][n - 1]
    }
}
