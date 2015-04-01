# ConvertRMBCapitalAmount
Convert arabic numerals to RMB capital amount for Objective-C

由于项目需求，需要把数字转换为 人民币大写金额。网上查找了很多关于OC上的转换方法，发现大部分都还是基于C中的遍历数字字符串来一个一个转换的。
Cocoa库其实很强大，所以自己研究了下，实现了通过调用系统的NSNumberFormatter来实现，实现简单，也没有复杂的循环。
