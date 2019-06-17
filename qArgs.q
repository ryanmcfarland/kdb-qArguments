/////////////
// Programmer: Ryan McFarland
// Date: 2019.06.14
// Script Function: Check of optional and required arguments on start-up the script. Allows for users to easily apply types and parameters to their scripts
/////////////

// Work in the namespace: .parms
\d .args

// Create empty default dictionaries for both required and optional parameters
reqDict:()!()
reqDes:()!()

optDict:()!()
optDes:()!()

// Function to add required parameters
addReq:{[rKey;dValue;des]
    .args.reqDict:.args.reqDict,(enlist rKey)!enlist dValue;
    .args.reqDes,:(enlist rKey)!enlist des;}

// Function to add optional parameters
addOpt:{[oKey;dValue;des]
    .args.optDict:.args.optDict,(enlist oKey)!enlist dValue;
    .args.optDes,:(enlist oKey)!enlist des;}

// Function that will build the working dictionary
buildDict:{
    // Build an empty dictionary to check if all required keys exist
    res:.Q.def[()!()] .Q.opt .z.x;
    // Create a final dictionary using both the optional and required params
    fDict:.args.reqDict,.args.optDict;
    // Check if all required keys are in the built input dictionary
    testreq:not (key .args.reqDict) in key res;
    // Test if any is true, if true, print out man-like page
    if[any testreq;
        .args.printManPage each (key .args.reqDict) where testreq;
        :"Error - Missing Required Argument"];
    //output the built dictionary
    res:.Q.def[fDict] .Q.opt .z.x;
    (key fDict)!res[key fDict]}


printManPage:{
    -1"Error - Some required Arguments where not supplied: ";
    -1 {string[x]} each x;
    -1"";
    -1"Arguments:";
    if[count key .args.reqDict; 
        -1 .args.generateArgString[;`req] each key .args.reqDict];
    if[count key .args.optDict; 
        -1 .args.generateArgString[;`opt] each key .args.optDict];
 }

// Prints out a man-like page
generateArgString:{[x;typ]
    pTyp:$[`opt = typ;"Optional";"Required"];
    "[",pTyp,"] [type: ",string[abs type (value `$".args.",string[typ],"Dict")[x]],"] -",string[x]," <",(value `$".args.",string[typ],"Des")[x],">"
 }

// Return back to the root namespace
\d .