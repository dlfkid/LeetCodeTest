import Cocoa

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
                tempString = reverseString(tempString, startIndex, k)
            }
            // 剩余长度不足k的时候有特殊逻辑
            if leftSize < k {
                tempString = reverseString(tempString, startIndex, leftSize)
            }
            // 下一轮遍历
            startIndex += 2 * k
        }
        return tempString
    }
    
    func reverseString(_ string: String, _ startIndex: Int, _ size: Int) -> String {
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
}

StringSolution().reverseStr("abcdefg", 2)
StringSolution().reverseString("bacdefg", 4, 2)
