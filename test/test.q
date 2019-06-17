\l qArgs.q

//q test/test.q -abc 2.0 -bc 8 -fc "2010.01.01"

show "Test 1 - Two required, One optional"
// Declare parameters at the start of the script
.args.addReq[`abcd;0nf;"float input"]
.args.addReq[`bc;0Ni;"integer input"]
.args.addOpt[`fc;2009.01.01;"date input"]
// Build a parameter dictionary for each access
arguments1:.args.buildDict[]
arguments1

show "Test 2 - No required, One optional"
.args.reqDict:()!()
.args.reqDes:()!()
.args.optDict:()!()
.args.optDes:()!()
.args.addOpt[`fc;2009.01.01;"date input"]
arguments2:.args.buildDict[]
arguments2

show "Test 3 - One required, No Optional"
.args.reqDict:()!()
.args.reqDes:()!()
.args.optDict:()!()
.args.optDes:()!()
.args.addReq[`abc;2009.01.01;"date input"]
arguments3:.args.buildDict[]
arguments3

show "Test 3 - None"
.args.reqDict:()!()
.args.reqDes:()!()
.args.optDict:()!()
.args.optDes:()!()
arguments4:.args.buildDict[]
arguments4

$[10h = abs type arguments1;show "Test 1 - passed.";show "Test 1 - failed."];
$[99h = abs type arguments2;show "Test 2 - passed.";show "Test 2 - failed."];
$[99h = abs type arguments3;show "Test 3 - passed.";show "Test 3 - failed."];
$[99h = abs type arguments4;show "Test 4 - passed.";show "Test 4 - failed."];