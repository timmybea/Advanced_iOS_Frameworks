//: Playground - noun: a place where people can play

import UIKit

//In Protocol Oriented Programming, the basic unit is value types.


//Value types: different instances keep  their own copies of data. Structs are value types.

struct ExampleStruct {
    var number: Int = -5
}

var a = ExampleStruct()

//copy of a in b 
var b = a

a.number = 10

print("number in a: \(a.number)")

print("number in b: \(b.number)")


//Reference types: When you assign a variable to the instance of the class, you are not passing a copy of the data, but rather the reference to that same object in memory. So this time, when we change the value of the number variable, that change is reflected in both the c and d instances.

class ExampleClass {
    var number: Int = -5
}

var c = ExampleClass()

var d = c

c.number = 10

print("number in c is: \(c.number) & number in d is: \(d.number)")