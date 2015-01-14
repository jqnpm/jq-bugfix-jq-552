<p align="center">
  <a href="https://github.com/joelpurra/jqnpm"><img src="https://rawgit.com/joelpurra/jqnpm/master/resources/logotype/penrose-triangle.svg" alt="jqnpm logotype, a Penrose triangle" width="100" border="0" /></a>
</p>

# [jq-bugfix-jq-552](https://github.com/joelpurra/jq-bugfix-jq-552)

Attempt to detect and fix inconsistencies in jq's ~~split/~~join behavior. See [jq's issue #552 Split output array length inconsistency](https://github.com/stedolan/jq/issues/552) and [jq's issue #668 join/1 should respect empty strings in input](https://github.com/stedolan/jq/issues/668).

This is a package for the command-line JSON processor [`jq`](https://stedolan.github.io/jq/). Install the package in your jq project/package directory with [`jqnpm`](https://github.com/joelpurra/jqnpm):

```bash
jqnpm install joelpurra/jq-bugfix-jq-552
```



## Usage

Shows the bugs in `join`.

```bash
# BugfixJq552::warningJoin: Single string to two empty parts.
jq -n '[] | join("")' # Expected "", Actually null
jq -n '[] | join("a")' # Expected "", Actually null
jq -n '[] | join("abc")' # Expected "", Actually null
```

```jq
import "joelpurra/jq-bugfix-jq-552" as BugfixJq552;

# Original function fails tests.
#
# join/1: Empty array join.
[] | join("") # Expected "", Actually null
[] | join("a") # Expected "", Actually null
[] | join("abc") # Expected "", Actually null


# These tests (intentionally) fail, but are detected and shows debug output.
#
# BugfixJq552::warningJoin/1: Empty array join. (Shows debug information.)
[] | BugfixJq552::warningJoin("") # Expected "", Actually null
[] | BugfixJq552::warningJoin("a") # Expected "", Actually null
[] | BugfixJq552::warningJoin("abc") # Expected "", Actually null


# Instead use the functions which attempt to fix these inconsistencies.
#
# BugfixJq552::attemptFixJoin/1: Empty array join.
[] | BugfixJq552::attemptFixJoin("") # ""
[] | BugfixJq552::attemptFixJoin("a") # ""
[] | BugfixJq552::attemptFixJoin("abc") # ""

```



---

## License
Copyright (c) 2015 Joel Purra <http://joelpurra.com/>
All rights reserved.

When using **jq-bugfix-jq-552**, comply to the MIT license. Please see the LICENSE file for details.
