/////////////
// Programmer: Ryan McFarland
// Date: 2019.06.14
// Script Function: Check of optional and required arguments on start-up the script. Allows for users to easily apply types and parameters to their scripts
/////////////

//raze {[x;y;z] (enlist x)!y$z}'[key res;"Ic";value res]

// Work in the namespace: .parms
\d .args

// Create empty default dictionaries for both required and optional parameters
reqDict:()!()
reqDes:()!()

optDict:()!()
optDes:()!()

// Function to add required parameters
addReq:{[rKey;dValue;des]
    .parms.reqDict:reqDict,(enlist rKey)!enlist dValue;
    .parms.reqDes,:(enlist rKey)!enlist des;}

// Function to add optional parameters
addOpt:{[oKey;dValue;des]
    .parms.optDict:optDict,(enlist oKey)!enlist dValue;
    optDict,:(enlist oKey)!enlist dValue;}

// Function that will build the working dictionary
buildDict:{
    //build an empty string dictionary to check if all required keys exist
    res:.Q.def[()!()] .Q.opt .z.x;
    //create a final dictionary using both the optional and required params
    fDict:.parms.reqDict,.parms.optDict;
    // Check if all required keys are in the built input dictionary
    if[any not (key res) in key .parms.reqDict;:"missing key"];
    //check if any additional keys were supplied that weren't listed
    if[any not (key res) in key fDict;:"additional key"];
    //output the built dictionary
    .Q.def[fDict] .Q.opt .z.x}

// Return back to the root namespace
\d .

// Declare parameters at the start of the script
.parms.addReq[`abc;2f;"test"]
.parms.addReq[`bc;2i;"test"]
.parms.addOpt[`fc;2009.01.01;"test"]

// Build a parameter dictionary for each access
parmeters:.parms.buildDict[]