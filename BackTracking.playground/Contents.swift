import Cocoa

extension String {
    var isPalindrome: Bool {
        let sampleString = self.lowercased()
        let sArray = Array(sampleString)
        var leftIndex = 0
        var rightIndex = sArray.count - 1
        
        while (leftIndex < rightIndex) {
            if (!sArray[leftIndex].isNumber && !sArray[leftIndex].isLetter || sArray[leftIndex].isWhitespace) {
                leftIndex += 1
            } else if (!sArray[rightIndex].isNumber && !sArray[rightIndex].isLetter || sArray[rightIndex].isWhitespace) {
                rightIndex -= 1
            } else if (sArray[leftIndex] != sArray[rightIndex]) {
                return false
            } else {
                rightIndex -= 1
                leftIndex += 1
            }
        }
        return true
    }
}

extension [Int] {
    func quickSort() -> [Int] {
        var sortedArray = Array(self)
        quickSortInternal(results: &sortedArray, high: sortedArray.count - 1, low: 0)
        return sortedArray
    }
    
    func quickSortInternal(results: inout [Int], high: Int, low: Int) {
        guard high >= low else {
            return
        }
        var tempHigh = high
        var tempLow = low
        let baseValue = results[tempLow]
        while tempHigh > tempLow {
            while tempHigh > tempLow && results[tempHigh] >= baseValue {
                tempHigh -= 1
            }
            if tempHigh > tempLow {
                results[tempLow] = results[tempHigh]
            }
            while tempHigh > tempLow && results[tempLow] <= baseValue {
                tempLow += 1
            }
            if tempHigh > tempLow {
                results[tempHigh] = results[tempLow]
            }
        }
        results[tempLow] = baseValue
        quickSortInternal(results: &results, high: tempHigh - 1, low: low)
        quickSortInternal(results: &results, high: high, low: tempHigh + 1)
    }
}

class BackTrackingSolutions {
    // 给定两个整数 n 和 k，返回范围 [1, n] 中所有可能的 k 个数的组合。 你可以按 任何顺序 返回答案.
    func combine(_ n: Int, _ k: Int) -> [[Int]] {
        var result = [[Int]]()
        var firstPath = [Int]()
        var tempArray = [Int](1...n)
        combineBackTrack(results: &result, numbers: &firstPath, startIndex: 0, tempArray: &tempArray, length: k)
        return result
    }
    
    func combineBackTrack(results: inout [[Int]], numbers: inout [Int], startIndex: Int, tempArray: inout [Int], length: Int) {
        // 设置终止条件
        guard numbers.count < length else {
            let newPath = Array(numbers)
            // 收集本次递归的结果
            results.append(newPath)
            return
        }
        // 构造用于查询的数组
        for (index, value) in tempArray.enumerated() {
            // 从startIndex的后一个值开始填充临时数组
            if (index < startIndex) {
                continue
            }
            // 剪枝操作, 减少不必要的循环次数
            if (index > tempArray.count - (length - numbers.count)) {
                break;
            }
            // 将元素加入临时数组
            numbers.append(value)
            // 递归调用, 查询下一层的叶子节点
            combineBackTrack(results: &results, numbers: &numbers, startIndex: index + 1, tempArray: &tempArray, length: length)
            // 递归完毕后, 执行回溯, 将本层递归改变的临时数组还原
            numbers.removeLast()
        }
    }
    
    /*
     找出所有相加之和为 n 的 k 个数的组合，且满足下列条件：

     只使用数字1到9
     每个数字 最多使用一次
     返回 所有可能的有效组合的列表 。该列表不能包含相同的组合两次，组合可以以任何顺序返回。

     来源：力扣（LeetCode）
     链接：https://leetcode.cn/problems/combination-sum-iii
     著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
     */
    func combinationSum3(_ k: Int, _ n: Int) -> [[Int]] {
        var result = [[Int]]()
        var path = [Int]()
        let elements = [Int](1...9)
        combinationSumBacktrack(output: &result, path: &path, startIndex: 0, elements: elements, target: n, length: k)
        return result
    }
    
