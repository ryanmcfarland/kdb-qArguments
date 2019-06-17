\l qArgs.q

// Declare parameters at the start of the script
.args.addReq[`abcd;0nf;"test"]
.args.addReq[`bc;0Ni;"test"]
.args.addOpt[`fc;2009.01.01;"test"]

// Build a parameter dictionary for each access
arguments:.args.buildDict[]
arguments