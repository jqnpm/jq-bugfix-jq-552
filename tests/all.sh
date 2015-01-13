#!/usr/bin/env bash


fileUnderTest="${BASH_SOURCE%/*}/../jq/main.jq"


read -d '' fourLineTests <<-'EOF' || true
sumOfLengthsInArray: Empty array.
[]
sumOfLengthsInArray
0

sumOfLengthsInArray: Empty string.
[ "" ]
sumOfLengthsInArray
0

sumOfLengthsInArray: Empty strings.
[ "", "", "" ]
sumOfLengthsInArray
0

sumOfLengthsInArray: Single string.
[ "abc" ]
sumOfLengthsInArray
3

sumOfLengthsInArray: Two strings.
[ "abc", "def" ]
sumOfLengthsInArray
6

sumOfLengthsInArray: Three strings, one empty.
[ "", "def", "ghi" ]
sumOfLengthsInArray
6

sumOfLengthsInArray: Three strings, one empty.
[ "abc", "", "ghi" ]
sumOfLengthsInArray
6

sumOfLengthsInArray: Three strings, one empty.
[ "abc", "def", "" ]
sumOfLengthsInArray
6

split (original): Empty strings.
""
split("")
[]

split (original): Single string split with empty string.
"a"
split("")
[ "a" ]

split (original): Single string to two empty parts.
"a"
split("a")
[ "", "" ]

split (original): Single string to two parts x.
"xyz"
split("x")
[ "", "yz" ]

split (original): Single string to two parts y.
"xyz"
split("y")
[ "x", "z" ]

split (original): Single string to two parts z.
"xyz"
split("z")
[ "xy", "" ]

split (original): Single longer string to two parts abc.
"abcdefghi"
split("abc")
[ "", "defghi" ]

split (original): Single longer string to two parts def.
"abcdefghi"
split("def")
[ "abc", "ghi" ]

split (original): Single longer string to two parts ghi.
"abcdefghi"
split("ghi")
[ "abcdef", "" ]

warningSplit: Empty strings.
""
warningSplit("")
[]

warningSplit: Single string split with empty string. (Shows debug output).
"a"
warningSplit("")
[ "a" ]

warningSplit: Single string to two empty parts.
"a"
warningSplit("a")
[ "", "" ]

warningSplit: Single string to two parts x.
"xyz"
warningSplit("x")
[ "", "yz" ]

warningSplit: Single string to two parts y.
"xyz"
warningSplit("y")
[ "x", "z" ]

warningSplit: Single string to two parts z.
"xyz"
warningSplit("z")
[ "xy", "" ]

warningSplit: Single longer string to two parts abc.
"abcdefghi"
warningSplit("abc")
[ "", "defghi" ]

warningSplit: Single longer string to two parts def.
"abcdefghi"
warningSplit("def")
[ "abc", "ghi" ]

warningSplit: Single longer string to two parts ghi.
"abcdefghi"
warningSplit("ghi")
[ "abcdef", "" ]

attemptFixSplit: Empty strings.
""
attemptFixSplit("")
[]

attemptFixSplit: Single string split with empty string.
"a"
attemptFixSplit("")
[ "a" ]

attemptFixSplit: Single string to two empty parts.
"a"
attemptFixSplit("a")
[ "", "" ]

attemptFixSplit: Single string to two parts x.
"xyz"
attemptFixSplit("x")
[ "", "yz" ]

attemptFixSplit: Single string to two parts y.
"xyz"
attemptFixSplit("y")
[ "x", "z" ]

attemptFixSplit: Single string to two parts z.
"xyz"
attemptFixSplit("z")
[ "xy", "" ]

attemptFixSplit: Single longer string to two parts abc.
"abcdefghi"
attemptFixSplit("abc")
[ "", "defghi" ]

attemptFixSplit: Single longer string to two parts def.
"abcdefghi"
attemptFixSplit("def")
[ "abc", "ghi" ]

attemptFixSplit: Single longer string to two parts ghi.
"abcdefghi"
attemptFixSplit("ghi")
[ "abcdef", "" ]

join (original): Empty strings.
[]
join("")
""

join (original): Single string join with empty string.
[ "a" ]
join("")
"a"

join (original): Single string to two empty parts.
[ "", "" ]
join("a")
"a"

join (original): Two parts x.
[ "", "yz" ]
join("x")
"xyz"

join (original): Two parts y.
[ "x", "z" ]
join("y")
"xyz"

join (original): Two parts z.
[ "xy", "" ]
join("z")
"xyz"

join (original): Two longer parts abc.
[ "", "defghi" ]
join("abc")
"abcdefghi"

join (original): Two longer parts def.
[ "abc", "ghi" ]
join("def")
"abcdefghi"

join (original): Two longer parts ghi.
[ "abcdef", "" ]
join("ghi")
"abcdefghi"

warningJoin: Empty strings.
[]
warningJoin("")
""

warningJoin: Single string join with empty string.
[ "a" ]
warningJoin("")
"a"

warningJoin: Single string to two empty parts. (Shows debug output).
[ "", "" ]
warningJoin("a")
"a"

warningJoin: Two parts x. (Shows debug output).
[ "", "yz" ]
warningJoin("x")
"xyz"

warningJoin: Two parts y.
[ "x", "z" ]
warningJoin("y")
"xyz"

warningJoin: Two parts z.
[ "xy", "" ]
warningJoin("z")
"xyz"

warningJoin: Two longer parts abc. (Shows debug output).
[ "", "defghi" ]
warningJoin("abc")
"abcdefghi"

warningJoin: Two longer parts def.
[ "abc", "ghi" ]
warningJoin("def")
"abcdefghi"

warningJoin: Two longer parts ghi.
[ "abcdef", "" ]
warningJoin("ghi")
"abcdefghi"

attemptFixJoin: Empty strings.
[]
attemptFixJoin("")
""

attemptFixJoin: Single string join with empty string.
[ "a" ]
attemptFixJoin("")
"a"

attemptFixJoin: Two empty parts single string.
[ "", "" ]
attemptFixJoin("a")
"a"

attemptFixJoin: Two parts x.
[ "", "yz" ]
attemptFixJoin("x")
"xyz"

attemptFixJoin: Two parts y.
[ "x", "z" ]
attemptFixJoin("y")
"xyz"

attemptFixJoin: Two parts z.
[ "xy", "" ]
attemptFixJoin("z")
"xyz"

attemptFixJoin: Two longer parts abc.
[ "", "defghi" ]
attemptFixJoin("abc")
"abcdefghi"

attemptFixJoin: Two longer parts def.
[ "abc", "ghi" ]
attemptFixJoin("def")
"abcdefghi"

attemptFixJoin: Two longer parts ghi.
[ "abcdef", "" ]
attemptFixJoin("ghi")
"abcdefghi"
EOF

function testAllFourLineTests () {
	echo "$fourLineTests" | runAllFourLineTests
}


# Run tests above automatically.
# Custom tests can be added by adding new function with a name that starts with "test": function testSomething () { some test code; }
source "${BASH_SOURCE%/*}/test-runner.sh"
