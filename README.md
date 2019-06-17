# kdb-qArguments
q/KDB+ -> Easy script set-up for required and optional arguments.

## Motivation
I created these functions as an easy way to allow kdb+ scripts to take in both optional and required parameters and exit out if required parameters were not specified at runtime. 

If a q script runs without a required parameter, the script fail. This event will allow a user to go back and investigate the issue.

The .args functions utilise the [.Q.def & .z.x functionality](https://code.kx.com/v2/ref/dotz/#zx-argv) as a way to enforce typing with the input arguments.

## Example Output
```
example.q

.args.addReq[`abcd;0nf;"float input"]
.args.addReq[`bc;0Ni;"integer input"]
.args.addOpt[`fc;2009.01.01;"date input"]

show .args.buildDict[]
```

If we had an example.q script, seen above, with input parameters `-abc 2.0 -bc 8 -12 "2010.01.01"`, it would create an error message like this:

```
cmd> q example.q -abc 2.0 -bc 8 -12 "2010.01.01"

Error - Some required Arguments where not supplied:
abcd

Arguments:
[Required] [type: 9] -abcd <float input>
[Required] [type: 6] -bc <integer input>
[Optional] [type: 14] -fc <date input>
"Error - Missing Required Argument"
```

However, if the correct input arguments are supplied, we will get a fully formed dictionary:

```
abc| 2f
bc | 8i
fc | 2009.01.01
```

## Authors

* **Ryan McFarland** - *Initial work* - [Ryan McFarland](https://github.com/ryanmcfarland)

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details