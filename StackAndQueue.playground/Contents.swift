import Cocoa

extension String {
    var isCalculateSymbol: Bool {
        guard self.count == 1 else {
            return false
        }
        let mapping = ["+": 1, "-": 1, "*": 1, "/": 1]
        return mapping[self] != nil
    }
}

/*
 请你仅使用两个栈实现先入先出队列。队列应当支持一般队列支持的所有操作（push、pop、peek、empty）：

 实现 MyQueue 类：

 void push(int x) 将元素 x 推到队列的末尾
 int pop() 从队列的开头移除并返回元素
 int peek() 返回队列开头的元素
 boolean empty() 如果队列为空，返回 true ；否则，返回 false
 说明：

 你 只能 使用标准的栈操作 —— 也就是只有 push to top, peek/pop from top, size, 和 is empty 操作是合法的。
 你所使用的语言也许不支持栈。你可以使用 list 或者 deque（双端队列）来模拟一个栈，只要是标准的栈操作即可。
  

 示例 1：

 输入：
 ["MyQueue", "push", "push", "peek", "pop", "empty"]
 [[], [1], [2], [], [], []]
 输出：
 [null, null, null, 1, 1, false]

 解释：
 MyQueue myQueue = new MyQueue();
 myQueue.push(1); // queue is: [1]
 myQueue.push(2); // queue is: [1, 2] (leftmost is front of the queue)
 myQueue.peek(); // return 1
 myQueue.pop(); // return 1, queue is [2]
 myQueue.empty(); // return false

 来源：力扣（LeetCode）
 链接：https://leetcode.cn/problems/implement-queue-using-stacks
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */

class MyQueue {

    var inStack = [Int]()
    
    var outStack = [Int]()
    
    init() {
        
    }
    
    func push(_ x: Int) {
        inStack.append(x)
    }
    
    func pop() -> Int {
        if outStack.isEmpty {
            while !inStack.isEmpty {
                let element = inStack.popLast()
                outStack.append(element!)
            }
        }
        return outStack.popLast() ?? -1
    }
    
    func peek() -> Int {
        let element = pop()
        outStack.append(element)
        return element
    }
    
    func empty() -> Bool {
        return inStack.isEmpty && outStack.isEmpty
    }
}

class MyStack {
    
    var internalArray = [Int]()

    init() {

    }
    
    func push(_ x: Int) {
        internalArray.append(x)
    }
    
    func pop() -> Int {
        var popNum = internalArray.count - 1
        while popNum > 0 {
            let element = internalArray.removeFirst()
            internalArray.append(element)
            popNum -= 1
        }
        return internalArray.removeFirst()
    }
    
    func top() -> Int {
        let element = self.pop()
        self.push(element)
        return element
    }
    
    func empty() -> Bool {
        return internalArray.isEmpty
    }
}

class StackAndQueueSolution {
    /*
     给定一个只包括 '('，')'，'{'，'}'，'['，']' 的字符串 s ，判断字符串是否有效。

     有效字符串需满足：

     左括号必须用相同类型的右括号闭合。
     左括号必须以正确的顺序闭合。
     每个右括号都有一个对应的相同类型的左括号。
      

     示例 1：

     输入：s = "()"
     输出：true
     示例 2：

     输入：s = "()[]{}"
     输出：true
     示例 3：

     输入：s = "(]"
     输出：false


     来源：力扣（LeetCode）
     链接：https://leetcode.cn/problems/valid-parentheses
     著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
     */
    func isValid(_ s: String) -> Bool {
        // 建立映射表， 当遍历到左括号的时候，根据映射表入栈右括号
        let mapping = [Character("("): Character(")"), Character("["): Character("]"), Character("{"): Character("}")]
        // 储存右括号的栈
        var charStack = [Character]()
        // 遍历字符串
        let characters = Array(s)
        for char in characters {
            // 如果遍历到可映射的左括号，对应右括号入栈
            if let mapped = mapping[char] {
                charStack.append(mapped)
            }
            // 如果遍历到右括号
            if char == Character(")") || char == Character("]") || char == Character("}") {
                // 栈已经空了，说明右括号太多了，返回错误
                if charStack.isEmpty {
                    return false
                }
                // 从栈中弹出最后一个元素右括号
                let element = charStack.removeLast()
                // 如果弹出的右括号和当前遍历到的不同，说明括号不匹配，返回错误
                if element != char {
                    return false
                }
            }
        }
        // 如果遍历完了栈还没有空，说明左括号太多了， 返回错误
        return charStack.isEmpty
    }
    
