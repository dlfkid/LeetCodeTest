import Cocoa

class ListNodesSolutions {
    
    public class ListNode {
        public var val: Int
        public var next: ListNode?
        public init() { self.val = 0; self.next = nil; }
        public init(_ val: Int) { self.val = val; self.next = nil; }
        public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
    }
    
    /*
     给你一个链表的头节点 head 和一个整数 val ，请你删除链表中所有满足 Node.val == val 的节点，并返回 新的头节点 。

     输入：head = [1,2,6,3,4,5,6], val = 6
     输出：[1,2,3,4,5]
     示例 2：

     输入：head = [], val = 1
     输出：[]
     示例 3：

     输入：head = [7,7,7,7], val = 7
     输出：[]

     来源：力扣（LeetCode）
     链接：https://leetcode.cn/problems/remove-linked-list-elements
     著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
     */
    
    /// 使用虚拟头节点的方式删除链表指定节点
    /// - Parameters:
    ///   - head: 头节点
    ///   - val: 节点值
    /// - Returns: 返回删除后的头节点
    func removeElements(_ head: ListNode?, _ val: Int) -> ListNode? {
        // 判断入参是否为空, 如果入参为空就不用遍历了
        guard head != nil else {
            return nil
        }
        // 构造虚拟头节点, 并将它的下一个节点设置为入参节点, 这样就能对入参的链表头节点和非头节点做统一处理
        let dummyHead = ListNode(0, head)
        // 声明指针变量, 表示当前遍历到节点的哪个位置
        var currentNode: ListNode? = dummyHead
        while currentNode != nil {
            if currentNode?.next?.val == val {
                // 节点删除操作
                currentNode?.next = currentNode?.next?.next
            } else {
                // 注意只有不命中删除的时候需要移动指针, 否则删除节点又移动指针会导致有节点漏掉
                currentNode = currentNode?.next
            }
        }
        // 注意返回的的头节点永远是虚拟头节点的下一个节点
        return dummyHead.next
    }
    
    /*
     设计链表的实现。您可以选择使用单链表或双链表。单链表中的节点应该具有两个属性：val 和 next。val 是当前节点的值，next 是指向下一个节点的指针/引用。如果要使用双向链表，则还需要一个属性 prev 以指示链表中的上一个节点。假设链表中的所有节点都是 0-index 的。

     在链表类中实现这些功能：

     get(index)：获取链表中第 index 个节点的值。如果索引无效，则返回-1。
     addAtHead(val)：在链表的第一个元素之前添加一个值为 val 的节点。插入后，新节点将成为链表的第一个节点。
     addAtTail(val)：将值为 val 的节点追加到链表的最后一个元素。
     addAtIndex(index,val)：在链表中的第 index 个节点之前添加值为 val  的节点。如果 index 等于链表的长度，则该节点将附加到链表的末尾。如果 index 大于链表长度，则不会插入节点。如果index小于0，则在头部插入节点。
     deleteAtIndex(index)：如果索引 index 有效，则删除链表中的第 index 个节点。
      

     示例：

     MyLinkedList linkedList = new MyLinkedList();
     linkedList.addAtHead(1);
     linkedList.addAtTail(3);
     linkedList.addAtIndex(1,2);   //链表变为1-> 2-> 3
     linkedList.get(1);            //返回2
     linkedList.deleteAtIndex(1);  //现在链表是1-> 3
     linkedList.get(1);            //返回3
      

     提示：

     0 <= index, val <= 1000
     请不要使用内置的 LinkedList 库。
     get, addAtHead, addAtTail, addAtIndex 和 deleteAtIndex 的操作次数不超过 2000。

     来源：力扣（LeetCode）
     链接：https://leetcode.cn/problems/design-linked-list
     著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
     */
    
    class MyLinkedList {
        
        public var size: Int
        public var dummyHead = ListNode(-1, nil)

        init() {
            size = 0
        }
        
        func get(_ index: Int) -> Int {
            if index >= size || index < 0 {
                return -1
            }
            var curNode = dummyHead.next
            var curIndex = index

            while curIndex > 0 {
                curNode = curNode?.next
                curIndex -= 1
            }
            return curNode?.val ?? -1
        }
        
        func addAtHead(_ val: Int) {
            dummyHead.next = ListNode(val, dummyHead.next)
            size += 1
        }
        
        func addAtTail(_ val: Int) {
            var currentNode: ListNode? = dummyHead
            while currentNode?.next != nil {
                currentNode = currentNode?.next
            }
            currentNode?.next = ListNode(val, nil)
            size += 1
        }
        
        func addAtIndex(_ index: Int, _ val: Int) {
            guard index < size else {
                if index == size {
                    addAtTail(val)
                }
                return
            }
            if index <= 0 {
                addAtHead(val)
                return
            }
            var currentNode: ListNode? = dummyHead
            for _ in 0 ..< index {
                currentNode = currentNode?.next
            }
            let nextNode = currentNode?.next
            currentNode?.next = ListNode(val, nextNode)
            size += 1
        }
        
        func deleteAtIndex(_ index: Int) {
            guard index >= 0 && index < size else {
                return
            }
            var currentNode: ListNode? = dummyHead
            for _ in 0 ..< index {
                currentNode = currentNode?.next
            }
            currentNode?.next = currentNode?.next?.next
            size -= 1
        }
    }
    
    /*
     给你单链表的头节点 head ，请你反转链表，并返回反转后的链表。
     */
    func reverseList(_ head: ListNode?) -> ListNode? {
        var current: ListNode? = head
        var pre: ListNode? = nil
        while current != nil {
            let nextNode = current?.next
            current?.next = pre
            pre = current
            current = nextNode
        }
        return pre
    }
    
    // 这个是递归解法, 核心思路其实和上面的双指针法一样
    func reverseList2(_ head: ListNode?) -> ListNode? {
        return reversTwoNode(head, nil)
    }
    
    func reversTwoNode(_ current: ListNode?, _ pre: ListNode?) -> ListNode? {
        guard current != nil else {
            return pre
        }
        let nextNode = current?.next
        current?.next = pre
        let newPre = current
        let newCurrent = nextNode
        return reversTwoNode(newCurrent, newPre)
    }
    
    /*
     给你一个链表，两两交换其中相邻的节点，并返回交换后链表的头节点。你必须在不修改节点内部的值的情况下完成本题（即，只能进行节点交换）。

     输入：head = [1,2,3,4]
     输出：[2,1,4,3]
     示例 2：

     输入：head = []
     输出：[]
     示例 3：

     输入：head = [1]
     输出：[1]

     来源：力扣（LeetCode）
     链接：https://leetcode.cn/problems/swap-nodes-in-pairs
     著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
     */
    func swapPairs(_ head: ListNode?) -> ListNode? {
        let dummyHead = ListNode(-1, head)
        var currnt: ListNode? = dummyHead
        while currnt?.next != nil && currnt?.next?.next != nil {
            let node1 = currnt?.next
            let node2 = currnt?.next?.next
            let node3 = node2?.next
            currnt?.next = node2
            node2?.next = node1
            node1?.next = node3
            currnt = currnt?.next?.next
        }
        return dummyHead.next
    }
}