    func combinationSumBacktrack(output: inout [[Int]], path: inout [Int], startIndex: Int, elements: [Int], target: Int, length: Int) {
        // 确定停止递归的条件, path.count < length
        guard path.count < length else {
            // 收集path
            if (integerArraySum(path) == target) {
                let combination = Array(path)
                output.append(combination)
            }
            return
        }
        for (index, value) in elements.enumerated() {
            // 因为是正序遍历, 小于index的都肯定遍历过了, 求组合所以可以忽略掉前面用过的index
            if (index < startIndex) {
                continue
            }
            // 剪枝操作, 当剩余元素个数无法满足path长度要求的时候没有递归的必要了
            if (index > elements.count - (length - path.count)) {
                break
            }
            // 如果数组和已经大约target了, 后面就没必要再遍历了, 这里属于剪枝操作
            if (integerArraySum(path) +  value > target) {
                break
            }
            // 记录path新的节点
            path.append(value)
            combinationSumBacktrack(output: &output, path: &path, startIndex: index + 1, elements: elements, target: target, length: length)
            // 回溯操作, 当本次递归结束, 去除当前节点, 返回到上一个节点继续递归
            path.removeLast()
        }
    }
    
    func integerArraySum(_ array:[Int]) -> Int {
        var sum = 0
        
        for value in array {
            sum += value
        }
        
        return sum
    }
    
    /*
     给定一个仅包含数字 2-9 的字符串，返回所有它能表示的字母组合。答案可以按 任意顺序 返回。

     给出数字到字母的映射如下（与电话按键相同）。注意 1 不对应任何字母。

     来源：力扣（LeetCode）
     链接：https://leetcode.cn/problems/letter-combinations-of-a-phone-number
     著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
     */
    
    func letterCombinations(_ digits: String) -> [String] {
        var result = [String]()
        var path = ""
        letterCombinationBacktrack(output: &result, path: &path, input: digits)
        return result;
    }
    
    static let phoneNumberToAlphabetMap = ["", "", "abc", "def", "ghi", "jkl", "mno", "pqrs", "tuv", "wxyz"]
    
    func letterCombinationBacktrack(output: inout [String], path: inout String, input: String) {
        // 确定递归终止条件, 输入长度==输出长度
        guard path.count < input.count else {
            if (path.count > 0) {
                output.append(path)
            }
            return
        }
        // 获取当前需要遍历的集合的下标
        let num = input[input.index(input.startIndex, offsetBy: path.count)]
        guard let number = num.wholeNumberValue else {
            return
        }
        // 获取当前需要遍历的集合
        let elements: String = BackTrackingSolutions.phoneNumberToAlphabetMap[number]
        for (_, value) in elements.enumerated() {
            // 添加路径
            path.append(value)
            // 向下一层递归
            letterCombinationBacktrack(output: &output, path: &path, input: input)
            // 结果回溯
            path.removeLast()
        }
    }
    
    /*
     给定一个候选人编号的集合 candidates 和一个目标数 target ，找出 candidates 中所有可以使数字和为 target 的组合。

     candidates 中的每个数字在每个组合中只能使用 一次 。

     注意：解集不能包含重复的组合。

     来源：力扣（LeetCode）
     链接：https://leetcode.cn/problems/combination-sum-ii
     著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
     */
    func combinationSum2(_ candidates: [Int], _ target: Int) -> [[Int]] {
        var result = [[Int]]()
        var path = [Int]()
        let sortedCandidates = candidates.quickSort()
        var used = Array(repeating: 0, count: candidates.count)
        combinationSum2BackTrack(result: &result, path: &path, target: target, candidates: sortedCandidates, startIndex: 0, used: &used)
        return result
    }
        
    func combinationSum2BackTrack(result: inout [[Int]], path: inout [Int], target: Int, candidates:[Int], startIndex: Int, used: inout [Int]) {
        // 确定递归终止条件, 当path的元素和等于target, 结束递归
        let sum = integerArraySum(path)
        guard sum < target else {
            if sum == target {
                result.append(path)
            }
            return
        }
        // 编写循环
        for (index, value) in candidates.enumerated() {
            // 使用startIndex确保递归的时候不会把前面用过的元素放进path
            if (index < startIndex) {
                continue
            }
            if (index >= 1) {
                // 关键点, 去重, 首先要对素材数组进行排序, 然后按顺序遍历素材数组时, 可以看出前一个元素的所有排列组合必然包含了后部的排列组合, 因此要在这里筛选掉, 判断依据是两个相同值的元素, 那么后一个的所有组合可能必然已经被前一个元素发掘过了, 加入used数组时避免在递归的中间遇到这种情况, 因为递归时是可以把相同值的两个元素放入path的
                if (value == candidates[index - 1] && used[index - 1] == 0) {
                    // value和前一个相等代表这两个元素有相同的结果集, used == 0 是用于排除这是在一次递归内的情况
                    continue
                }
            }
            path.append(value)
            used[index] = 1
            combinationSum2BackTrack(result: &result, path:&path, target: target, candidates: candidates, startIndex: index + 1,  used: &used)
            path.removeLast()
            used[index] = 0
        }
    }
    
