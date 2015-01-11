<p align="center">
  <img src="https://rawgit.com/joelpurra/jqnpm/master/resources/logotype/penrose-triangle.svg" alt="jqnpm logotype, a Penrose triangle" width="100" />
</p>

# [jq-bugfix-jq-552](https://github.com/joelpurra/jq-bugfix-jq-552)

Attempt to detect and fix inconsistencies in jq's split/join behavior. See [jq's issue #552 Split output array length inconsistency](https://github.com/stedolan/jq/issues/552).

This is a package for the command-line JSON processor [`jq`](https://stedolan.github.io/jq/). Install the package in your jq project/package directory with [`jqnpm`](https://github.com/joelpurra/jqnpm):

```bash
jqnpm install joelpurra/jq-bugfix-jq-552
```



## Usage


```jq
import "joelpurra/jq-bugfix-jq-552" as BugfixJq552;

# These tests fail for vanilla split/join, but they are detected and shows debug output.
#
# BugfixJq552::warningSplit: Single string to two empty parts. SHOWS DEBUG OUTPUT.
"a" | BugfixJq552::warningSplit("a") # Expected [ "", "" ], Actually [ "" ]

# BugfixJq552::warningSplit: Single string to two parts z. SHOWS DEBUG OUTPUT.
"xyz" | BugfixJq552::warningSplit("z") # [ Expected "xy", "" ], Actually [ "xy" ]

# BugfixJq552::warningJoin: Single string to two empty parts. SHOWS DEBUG OUTPUT.
[ "", "" ] | BugfixJq552::warningJoin("a") # Expected "a", Actually ""

# BugfixJq552::warningJoin: Two parts x. SHOWS DEBUG OUTPUT.
[ "", "yz" ] | BugfixJq552::warningJoin("x") # Expected "xyz", Actually "yz"


# Instead use the functions which attempt to fix these inconsistencies.
#
# BugfixJq552::attemptFixSplit: Single string to two empty parts.
"a" | BugfixJq552::attemptFixSplit("a") # [ "", "" ]

# BugfixJq552::attemptFixSplit: Single string to two parts z.
"xyz" | BugfixJq552::attemptFixSplit("z") # [ "xy", "" ]

# BugfixJq552::attemptFixJoin: Single string to two empty parts.
[ "", "" ] | BugfixJq552::attemptFixJoin("a") # "a"

# BugfixJq552::attemptFixJoin: Two parts x.
[ "", "yz" ] | BugfixJq552::attemptFixJoin("x") # "xyz"
```



---

## License
Copyright (c) 2015 Joel Purra <http://joelpurra.com/>
All rights reserved.

When using **jq-bugfix-jq-552**, comply to the MIT license. Please see the LICENSE file for details.
