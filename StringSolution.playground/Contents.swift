import Cocoa

extension String {
    // 求取前缀表
    var nextPrefix: [Int] {
        let characters = Array(self)
        var result = [Int](repeating: 0, count: characters.count)
        var prefixEnd = 0, suffixEnd = 1
        while suffixEnd < characters.count {
            while prefixEnd > 0 && characters[prefixEnd] != characters[suffixEnd] {
                prefixEnd = result[prefixEnd - 1]
            }
            if characters[prefixEnd] == characters[suffixEnd] {
                prefixEnd += 1
                result[suffixEnd] = prefixEnd
            }
            suffixEnd += 1
        }
        return result
    }
    
    var kmpArray: [Int] {
        var result = [Int](repeating: 0, count: self.count)
        let characters = Array(self)
        var prefixEnd = 0, suffixEnd = 1
        while suffixEnd  < characters.count {
            while prefixEnd > 0 && characters[prefixEnd] != characters[suffixEnd] {
                prefixEnd = result[prefixEnd - 1]
            }
            if characters[prefixEnd] == characters[suffixEnd] {
                prefixEnd += 1
                result[suffixEnd]  = prefixEnd
            }
            suffixEnd += 1
        }
        return result
    }
    
    var kmpNext: [Int] {
        let characters = Array(self)
        var result = [Int](repeating: 0, count: characters.count)
        var prefixEnd = 0, suffixEnd = 1
        while suffixEnd < characters.count {
            while prefixEnd > 0 && characters[prefixEnd] != characters[suffixEnd] {
                prefixEnd = result[prefixEnd - 1]
            }
            if characters[prefixEnd] == characters[suffixEnd] {
                prefixEnd += 1
                result[suffixEnd] = prefixEnd
            }
            suffixEnd += 1
        }
        return result
    }
}

class StringSolution {
    
    /*
     给定一个字符串 s 和一个整数 k，从字符串开头算起，每计数至 2k 个字符，就反转这 2k 字符中的前 k 个字符。

     如果剩余字符少于 k 个，则将剩余字符全部反转。
     如果剩余字符小于 2k 但大于或等于 k 个，则反转前 k 个字符，其余字符保持原样。
      

     示例 1：

     输入：s = "abcdefg", k = 2
     输出："bacdfeg"
     示例 2：

     输入：s = "abcd", k = 2
     输出："bacd"
      

     提示：



     来源：力扣（LeetCode）
     链接：https://leetcode.cn/problems/reverse-string-ii
     著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
     */
    
    func reverseStr(_ s: String, _ k: Int) -> String {
        guard k > 1 else {
            return s
        }
        var startIndex = 0
        var tempString = s
        // 因为2k的翻转是正常规则, 遍历的时候按照2k为单位遍历
        while startIndex < s.count {
            // 计算剩余长度
            let leftSize = s.count - startIndex
            // 看题目发现, 无论剩余长度是k还是2k, 处理是一样的, 这里只用一个判断
            if leftSize >= k {
                tempString = reversedString(tempString, startIndex, k)
            }
            // 剩余长度不足k的时候有特殊逻辑
            if leftSize < k {
                tempString = reversedString(tempString, startIndex, leftSize)
            }
            // 下一轮遍历
            startIndex += 2 * k
        }
        return tempString
    }
    
    func reversedString(_ string: String, _ startIndex: Int, _ size: Int) -> String {
        var characters: [Character] = Array(string)
        var left = startIndex
        var right = startIndex + (size  - 1)
        while left < right {
            let tempChara = characters[left]
            characters[left] = characters[right]
            characters[right] = tempChara
            left += 1
            right -= 1
        }
        return String(characters)
    }
    
    func reverseString(_ string: inout [Character], _ startIndex: Int, _ endIndex: Int) {
        var left = startIndex
        var right = endIndex
        while left < right {
            let tempChara = string[left]
            string[left] = string[right]
            string[right] = tempChara
            left += 1
            right -= 1
        }
    }
    