    /*
     给你一个 无重复元素 的整数数组 candidates 和一个目标整数 target ，找出 candidates 中可以使数字和为目标数 target 的 所有 不同组合 ，并以列表形式返回。你可以按 任意顺序 返回这些组合。

     candidates 中的 同一个 数字可以 无限制重复被选取 。如果至少一个数字的被选数量不同，则两种组合是不同的。

     对于给定的输入，保证和为 target 的不同组合数少于 150 个。

      

     来源：力扣（LeetCode）
     链接：https://leetcode.cn/problems/combination-sum
     著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
     
     */
    
    func combinationSum(_ candidates: [Int], _ target: Int) -> [[Int]] {
        var result = [[Int]]()
        var path = [Int]()
        var sum = 0
        let sortedCandidate = candidates.quickSort()
        combinationSumBackTrack(result: &result, path: &path, candidates: sortedCandidate, target: target, sum: &sum, startIndex: 0)
        return result
    }
    
    func combinationSumBackTrack(result: inout [[Int]], path: inout [Int], candidates: [Int],  target: Int, sum: inout Int, startIndex: Int) {
        guard sum < target else {
            if (sum == target) {
                result.append(path)
            }
            return
        }
        for (index,value) in candidates.enumerated() {
            if (index < startIndex) {
                continue
            }
            // 剪枝操作, 如果入参是经过排序的数组, 此时往后的元素组合都是超出target需要的, 可以直接退出循环
            if sum + value > target {
                break
            }
            sum += value
            path.append(value)
            combinationSumBackTrack(result: &result, path: &path, candidates: candidates, target: target, sum: &sum, startIndex: index)
            path.removeLast()
            sum -= value
        }
    }
    
    /*
     给你一个整数数组 nums ，数组中的元素 互不相同 。返回该数组所有可能的子集（幂集）。

     解集 不能 包含重复的子集。你可以按 任意顺序 返回解集。
     */
    
    func subsetsBackTracking(nums: [Int], results: inout [[Int]], path: inout [Int], startIndex: Int) {
        // 收集path当前状态到结果集
        results.append(path)
        // 确定递归终止条件: startIndex >= nums.size, 表示已经没有剩余可选元素
        guard startIndex < nums.count else {
            return
        }
        // 遍历数组
        for (index, value) in nums.enumerated() {
            guard index >= startIndex else {
                continue
            }
            // 生成一个结果元素
            path.append(value)
            // 递归, 不重复选择, 因此startIndex = index + 1
            subsetsBackTracking(nums: nums, results: &results, path: &path, startIndex: index + 1)
            // 回溯, 将path新添加的元素pop
            path.removeLast()
        }
    }
    
    func subsets(_ nums: [Int]) -> [[Int]] {
        var results = [[Int]]()
        var path = [Int]()
        subsetsBackTracking(nums: nums, results: &results, path: &path, startIndex: 0)
        return results
    }
    
    func subsetsWithDup(_ nums: [Int]) -> [[Int]] {
        var results = [[Int]]()
        var path = [Int]()
        var used = Array(repeating: 0, count: nums.count)
        let sortedNums = nums.quickSort()
        subsetsWithDupBackTracking(nums: sortedNums, results: &results, path: &path, startIndex: 0, used: &used)
        return results
    }
    
