import Cocoa

var greeting = "Hello, playground"

class HashTableSolution {
    /* No. 242
     给定两个字符串 s 和 t ，编写一个函数来判断 t 是否是 s 的字母异位词。

     注意：若 s 和 t 中每个字符出现的次数都相同，则称 s 和 t 互为字母异位词。

      

     示例 1:

     输入: s = "anagram", t = "nagaram"
     输出: true
     示例 2:

     输入: s = "rat", t = "car"
     输出: false
      

     提示:

     1 <= s.length, t.length <= 5 * 104
     s 和 t 仅包含小写字母
     */
    func isAnagram(_ s: String, _ t: String) -> Bool {
        guard s.count == t.count else {
            return false
        }
        var result = true
        var alphabet: [Int] = Array(repeating: 0, count: 26)
        for (_, letter) in s.enumerated() {
            let index: Int = Int(letter.asciiValue! - Character("a").asciiValue!)
            let frequency = alphabet[index]
            alphabet[index] = frequency + 1
        }
        for (_, letter) in t.enumerated() {
            let index: Int = Int(letter.asciiValue! - Character("a").asciiValue!)
            let frequency = alphabet[index]
            alphabet[index] = frequency - 1
        }
        for (_, value) in alphabet.enumerated() {
            if value != 0 {
                result = false
                break
            }
        }
        return result
    }
}

HashTableSolution().isAnagram("anagram", "nagaram")
