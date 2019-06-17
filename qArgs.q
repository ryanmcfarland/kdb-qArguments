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
    if[10h <> abs type des;'`$"Description must be a string"];
    if[-11h <> type rKey;'`$"Required argument key must be a symbol"];
    .args.reqDict:.args.reqDict,(enlist rKey)!enlist dValue;
    .args.reqDes,:(enlist rKey)!enlist des;}

// Function to add optional parameters
addOpt:{[oKey;dValue;des]
    if[10h <> abs type des;'`$"Description must be a string"];
    if[-11h <> type oKey;'`$"Optional argument key must be a symbol"];
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
        .args.printErrManPage each (key .args.reqDict) where testreq;
        :"Error - Missing Required Argument"];
    // Create a new resultant dictionary from the valid input parameters
    res:.Q.def[fDict] .Q.opt .z.x;
    // Only select keys generated via req and opt functions 
    (key fDict)!res[key fDict]}

// Functon that prints a man-style list of arguments to the stderr
// [Arg type] [kdb type] -argument <description>
printErrManPage:{
    -2"Error - Some required Arguments where not supplied: ";
    -2 {string[x]} each x;
    -2"";
    -2"Arguments:";
    if[count key .args.reqDict; 
        -2 .args.generateArgString[;`req] each key .args.reqDict];
    if[count key .args.optDict; 
        -2 .args.generateArgString[;`opt] each key .args.optDict];
 }

// Prints out a man-like page
generateArgString:{[x;typ]
    pTyp:$[`opt = typ;"Optional";"Required"];
    "[",pTyp,"] [type: ",string[abs type (value `$".args.",string[typ],"Dict")[x]],"] -",string[x]," <",(value `$".args.",string[typ],"Des")[x],">"
 }

// Return back to the root namespace
\d .