    func subsetsWithDupBackTracking(nums: [Int], results: inout [[Int]], path: inout [Int], startIndex: Int, used: inout [Int]) {
        // 收集path当前状态到结果集
        results.append(path)
        // 确定递归终止条件: startIndex >= nums.size, 表示已经没有剩余可选元素
        guard startIndex < nums.count else {
            return
        }
        // 遍历数组
        for (index, value) in nums.enumerated() {
            guard index >= startIndex else {
                continue
            }
            if index >= 1 {
                // 关键点, 去重, 首先要对素材数组进行排序, 然后按顺序遍历素材数组时, 可以看出前一个元素的所有排列组合必然包含了后部的排列组合, 因此要在这里筛选掉, 判断依据是两个相同值的元素, 那么后一个的所有组合可能必然已经被前一个元素发掘过了, 加入used数组时避免在递归的中间遇到这种情况, 因为递归时是可以把相同值的两个元素放入path的
                if (value == nums[index - 1] && used[index - 1] == 0) {
                    // value和前一个相等代表这两个元素有相同的结果集, used == 0 是用于排除这是在一次递归内的情况
                    continue
                }
            }
            // 生成一个结果元素
            path.append(value)
            // 标记该元素已经被使用
            used[index] = 1
            // 递归, 不重复选择, 因此startIndex = index + 1
            subsetsWithDupBackTracking(nums: nums, results: &results, path: &path, startIndex: index + 1, used: &used)
            // 回溯, 将path新添加的元素pop
            path.removeLast()
            // 回溯元素使用情况
            used[index] = 0
        }
    }
    /*
     给你一个整数数组 nums ，找出并返回所有该数组中不同的递增子序列，递增子序列中 至少有两个元素 。你可以按 任意顺序 返回答案。
     数组中可能含有重复元素，如出现两个整数相等，也可以视作递增序列的一种特殊情况。
     */
    func findSubsequences(_ nums: [Int]) -> [[Int]] {
        // 首先这道题不能对序列排序, 因为排序会改变序列的相对位置, 不符合子序列的定义
        var results = [[Int]]()
        var path = [Int]()
        findSubsequencesBacktracking(results: &results, path: &path, nums: nums, startIndex: 0)
        return results
    }
    
    func findSubsequencesBacktracking(results: inout [[Int]], path: inout [Int], nums: [Int], startIndex: Int) {
        // 收集path当前状态到结果集, 条件, 子序列元素个数大于1
        if (path.count > 1) {
            results.append(path)
        }
        // 确定终止条件, 序列遍历完毕
        guard startIndex < nums.count else {
            return
        }
        var used = Set<Int>()
        for (index, value) in nums.enumerated() {
            guard index >= startIndex else {
                continue
            }
            guard used.contains(value) == false else {
                continue
            }
            var isAppended = false
            if let previousValue = path.last {
                if value >= previousValue {
                    isAppended = true
                }
            } else {
                isAppended = true
            }
            if isAppended {
                path.append(value)
                used.insert(value)
                findSubsequencesBacktracking(results: &results, path: &path, nums: nums, startIndex: index + 1)
                path.removeLast()
            }
        }
    }
    
    /*
     给定一个不含重复数字的数组 nums ，返回其 所有可能的全排列 。你可以 按任意顺序 返回答案。
     */
    func permute(_ nums: [Int]) -> [[Int]] {
        var results = [[Int]]()
        var path = [Int]()
        var used = Array(repeating: 0, count: nums.count)
        permuteBacktracking(results: &results, path: &path, nums: nums, used: &used)
        return results
    }
    
    func permuteBacktracking(results: inout [[Int]], path: inout [Int], nums: [Int], used: inout [Int]) {
        if path.count == nums.count {
            results.append(path)
        }
        for (index, value) in nums.enumerated() {
            if used[index] == 1 {
                continue
            }
            path.append(value)
            used[index] = 1
            permuteBacktracking(results: &results, path: &path, nums: nums, used: &used)
            path.removeLast()
            used[index] = 0
        }
    }
    
    
    /*
     给定一个可包含重复数字的序列 nums ，按任意顺序 返回所有不重复的全排列。
     */
    func permuteUnique(_ nums: [Int]) -> [[Int]] {
        var results = [[Int]]()
        var path = [Int]()
        var used = Array(repeating: 0, count: nums.count)
        var sortedNums = nums.quickSort()
        permuteUniqueBacktracking(results: &results, path: &path, nums: sortedNums, used: &used)
        return results
    }
    
