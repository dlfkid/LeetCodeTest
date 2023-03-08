import Cocoa

var greeting = "Hello, playground"

class DynamicProgramming {
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
}

DynamicProgramming().maxValue([[1,2,5],
                               [3,2,1]])