    /*
     给出由小写字母组成的字符串 S，重复项删除操作会选择两个相邻且相同的字母，并删除它们。

     在 S 上反复执行重复项删除操作，直到无法继续删除。

     在完成所有重复项删除操作后返回最终的字符串。答案保证唯一。

      

     示例：

     输入："abbaca"
     输出："ca"
     解释：
     例如，在 "abbaca" 中，我们可以删除 "bb" 由于两字母相邻且相同，这是此时唯一可以执行删除操作的重复项。之后我们得到字符串 "aaca"，其中又只有 "aa" 可以执行重复项删除操作，所以最后的字符串为 "ca"。

     来源：力扣（LeetCode）
     链接：https://leetcode.cn/problems/remove-all-adjacent-duplicates-in-string
     著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
     */
    
    func removeDuplicates(_ s: String) -> String {
        var stack = [Character]()
        for char in s {
            if stack.isEmpty {
                stack.append(char)
                continue
            }
            let stackChar = stack.popLast()
            if stackChar != char {
                stack.append(stackChar!)
                stack.append(char)
            }
        }
        return String(stack)
    }
    
    /*
     给你一个字符串数组 tokens ，表示一个根据 逆波兰表示法 表示的算术表达式。

     请你计算该表达式。返回一个表示表达式值的整数。

     注意：

     有效的算符为 '+'、'-'、'*' 和 '/' 。
     每个操作数（运算对象）都可以是一个整数或者另一个表达式。
     两个整数之间的除法总是 向零截断 。
     表达式中不含除零运算。
     输入是一个根据逆波兰表示法表示的算术表达式。
     答案及所有中间计算结果可以用 32 位 整数表示。
      

     示例 1：

     输入：tokens = ["2","1","+","3","*"]
     输出：9
     解释：该算式转化为常见的中缀算术表达式为：((2 + 1) * 3) = 9
     示例 2：

     输入：tokens = ["4","13","5","/","+"]
     输出：6
     解释：该算式转化为常见的中缀算术表达式为：(4 + (13 / 5)) = 6
     示例 3：

     输入：tokens = ["10","6","9","3","+","-11","*","/","*","17","+","5","+"]
     输出：22
     解释：该算式转化为常见的中缀算术表达式为：
       ((10 * (6 / ((9 + 3) * -11))) + 17) + 5
     = ((10 * (6 / (12 * -11))) + 17) + 5
     = ((10 * (6 / -132)) + 17) + 5
     = ((10 * 0) + 17) + 5
     = (0 + 17) + 5
     = 17 + 5
     = 22

     来源：力扣（LeetCode）
     链接：https://leetcode.cn/problems/evaluate-reverse-polish-notation
     著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
     */
    
    func evalRPN(_ tokens: [String]) -> Int {
        var stack = [Int]()
        for symbol in tokens {
            // 遇到非运算符就直接入栈
            if !symbol.isCalculateSymbol {
                print("pushed \(symbol)")
                stack.append(Int(symbol) ?? 0)
                continue
            }
            // 遇到运算符，则从栈中取出两个元素计算，并把结果放回栈内
            if stack.count > 1 {
                guard let x = stack.popLast(), let y = stack.popLast() else {
                    continue
                }
                print("calculating \(x) \(symbol) \(y)")
                var result = 0
                if symbol == "+" {
                    result = y + x
                } else if symbol == "-" {
                    result = y - x
                } else if symbol == "*" {
                    result = y * x
                } else  {
                    result = y / x
                }
                print("pushed temp result \(result)")
                stack.append(result)
            }
        }
        return stack.popLast() ?? 0
    }
    
    /*
     给你一个整数数组 nums，有一个大小为 k 的滑动窗口从数组的最左侧移动到数组的最右侧。你只可以看到在滑动窗口内的 k 个数字。滑动窗口每次只向右移动一位。

     返回 滑动窗口中的最大值 。

      

     示例 1：

     输入：nums = [1,3,-1,-3,5,3,6,7], k = 3
     输出：[3,3,5,5,6,7]
     解释：
     滑动窗口的位置                最大值
     ---------------               -----
     [1  3  -1] -3  5  3  6  7       3
      1 [3  -1  -3] 5  3  6  7       3
      1  3 [-1  -3  5] 3  6  7       5
      1  3  -1 [-3  5  3] 6  7       5
      1  3  -1  -3 [5  3  6] 7       6
      1  3  -1  -3  5 [3  6  7]      7
     示例 2：

     输入：nums = [1], k = 1
     输出：[1]

     来源：力扣（LeetCode）
     链接：https://leetcode.cn/problems/sliding-window-maximum
     著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
     */
    func pushMonoIncreasely(_ queue: inout [Int], _ value: Int) {
        // 如果入栈的值比前面的值要大，就把前面的值逐个弹出
        if queue.isEmpty {
            queue.append(value)
            return
        }
        while !queue.isEmpty && queue.last! < value {
            queue.removeLast()
        }
        queue.append(value)
        return
    }
    