    func permuteUniqueBacktracking(results: inout [[Int]], path: inout [Int], nums: [Int], used: inout [Int]) {
        if path.count == nums.count {
            results.append(path)
        }
        for (index, value) in nums.enumerated() {
            if used[index] == 1 {
                continue
            }
            if index > 0 {
                if value == nums[index - 1] && used[index - 1] == 0 {
                    continue
                }
            }
            path.append(value)
            used[index] = 1
            permuteUniqueBacktracking(results: &results, path: &path, nums: nums, used: &used)
            path.removeLast()
            used[index] = 0
        }
    }
    
    /*
     按照国际象棋的规则，皇后可以攻击与之处在同一行或同一列或同一斜线上的棋子。

     n 皇后问题 研究的是如何将 n 个皇后放置在 n×n 的棋盘上，并且使皇后彼此之间不能相互攻击。

     给你一个整数 n ，返回所有不同的 n 皇后问题 的解决方案。

     每一种解法包含一个不同的 n 皇后问题 的棋子放置方案，该方案中 'Q' 和 '.' 分别代表了皇后和空位。
     */
    
    func solveNQueens(_ n: Int) -> [[String]] {
        var result = [[String]]()
        var chess = [String]()
        for _ in 0 ..< n {
            let rowContent = String(repeating: Character("."), count: n)
            chess.append(rowContent)
        }
        solveNQueenBacktracking(result: &result, chess: &chess, size: n, row: 0)
        return result
    }
    
    func isValidQueenPosition(row: Int, colum: Int, chess: [String], size: Int) -> Bool {
        var isValid = true
        // 找到目标所在行
        let chessRow = chess[row]
        for (_, character) in chessRow.enumerated() {
            if character == Character("Q") {
                // 同一行里面不能有Q
                isValid = false
                break
            }
        }
        // 如果已经不合格了没必要继续检查
        guard isValid != false else {
            return isValid
        }
        // 检查棋盘的每一行
        for (_, singleChessRow) in chess.enumerated() {
            // 查询每一行的指定位置, 即相同列的位置是不是Q
            let position = singleChessRow.index(singleChessRow.startIndex, offsetBy: colum)
            if singleChessRow[position] == Character("Q") {
                // 同一列里面不能有Q
                isValid = false
                break
            }
        }
        // 如果已经不合格了没必要继续检查
        guard isValid != false else {
            return isValid
        }
        var tempRow = row
        var tempColum = colum
        while tempRow >= 0 && tempColum >= 0 {
            // print("45 degree row: \(tempRow) colum: \(tempColum) size: \(chess.count)")
            let chessRow = chess[tempRow]
            if chessRow[chessRow.index(chessRow.startIndex, offsetBy: tempColum)] == Character("Q") {
                // 左斜45°不能有Q
                isValid = false
                break;
            }
            tempRow -= 1
            tempColum -= 1
        }
        // 如果已经不合格了没必要继续检查
        guard isValid != false else {
            return isValid
        }
        var tempRow2 = row
        var tempColum2 = colum
        while tempRow2 >= 0 && tempColum2 < size {
            let chessRow = chess[tempRow2]
            // print("135 degree row: \(tempRow2) colum: \(tempColum2) rowSize: \(chessRow.count)")
            if chessRow[chessRow.index(chessRow.startIndex, offsetBy: tempColum2)] == Character("Q") {
                // 右斜135°不能有Q
                isValid = false
                break;
            }
            tempRow2 -= 1
            tempColum2 += 1
        }
        return isValid
    }
    
    func solveNQueenBacktracking(result: inout [[String]], chess: inout [String], size: Int, row: Int) {
        guard row < size else {
            result.append(chess)
            return
        }
        // 针对每一行, 遍历改行每个列位置i是否能放置皇后
        for colum in 0 ..< size {
            if isValidQueenPosition(row: row, colum: colum, chess: chess, size: size) {
                var chessRow = chess[row]
                let queen = Character("Q")
                let point = chessRow.index(chessRow.startIndex, offsetBy: colum)
                chessRow.remove(at: point)
                chessRow.insert(queen, at: point)
                chess[row] = chessRow
                solveNQueenBacktracking(result: &result, chess: &chess, size: size, row: row + 1)
                let dot = Character(".")
                chessRow.remove(at: point)
                chessRow.insert(dot, at: point)
                chess[row] = chessRow
            }
        }
    }
    
