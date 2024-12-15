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
    
    /*
     一个机器人位于一个 m x n 网格的左上角 （起始点在下图中标记为 “Start” ）。

     机器人每次只能向下或者向右移动一步。机器人试图达到网格的右下角（在下图中标记为 “Finish”）。

     现在考虑网格中有障碍物。那么从左上角到右下角将会有多少条不同的路径？

     网格中的障碍物和空位置分别用 1 和 0 来表示。

      

     示例 1：


     输入：obstacleGrid = [[0,0,0],[0,1,0],[0,0,0]]
     输出：2
     解释：3x3 网格的正中间有一个障碍物。
     从左上角到右下角一共有 2 条不同的路径：
     1. 向右 -> 向右 -> 向下 -> 向下
     2. 向下 -> 向下 -> 向右 -> 向右

     来源：力扣（LeetCode）
     链接：https://leetcode.cn/problems/unique-paths-ii
     著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
     */
    
    func uniquePathsWithObstacles(_ obstacleGrid: [[Int]]) -> Int {
        // 列出DP数组，每个格子的值是走到这个格子的路径数
        let m = obstacleGrid.count
        let n = obstacleGrid.first?.count ?? 0
        var dp: [[Int]] = Array(repeating: Array(repeating: 0, count: n), count: m)
        // 行
        for lineIndex in 0 ..< m {
            // 列
            for columnIndex in 0 ..< n {
                // 但要判断当前格子有没有障碍，如果有那只能等于0
                if obstacleGrid[lineIndex][columnIndex] == 1 {
                    continue
                }
                // 毫无疑问，第一行的格子只能从左边向右走到达，所以路径都是1
                if lineIndex == 0 {
                    // 同时判断左方格子是不是0，如果是说明左方路已经被挡住了
                    if columnIndex > 0 && dp[lineIndex][columnIndex - 1] == 0 {
                        continue
                    }
                    dp[lineIndex][columnIndex] = 1
                }
                // 同样，第一列的格子只能从上方向下走到达，所以路径也都是1
                else if columnIndex == 0 {
                    // 同时判断上方格子是不是0，如果是说明左方路已经被挡住了
                    if lineIndex > 0 && dp[lineIndex - 1][columnIndex] == 0 {
                        continue
                    }
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
    
    /*
     给定一个正整数 n ，将其拆分为 k 个 正整数 的和（ k >= 2 ），并使这些整数的乘积最大化。

     返回 你可以获得的最大乘积 。

      

     示例 1:

     输入: n = 2
     输出: 1
     解释: 2 = 1 + 1, 1 × 1 = 1。
     示例 2:

     输入: n = 10
     输出: 36
     解释: 10 = 3 + 3 + 4, 3 × 3 × 4 = 36。
      

     来源：力扣（LeetCode）
     链接：https://leetcode.cn/problems/integer-break
     著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
     */
    func integerBreak(_ n: Int) -> Int {
        // 含义，对下标i进行拆分，得到拆分后元素的乘积的最大值为dp[i]
        // 初始化递推数组
        var dp = [Int](Array(repeating: 0, count: n + 1))
        // n = 2是第一个有意义的结果，这里直接赋值
        dp[2] = 1
        // 用卫语句提前返回递推数组的初始值
        guard n > 2 else {
            return dp[n]
        }
        for index in 3 ... n {
            for j in 1 ... index / 2 {
                // 拆分j后计算乘积
                let temp1 = j * dp[index - j]
                // 直接采用所拆乘积
                let temp2 = j * (index - j)
                // 递推中取最大值
                let temp3 = dp[index]
                let result = max(max(temp1, temp2), temp3)
                dp[index] = result
            }
        }
        return dp[n]
    }
    
    /*
     给你一个整数 n ，求恰由 n 个节点组成且节点值从 1 到 n 互不相同的 二叉搜索树 有多少种？返回满足题意的二叉搜索树的种数。

      

     示例 1：


     输入：n = 3
     输出：5
     示例 2：

     输入：n = 1
     输出：1

     来源：力扣（LeetCode）
     链接：https://leetcode.cn/problems/unique-binary-search-trees
     著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
     */
    func numTrees(_ n: Int) -> Int {
        var dp = [Int](repeating: 0, count: n + 2)
        dp[0] = 1
        guard n > 0 else {
            return dp[n]
        }
        for i in 1 ... n {
            for j in 1 ... i {
                dp[i] += dp[j - 1] * dp[i - j]
            }
        }
        return dp[n]
    }
    
    /*
     64. 最小路径和
     给定一个包含非负整数的 m x n 网格 grid ，请找出一条从左上角到右下角的路径，使得路径上的数字总和为最小。

     说明：每次只能向下或者向右移动一步。

      

     示例 1：


     输入：grid = [[1,3,1],[1,5,1],[4,2,1]]
     输出：7
     解释：因为路径 1→3→1→1→1 的总和最小。
     示例 2：

     输入：grid = [[1,2,3],[4,5,6]]
     输出：12
     */
    func minPathSum(_ grid: [[Int]]) -> Int {
        guard grid.count > 0, let firstLine = grid.first else {
            return 0
        }
        var grid = grid
        let lineCount = grid.count
        let columnCount = firstLine.count
        for line in 0 ..< lineCount {
            for column in 0 ..< columnCount {
                if line == 0, column == 0 {
                    continue
                } else if line == 0 {
                    // 先获取当前格子的值
                    let val = grid[line][column]
                    // 第一行的所有格子都只能来自于它左边, 所以可以推算出到达每个格子的步数
                    grid[line][column] = val + grid[line][column - 1]
                } else if column == 0 {
                    // 先获取当前格子的值
                    let val = grid[line][column]
                    // 第一列的所有格子都只能来自于它上面, 所以可以推算出到达第一列每个格子的步数
                    grid[line][column] = val + grid[line - 1][column]
                } else {
                    // 先获取当前格子的值
                    let val = grid[line][column]
                    // 对于不是第第一行和第一列的格子, 它只能来自于左边或上面更小的那个格子
                    let above = grid[line - 1][column]
                    let left = grid[line][column - 1]
                    grid[line][column] = val + min(above, left)
                }
            }
        }
        return grid[lineCount - 1][columnCount - 1]
    }
    
    /*
     198. 打家劫舍
     你是一个专业的小偷，计划偷窃沿街的房屋。每间房内都藏有一定的现金，影响你偷窃的唯一制约因素就是相邻的房屋装有相互连通的防盗系统，如果两间相邻的房屋在同一晚上被小偷闯入，系统会自动报警。

     给定一个代表每个房屋存放金额的非负整数数组，计算你 不触动警报装置的情况下 ，一夜之内能够偷窃到的最高金额。

      

     示例 1：

     输入：[1,2,3,1]
     输出：4
     解释：偷窃 1 号房屋 (金额 = 1) ，然后偷窃 3 号房屋 (金额 = 3)。
          偷窃到的最高金额 = 1 + 3 = 4 。
     示例 2：

     输入：[2,7,9,3,1]
     输出：12
     解释：偷窃 1 号房屋 (金额 = 2), 偷窃 3 号房屋 (金额 = 9)，接着偷窃 5 号房屋 (金额 = 1)。
          偷窃到的最高金额 = 2 + 9 + 1 = 12 。
     */
    func rob(_ nums: [Int]) -> Int {
        guard nums.count > 1 else {
            return nums[0]
        }
        guard nums.count > 2 else {
            return max(nums[0], nums[1])
        }
        var nums = nums
        // 用num[i]标识偷前i家最高能获得多少钱
        for index in 0 ..< nums.count {
            if index == 0 {
                continue
            } else if index == 1 {
                nums[index] = max(nums[0], nums[1])
            } else {
                // 当前房屋价值
                let val = nums[index]
                // 选择偷这家和上上家, 或是不投这家改偷上一家
                nums[index] = max(val + nums[index - 2], nums[index - 1])
            }
        }
        return nums.last!
    }
    
    /*
     221. 最大正方形
     在一个由 '0' 和 '1' 组成的二维矩阵内，找到只包含 '1' 的最大正方形，并返回其面积。

     示例 1：

     输入：matrix = [["1","0","1","0","0"],["1","0","1","1","1"],["1","1","1","1","1"],["1","0","0","1","0"]]
     输出：4
     示例 2：

     输入：matrix = [["0","1"],["1","0"]]
     输出：1

     */
    func maximalSquare(_ matrix: [[Character]]) -> Int {
        guard matrix.count > 0, let firstLine = matrix.first, firstLine.count > 0 else {
            return 0
        }
        var result = 0
        let lineCount = matrix.count
        let columCount = firstLine.count
        var dpMatrix = Array(repeating: Array(repeating: 0, count: columCount), count: lineCount)
        for line in 0 ..< lineCount {
            for column in 0 ..< columCount {
                guard matrix[line][column] == "1" else {
                    // 当前格子不是1则最大边长必然为0， 因为构不成正方形了
                    continue
                }
                if line == 0 || column == 0 {
                    // 首行或首列， 最大面积只能是1
                    dpMatrix[line][column] = 1
                } else {
                    // 非首行首列， 最大边长是左边， 上边， 左上三个格子之间的最小值+1
                    let min1 = min(dpMatrix[line - 1][column - 1], dpMatrix[line][column - 1])
                    let min2 = min(min1, dpMatrix[line - 1][column])
                    dpMatrix[line][column] = min2 + 1
                }
                // 每次更新各自都更新最大边长
                result = max(result, dpMatrix[line][column])
            }
        }
        // 计算体积
        return result * result
    }
    
    /*
     300.最长递增子序列
     给你一个整数数组 nums ，找到其中最长严格递增子序列的长度。

     子序列 是由数组派生而来的序列，删除（或不删除）数组中的元素而不改变其余元素的顺序。例如，[3,6,2,7] 是数组 [0,3,1,6,2,2,7] 的
     子序列
     。

      
     示例 1：

     输入：nums = [10,9,2,5,3,7,101,18]
     输出：4
     解释：最长递增子序列是 [2,3,7,101]，因此长度为 4 。
     示例 2：

     输入：nums = [0,1,0,3,2,3]
     输出：4
     示例 3：

     输入：nums = [7,7,7,7,7,7,7]
     输出：1

     */
    func lengthOfLIS(_ nums: [Int]) -> Int {
        guard nums.count > 1 else {
            return nums.count
        }
        // 动态规划数组，表示以i个数字结尾的最长子序列
        var dp = Array(repeating: 1, count: nums.count)
        var result = 1
        dp[0] = 1
        for index in 1 ..< nums.count {
            // 如果当前遍历数前面有某个数是小于当前数的， 说明删除中间的数这个子序列仍然是递增的， 可以叠加， 否则就是1
            for j in 0 ..< index {
                if nums[index] > nums[j] {
                    dp[index] = max(dp[index], dp[j] + 1)
                }
            }
            result = max(result, dp[index])
        }
        return result
    }
}

DynamicProgramming().minPathSum([[1,3,1],[1,5,1],[4,2,1]])
