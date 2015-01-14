#!/usr/bin/env bash


fileUnderTest="${BASH_SOURCE%/*}/../jq/main.jq"


read -d '' fourLineTests_sumOfLengthsInArray <<-'EOF' || true
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
EOF

read -d '' fourLineTests_split <<-'EOF' || true
__function__: Empty strings.
""
__function__("")
[]

__function__: Single string split with empty string.
"a"
__function__("")
[ "a" ]

__function__: Single string to two empty parts.
"a"
__function__("a")
[ "", "" ]

__function__: Single string to two parts x.
"xyz"
__function__("x")
[ "", "yz" ]

__function__: Single string to two parts y.
"xyz"
__function__("y")
[ "x", "z" ]

__function__: Single string to two parts z.
"xyz"
__function__("z")
[ "xy", "" ]

__function__: Single longer string to two parts abc.
"abcdefghi"
__function__("abc")
[ "", "defghi" ]

__function__: Single longer string to two parts def.
"abcdefghi"
__function__("def")
[ "abc", "ghi" ]

__function__: Single longer string to two parts ghi.
"abcdefghi"
__function__("ghi")
[ "abcdef", "" ]
EOF

function swapTestLine2and4 {
awk '{
	if ((NR % 5)==2) {
		s=$0
		getline;s=$0"\n"s
		getline;print;print s
		next
	}
}1'
}

function testAllFourLineTests () {
	echo "$fourLineTests_sumOfLengthsInArray" | runAllFourLineTests
	echo "$fourLineTests_split" | sed 's/__function__/split/g' | runAllFourLineTests
	echo "$fourLineTests_split" | sed 's/__function__/warningSplit/g' | runAllFourLineTests
	echo "$fourLineTests_split" | sed 's/__function__/attemptFixSplit/g' | runAllFourLineTests
	echo "$fourLineTests_split" | swapTestLine2and4 | sed 's/__function__/join/g' | runAllFourLineTests
	echo "$fourLineTests_split" | swapTestLine2and4 | sed 's/__function__/warningJoin/g' | runAllFourLineTests
	echo "$fourLineTests_split" | swapTestLine2and4 | sed 's/__function__/attemptFixJoin/g' | runAllFourLineTests
}


# Run tests above automatically.
# Custom tests can be added by adding new function with a name that starts with "test": function testSomething () { some test code; }
source "${BASH_SOURCE%/*}/test-runner.sh"