    /*
     有效 IP 地址 正好由四个整数（每个整数位于 0 到 255 之间组成，且不能含有前导 0），整数之间用 '.' 分隔。

     例如："0.1.2.201" 和 "192.168.1.1" 是 有效 IP 地址，但是 "0.011.255.245"、"192.168.1.312" 和 "192.168@1.1" 是 无效 IP 地址。
     给定一个只包含数字的字符串 s ，用以表示一个 IP 地址，返回所有可能的有效 IP 地址，这些地址可以通过在 s 中插入 '.' 来形成。你 不能 重新排序或删除 s 中的任何数字。你可以按 任何 顺序返回答案。

     来源：力扣（LeetCode）
     链接：https://leetcode.cn/problems/restore-ip-addresses
     著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
     */
    
    func isValidIpComponent(component: String) -> Bool {
        guard component.count > 0 else {
            print("component: \(component), result1:false")
            return false
        }
        guard component.count < 4 else {
            print("component: \(component), result2:false")
            return false
        }
        if component.count == 1 {
            let isNumber = component[component.startIndex].isNumber
            print("component: \(component), result3:\(isNumber)")
            return isNumber
        }
        if component.count == 2 {
            let regex = "[1-9][0-9]"
            let range = component.range(of: regex, options: .regularExpression)
            let decision = range != nil
            print("component: \(component), result5:\(decision)")
            return decision
        }
        let regex = "25[0-5]|2[0-4][0-9]|1[0-9]{2}"
        let range = component.range(of: regex, options: .regularExpression)
        let decision = range != nil
        print("component: \(component), result6:\(decision)")
        return decision
    }
    
    func isValidIpAddress(address: String, startIndex: Int, endIndex: Int) -> (isValid: Bool, subString: String) {
        let startStringIndex = address.index(address.startIndex, offsetBy: startIndex)
        let endStringIndex = address.index(address.startIndex, offsetBy: endIndex)
        let subString = String(address[startStringIndex ... endStringIndex])
        let isValid = isValidIpComponent(component: subString)
        return (isValid, subString)
    }
    
    func restoreIpAddressBackTracking(result: inout [String], path: inout String, input: String, dotCount: inout Int, startIndex: Int) {
        guard input.count > startIndex else  {
            return
        }
        // 收集结果, 当有三个点的时候, 就没必要继续递归了
        guard dotCount < 3 else {
            // 根据startIndex取出最后一段子串, 判断ip
            let finalSubString = isValidIpAddress(address: input, startIndex: startIndex, endIndex: input.count - 1)
            if (finalSubString.isValid) {
                // 最后一段也是合法的, 那么收集结果
                let singleResult = String("\(path)\(finalSubString.subString)")
                result.append(singleResult)
            }
            return
        }
        for (index, _) in input.enumerated() {
            // 遍历整个字符串, 递归时不允许重复遍历自身, 用startIndex标记
            guard index >= startIndex else {
                continue
            }
            // 判断当前切割的子串是否符合ip地址的组成部分
            // print("dot: \(dotCount), startIndex:\(startIndex), index: \(index), path: \(path)")
            let validRet = isValidIpAddress(address: input, startIndex: startIndex, endIndex: index)
            // 不符合没必要递归, 下一个
            guard validRet.isValid else {
                continue
            }
            // 符合, 需要继续递归, dot数+1
            dotCount = dotCount + 1
            // path拼接临时结果是子串加.
            let tempLastIndex = path.endIndex
            let appendComponent = String("\(validRet.subString).")
            // 更新进展
            path.append(appendComponent)
            // 递归到下一层
            restoreIpAddressBackTracking(result: &result, path: &path, input: input, dotCount: &dotCount, startIndex: index + 1)
            // 回溯
            path.removeLast(appendComponent.count)
            dotCount = dotCount - 1
        }
    }
    
    func restoreIpAddresses(_ s: String) -> [String] {
        var result = [String]()
        var path: String = String()
        var dotCount = 0
        restoreIpAddressBackTracking(result: &result, path: &path, input: s, dotCount: &dotCount, startIndex: 0)
        return result
    }
    
