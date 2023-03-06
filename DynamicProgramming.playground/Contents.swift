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
}

DynamicProgramming().minimumDeletions("bbaaaaabb")
