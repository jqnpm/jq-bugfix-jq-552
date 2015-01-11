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

warningSplit: Empty strings.
""
warningSplit("")
[]

warningSplit: Single string split with empty string.
"a"
warningSplit("")
[ "a" ]

warningSplit: Single string to two empty parts. SHOWS DEBUG OUTPUT.
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

warningSplit: Single string to two parts z. SHOWS DEBUG OUTPUT.
"xyz"
warningSplit("z")
[ "xy", "" ]

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

warningJoin: Empty strings.
[]
warningJoin("")
""

warningJoin: Single string join with empty string.
[ "a" ]
warningJoin("")
"a"

warningJoin: Single string to two empty parts. SHOWS DEBUG OUTPUT.
[ "", "" ]
warningJoin("a")
"a"

warningJoin: Two parts x. SHOWS DEBUG OUTPUT.
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
EOF

function testAllFourLineTests () {
	echo "$fourLineTests" | runAllFourLineTests
}


# Run tests above automatically.
# Custom tests can be added by adding new function with a name that starts with "test": function testSomething () { some test code; }
source "${BASH_SOURCE%/*}/test-runner.sh"