    /*
     给你一个字符串 s，请你将 s 分割成一些子串，使每个子串都是 回文串 。返回 s 所有可能的分割方案。

     回文串 是正着读和反着读都一样的字符串。
     */
    func partition(_ s: String) -> [[String]] {
        var result = [[String]]()
        var path = [String]()
        splitReversableString(result: &result, path: &path, input: s, startIndex: 0)
        return result
    }
    
    // input = aab
    // startIndex = 0, index = 0 |a|
    // startIndex = 0, index = 1 |aa|
    // startIndex = 0, index = 2 |aab|
    // startIndex = 1, index = 1 |a|
    // startIndex = 1, index = 2 |ab|
    // startIndex = 2, index = 2 |b|
    func isPalindromeWithSplitIndexs(input: String, startIndex: Int, endIndex: Int) -> (isPalindrome: Bool, subString: String) {
        let startStringIndex = input.index(input.startIndex, offsetBy: startIndex)
        let endStringIndex = input.index(input.startIndex, offsetBy: endIndex)
        let subString = String(input[startStringIndex ... endStringIndex])
        let isPalindrome = subString.isPalindrome
        return (isPalindrome, subString)
    }
    
    func splitReversableString(result: inout [[String]], path: inout [String], input: String, startIndex: Int) {
        // 递归结束条件, startIndex的起始下标走完了整个字符串
        guard startIndex < input.count else {
            // 只允许是回文字符串的结果走进递归, 因此这里直接收集结果即可
            result.append(path)
            return
        }
        for (index, _) in input.enumerated() {
            if index < startIndex {
                continue
            }
            // 注意切割字符串的位置不能搞错, 当index和startIndex相同时, 切的就是哪一个位置的字符
            let isPalindromeResult = isPalindromeWithSplitIndexs(input: input, startIndex: startIndex, endIndex: index)
            if isPalindromeResult.isPalindrome {
                path.append(isPalindromeResult.subString)
                splitReversableString(result: &result, path: &path, input: input, startIndex: index + 1)
                path.removeLast()
            } else {
                continue
            }
        }
    }
    
    
    /*
     给你一个正整数数组 nums，请你移除 最短 子数组（可以为 空），使得剩余元素的 和 能被 p 整除。 不允许 将整个数组都移除。

     请你返回你需要移除的最短子数组的长度，如果无法满足题目要求，返回 -1 。

     子数组 定义为原数组中连续的一组元素。

      

     示例 1：

     输入：nums = [3,1,4,2], p = 6
     输出：1
     解释：nums 中元素和为 10，不能被 p 整除。我们可以移除子数组 [4] ，剩余元素的和为 6 。
     示例 2：

     输入：nums = [6,3,5,2], p = 9
     输出：2
     解释：我们无法移除任何一个元素使得和被 9 整除，最优方案是移除子数组 [5,2] ，剩余元素为 [6,3]，和为 9 。
     示例 3：

     输入：nums = [1,2,3], p = 3
     输出：0
     解释：和恰好为 6 ，已经能被 3 整除了。所以我们不需要移除任何元素。
     示例  4：

     输入：nums = [1,2,3], p = 7
     输出：-1
     解释：没有任何方案使得移除子数组后剩余元素的和被 7 整除。

     来源：力扣（LeetCode）
     链接：https://leetcode.cn/problems/make-sum-divisible-by-p
     著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
     */
    func minSubarray(_ nums: [Int], _ p: Int) -> Int {
        var length = -1
        var path = [Int]()
        minSubArrayBackTracking(nums, &path, &length, 0, p)
        return length
    }
    
    func minSubArrayBackTracking(_ nums: [Int], _ path: inout [Int], _ result: inout Int, _ startIndex: Int, _ target: Int) {
        let sum = path.reduce(0, {$0 + $1})
        if path.count > 0 && sum % target == 0 {
            print("path: \(path), sum: \(sum)")
            // 计算子数组满足结果的时候应该删除多少个元素
            let tempResult = nums.count - path.count
            // 替换当前值
            if result == -1 {
                result = tempResult
            } else {
                result = Swift.min(result, tempResult)
            }
        }
        for (index, value) in nums.enumerated() {
            guard index >= startIndex else {
                continue
            }
            path.append(value)
            minSubArrayBackTracking(nums, &path, &result, index + 1, target)
            path.removeLast()
        }
    }
}

BackTrackingSolutions().minSubarray([3, 6, 8, 1], 8)

