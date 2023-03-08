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
}