    /*
     给你一个字符串 s ，请你反转字符串中 单词 的顺序。

     单词 是由非空格字符组成的字符串。s 中使用至少一个空格将字符串中的 单词 分隔开。

     返回 单词 顺序颠倒且 单词 之间用单个空格连接的结果字符串。

     注意：输入字符串 s中可能会存在前导空格、尾随空格或者单词间的多个空格。返回的结果字符串中，单词间应当仅用单个空格分隔，且不包含任何额外的空格。

      

     示例 1：

     输入：s = "the sky is blue"
     输出："blue is sky the"

     来源：力扣（LeetCode）
     链接：https://leetcode.cn/problems/reverse-words-in-a-string
     著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
     */
    func reverseWords(_ s: String) -> String {
        // 这题分三步： 1.反转整个字符串 2.识别出多余的空格并删除 3.用空格判断单词的区间并反转单词部分
        // 1. 直接翻转整个字符串
        var reversedString = Array(s.reversed())
        // 2. 识别并删除多余空格
        spaceRemove(&reversedString)
        // 3. 分割出单词并单独翻转
        var isWorld = false
        var wordStart = 0
        var wordEnd = 0
        for (index, character) in reversedString.enumerated() {
            // 设置单词分割线开始
            if !isWorld {
                wordStart = index
                isWorld = true
            }
            // 判断当前字符是空格，前一个字符不是，那么前一个字符就是单词的结尾
            if character == Character(" ") && reversedString[index - 1] != Character(" ") {
                wordEnd = index - 1
                isWorld = false
                // 根据单词分界线翻转单词部分
                reverseString(&reversedString, wordStart, wordEnd)
            }
            // 特殊情况，字符串最后一个字符肯定是单词结尾
            if index == reversedString.count - 1 && character != Character(" ") {
                wordEnd = index
                isWorld = false
                // 根据单词分界线翻转单词部分
                reverseString(&reversedString, wordStart, wordEnd)
            }
        }
        return String(reversedString)
    }
    
    func spaceRemove(_ input: inout [Character]) {
        var fast = 0
        var slow = 0
        
        while fast < input.count {
            var prefixSpace = false
            if fast + 1 < input.count {
                prefixSpace = input[fast + 1] != Character(" ") && slow != 0
            }
            if input[fast] != Character(" ") || prefixSpace {
                input[slow] = input[fast]
                slow += 1
            }
            fast += 1
        }
        input = Array(input[0 ..< slow])
    }
    
    /*
     给定一个非空的字符串 s ，检查是否可以通过由它的一个子串重复多次构成。

      

     示例 1:

     输入: s = "abab"
     输出: true
     解释: 可由子串 "ab" 重复两次构成。
     示例 2:

     输入: s = "aba"
     输出: false
     示例 3:

     输入: s = "abcabcabcabc"
     输出: true
     解释: 可由子串 "abc" 重复四次构成。 (或子串 "abcabc" 重复两次构成。)

     来源：力扣（LeetCode）
     链接：https://leetcode.cn/problems/repeated-substring-pattern
     著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
     */
    
    func repeatedSubstringPattern(_ s: String) -> Bool {
        // 获得前缀表
        let nextArray = s.nextPrefix
        // 前缀表的最后一位表示在全字符串纬度内出现的最长相等前后缀的长度
        let fullStringRepeatPatternLength = nextArray[s.count - 1]
        // 如果最长相等前后缀的长度为0，说明字符串时不重复的，返回false
        guard fullStringRepeatPatternLength > 0 else {
            return false
        }
        // 如果有最长相等前后缀，那么字符串长度减去这个长度就等于最短相等前后缀，通过字符串长度能否被这个长度整除就能判断出字符串是不是重复构成的
        return s.count % (s.count - fullStringRepeatPatternLength) == 0
    }
    