    func popMonoIncreasely(_ queue: inout [Int], _ value: Int) {
        guard let first = queue.first else {
            return
        }
        // print("poped: \(first) value: \(value)")
        if first == value {
            queue.removeFirst()
        }
    }
    
    func maxSlidingWindow(_ nums: [Int], _ k: Int) -> [Int] {
        var queue = [Int]()
        var result = [Int]()
        for index in 0 ..< nums.count {
            // 如果滑动窗口过大，弹出最新元素，
            if index > k - 1 {
                popMonoIncreasely(&queue, nums[index - k])
            }
            // push最新元素
            pushMonoIncreasely(&queue, nums[index])
            if index >= k - 1 {
                result.append(queue.first!)
            }
        }
        return result
    }
    
    /*
     给你一个整数数组 nums 和一个整数 k ，请你返回其中出现频率前 k 高的元素。你可以按 任意顺序 返回答案。

      

     示例 1:

     输入: nums = [1,1,1,2,2,3], k = 2
     输出: [1,2]
     示例 2:

     输入: nums = [1], k = 1
     输出: [1]

     来源：力扣（LeetCode）
     链接：https://leetcode.cn/problems/top-k-frequent-elements
     著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
     */
    
    //  小顶堆调堆函数
    func heapify(_ nums: inout [Dictionary<Int, Int>.Element], _ father: Int, _ size: Int) {
        let leftSon = father * 2 + 1
        let rightSon = father * 2 + 2
        var tempFather = father
        if leftSon < size && nums[leftSon].value < nums[tempFather].value {
            tempFather = leftSon
        }
        if rightSon < size && nums[rightSon].value < nums[tempFather].value {
            tempFather = rightSon
        }
        if tempFather != father {
            nums.swapAt(tempFather, father)
            heapify(&nums, tempFather, size)
        }
    }
    
    func topKFrequent(_ nums: [Int], _ k: Int) -> [Int] {
        var frequencyMap = [Int: Int]()
        for value in nums {
            guard let currentFreq = frequencyMap[value] else {
                frequencyMap[value] = 1
                continue
            }
            frequencyMap[value] = currentFreq + 1
        }
        var pairs = Array(frequencyMap)
        let lastIndex = pairs.count - 1
        var entryFather = (lastIndex  - 1) / 2
        // 将整个数组调成小顶堆
        while entryFather >= 0 {
            heapify(&pairs, entryFather, pairs.count)
            entryFather -= 1
        }
        // 按顺序pop掉小顶堆的根节点
        var swapIndex = pairs.count - 1
        var result = [Int]()
        let loopCount = pairs.count - k
        for _ in 0 ..< loopCount {
            // 把根节点放到最后相当于pop堆的元素，不断pop掉小的元素再调堆，当pop掉size - k个元素后，剩下的前K个就是最大的那些元素了
            pairs.swapAt(0, swapIndex)
            heapify(&pairs, 0, swapIndex)
            swapIndex -= 1
        }
        for pair in pairs[0 ..< k] {
            result.append(pair.key)
        }
        return result
    }
    
    /*
     3. 无重复字符的最长子串
     给定一个字符串 s ，请你找出其中不含有重复字符的 最长
     子串
      的长度。

      

     示例 1:

     输入: s = "abcabcbb"
     输出: 3
     解释: 因为无重复字符的最长子串是 "abc"，所以其长度为 3。
     示例 2:

     输入: s = "bbbbb"
     输出: 1
     解释: 因为无重复字符的最长子串是 "b"，所以其长度为 1。
     示例 3:

     输入: s = "pwwkew"
     输出: 3
     解释: 因为无重复字符的最长子串是 "wke"，所以其长度为 3。
          请注意，你的答案必须是 子串 的长度，"pwke" 是一个子序列，不是子串。
      

     提示：

     0 <= s.length <= 5 * 104
     s 由英文字母、数字、符号和空格组成
     */
    
    func lengthOfLongestSubstring(_ s: String) -> Int {
        guard !s.isEmpty else {
            return 0
        }
        var window = [Character]()
        let characters = Array(s)
        let arrayCount = characters.count
        var max_len = 0
        var cur_len = 0
        // 遍历整个字符串
        for index in 0 ..< arrayCount {
            // 取出当前字符
            let chacter = characters[index]
            while window.contains(chacter) {
                // 如果有重复字符, 就把滑动窗口内到重复字符为止的字符全部剔除, 加入新的字符
                if let firstIndex = window.firstIndex(of: chacter) {
                    window.removeFirst(firstIndex + 1)
                }
                // 更新字符长度
                cur_len = window.count
            }
            // 加入当前字符
            window.append(chacter)
            // 字符长度 + 1
            cur_len += 1
            // 替换最大长度
            if cur_len > max_len {
                max_len = cur_len
            }
            // print(window)
        }
        return max_len
    }
}

StackAndQueueSolution().lengthOfLongestSubstring("abcabcbb")
