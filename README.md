# SC to TWD

`SC` is [Sia coin](http://sia.tech/)

This script estimate TWD value for `SC` by [Yunbi API](https://yunbi.zendesk.com/hc/zh-cn/articles/115005892327-API-%E5%BC%80%E5%8F%91%E8%80%85%E6%8E%A5%E5%8F%A3) and [Google finance API](https://www.google.com/finance/info?q=CURRENCY:CNYTWD)

Usage:

```bash
./sctwd.sh SC_AMOUNT [TWD_COST]
```

## Requirement

* [jq](https://stedolan.github.io/jq/)

If you use OSX, you can install it with [homebrew](https://brew.sh/index_zh-tw.html)

```bash
$ brew install jq
```

Or download bin in [Download page](https://stedolan.github.io/jq/download/)

## Example 1

Estimate TWD value with `10000` `SC`

```bash
$ ./sctwd.sh 10000
== Siacoin to TWD ==
SC Amount: 10000
SC/CNY   : 0.08401
CNY/TWD  : 4.3584
TWD      : 3661.49184
```

## Example 2

Estimate TWD value with `10000` `SC`, and costed `3000` TWD

```bash
$ ./sctwd.sh 10000 3000
== Siacoin to TWD ==
SC Amount: 10000
SC/CNY   : 0.0842
CNY/TWD  : 4.3584
TWD      : 3669.7728
--------------------
TWD COST : 3000
Earn TWD : 669.7728
%        : 22.300%
```