    /*
     给你两个二进制字符串 a 和 b ，以二进制字符串的形式返回它们的和。

      

     示例 1：

     输入:a = "11", b = "1"
     输出："100"
     示例 2：

     输入：a = "1010", b = "1011"
     输出："10101"
      

     来源：力扣（LeetCode）
     链接：https://leetcode.cn/problems/add-binary
     著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
     */
    func addBinary(_ a: String, _ b: String) -> String {
        var aNums = Array(a)
        var bNums = Array(b)
        // 补齐位数差距
        if aNums.count < bNums.count {
            let differ = bNums.count - aNums.count
            for _ in 0 ..< differ {
                aNums.insert("0", at: 0)
            }
        } else if aNums.count > bNums.count {
            let differ = aNums.count - bNums.count
            for _ in 0 ..< differ {
                bNums.insert("0", at: 0)
            }
        }
        // 从最后一位开始遍历计算
        var index = aNums.count - 1
        // 进位计数器
        var shouldProgress = 0
        while index >= 0 {
            let aNum = Int(String(aNums[index])) ?? 0
            let bNum = Int(String(bNums[index])) ?? 0
            // 获取进位 + 本位两个值的和
            let value = aNum + bNum + shouldProgress
            if value < 2 {
                // 无需进位，直赋值，进位计数器清零
                aNums[index] = Character(String(value))
                shouldProgress = 0
            } else {
                // 需要进位，取和与2的模
                aNums[index] = Character(String(value % 2))
                // 进位数是十进制值除以2取整，例如6在二进制里需要进位3次，虽然这正场景下最多只可能出现3
                shouldProgress = value / 2
            }
            index -= 1
        }
        // 根据进位计数器是否为0判断要不要在前面补一位
        if shouldProgress > 0  {
            aNums.insert("1", at: 0)
        }
        return String(aNums)
    }
    
    /*
     392. 判断子序列
     给定字符串 s 和 t ，判断 s 是否为 t 的子序列。

     字符串的一个子序列是原始字符串删除一些（也可以不删除）字符而不改变剩余字符相对位置形成的新字符串。（例如，"ace"是"abcde"的一个子序列，而"aec"不是）。

     进阶：

     如果有大量输入的 S，称作 S1, S2, ... , Sk 其中 k >= 10亿，你需要依次检查它们是否为 T 的子序列。在这种情况下，你会怎样改变代码？

     致谢：

     特别感谢 @pbrother 添加此问题并且创建所有测试用例。

      

     示例 1：

     输入：s = "abc", t = "ahbgdc"
     输出：true
     示例 2：

     输入：s = "axc", t = "ahbgdc"
     输出：false
     */
    func isSubsequence(_ s: String, _ t: String) -> Bool {
        guard s.count <= t.count else {
            return false
        }
        guard s.count > 0 else {
            return false
        }
        if s == t {
            return true
        }
        var result = false
        var slow = 0
        var fast = 0
        let charaArray = Array(t)
        let subArray = Array(s)
        while fast < charaArray.count, slow < subArray.count {
            let tempChara = charaArray[fast]
            if tempChara == subArray[slow] {
                slow += 1
            }
            fast += 1
        }
        result = slow == subArray.count
        return result
    }
    
    /*
     5. 最长回文子串
     给你一个字符串 s，找到 s 中最长的
     回文子串。

     示例 1：

     输入：s = "babad"
     输出："bab"
     解释："aba" 同样是符合题意的答案。
     示例 2：

     输入：s = "cbbd"
     输出："bb"
      

     提示：

     1 <= s.length <= 1000
     s 仅由数字和英文字母组成
     
     */
    func longestPalindrome(_ s: String) -> String {
        let charaArray = Array(s)
        let length = charaArray.count
        // 长度小于2的本身就是回文串，直接返回长度
        guard length > 1 else {
            return s
        }
        var start = 0
        var maxLength = 0
        for index in 0 ..< length {
            // 假设回文长度为奇数
            let revers1 = expandAroundCenter(charaArray, left: index, right: index)
            print("revers1: \(revers1)")
            // 假设回文长度为偶数
            let revers2 = expandAroundCenter(charaArray, left: index, right: index + 1)
            print("revers2: \(revers2)")
            let temp = max(revers1, revers2)
            if maxLength < temp {
                maxLength = temp
                start = index - ((temp - 1) >> 1)
            }
        }
        print("show start: \(start) length: \(maxLength)")
        let maxString = String(charaArray[start ..< (start + maxLength)])
        return maxString
    }
    
    /// 以一个字符为中心计算左右两边最长的长度
    /// - Parameters:
    ///   - characters: 入参数组
    ///   - left: 左指针
    ///   - right: 右指针
    /// - Returns: 结果
    private func expandAroundCenter(_ characters: [Character], left: Int, right: Int) -> Int {
        var l = left
        var r = right
        while l >= 0 && r < characters.count && characters[l] == characters[r] {
            l -= 1
            r += 1
        }
        return r - l - 1
    }
}
StringSolution().longestPalindrome("ccc")
