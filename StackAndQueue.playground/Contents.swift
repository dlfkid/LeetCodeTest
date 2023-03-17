import Cocoa

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
}