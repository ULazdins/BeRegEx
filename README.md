# BeRegEx

A **Be**tter way to do **Re**gular **Ex**pressions.

An **experimental** micro library to improve the readability of regular expressions.

Doesn't have all functions that regular expressions can do and has poor test coverage.

## Goal

Regular expressions are really hard to read. This library proposes type safe DSL to generate the regular expressions from high level operators.

The proposed DSL would replace 

`"^([A-Z0-9a-z._%+-]+)@([A-Za-z0-9.-]+\\.[A-Za-z]{2,64})$"`

with

```swift
let usernameRegex = AnyOf(.alphanumerics, .custom("._%+-"))
    .oneOrMore()

let domainRegex = AnyOf(.alphanumerics, .custom(".-")).oneOrMore() +
    Exact(".") +
    AnyOf(.letters).between(2...64)

let regex = Start() +
    usernameRegex.capture() +
    Exact("@") +
    domainRegex.capture() +
    End()
```

then the `regex` can be used:

```swift
let doesntMatch = regex.match("not.a.valid.because.domain@gmail.com-")
print(doesntMatch) // prints []

let doesMatch = regex.match("is.a.valid.email@gmail.com")
print(doesMatch) // prints [match: "is.a.valid.email@gmail.com", captures: ["is.a.valid.email", "gmail.com"]]
```

## Installation

### Swift Package Manager

To install it, simply add the dependency to your Package.Swift file:

```swift
...
dependencies: [
    .package(url: "https://github.com/ULazdins/BeRegEx.git", from: "0.0.1"),
],
targets: [
    .target( 
        name: "YourTarget", 
        dependencies: [
            "BeRegEx"
        ]
    ),
    ...
]
...
```

## Operators

### AnyOf

`AnyOf` replaces the square brackes. Instead of `"[a-A]"` you would write `AnyOf(.lowercaseLetters)`.  

Letter classes can be combined.

`AnyOf(.letters, .numbers, .custom("._%+-"))` will yield the equivalent  of `"[A-Z0-9a-z._%+-]"`

### ZeroOrMore, OneOrMore, Between

To specify the number of repetitions, you can use any of these operators.

Examples:

`AnyOf(.letters).zeroOrMore()`

`AnyOf(.letters).oneOrMore()`

`AnyOf(.letters).between(1...4)`

### Exact

`Exact` replaces exact matches. If you want to match the string `"cat"`, you must now use `Exact("cat")`


### Start, End

`Start` and `End` are equivalents of `$` and `^` symbols in regular expressions. For example

`Exact("aaa")` will match a substring of  `baaab`, but `Start() + Exact("aaa") + End()` will not as there are `b` before and after `aaa`.

### And

`And` concatenates other operators. Library comes with a `+` operator override so that the usage of `And` becomes intuitive.

`And(reg1: AnyOf(.letters), reg2: Exact("cat"))` 

is equivalent to `AnyOf(.letters) + Exact("cat")` 

is equivalent to `"[a-zA-Z]cat"`

### Capture

`Capture` creates a capture group.

`Exact("<") + AnyOf(.letters).oneOrMore().capture() + Exact(">")` will match `"<h1>"` and `<img>` and it will also capture the substring that is matched by `AnyOf` and `oneOrMore`, namely `"h1"` and `"img"`
