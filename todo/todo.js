#!/usr/bin/env node
"use strict";
var needle = require('needle'); // for http calls
var url = "http://marand.dk:8080/";
var help = "Commands are:\n" +
    "todo ls\n" +
    "todo ls -s\n" +
    "todo ls -l\n" +
    "todo add -s \"string\"\n" +
    "todo add -l \"string\"\n" +
    "todo rm -s \"number\"\n" +
    "todo rm -l \"number\"\n";
var printGetResult = function (error, res) {
    if (error)
        return console.error(error);
    if (res.statusCode == 200) {
        console.log(res.body);
    }
    else {
        console.log("call returned with status: " + res.statusCode);
    }
};
var printAddResult = function (error, res) {
    if (error)
        return console.error(error);
    if (res.statusCode == 200) {
        console.log("add operation succesful");
    }
    else {
        console.log("add operation returned with status: " + res.statusCode);
    }
};
var printDeleteResult = function (error, res) {
    if (error)
        return console.error(error);
    if (res.statusCode == 200) {
        console.log("delete operation succesful");
    }
    else {
        console.log("delete operation returned with status: " + res.statusCode);
    }
};
var get = function (flag) {
    if (flag && flag === "-s") {
        needle.get(url + "api/short", printGetResult);
    }
    else if (flag && flag === "-l") {
        needle.get(url + "api/long", printGetResult);
    }
    else {
        needle.get(url + "api/list", printGetResult);
    }
};
var add = function (flag, item) {
    if (flag === "-s") {
        needle.post(url + "api/short", { item: item }, printAddResult);
    }
    else {
        needle.post(url + "api/long", { item: item }, printAddResult);
    }
};
var rm = function (flag, pos) {
    if (flag === "-s") {
        needle.delete(url + "api/short/" + pos, null, printDeleteResult);
    }
    else {
        needle.delete(url + "api/long/" + pos, null, printDeleteResult);
    }
};
// parse arguments
var arg2 = process.argv[2];
if (!arg2 || arg2 != "ls" && arg2 != "add" && arg2 != "rm") {
    console.log(help);
}
else {
    var arg3 = process.argv[3], arg4 = process.argv[4], arg5 = process.argv[5];
    if (arg2 === "ls") {
        if (arg3 && arg3 === "-s" && !arg4) {
            get("-s");
        }
        else if (arg3 && arg3 === "-l" && !arg4) {
            get("-l");
        }
        else if (!arg3) {
            get();
        }
        else {
            console.log(help);
        }
    }
    else if (arg2 === "add") {
        if (arg3 && arg3 === "-s" && arg4 && typeof arg4 === "string" && !arg5) {
            add("-s", arg4);
        }
        else if (arg3 && arg3 == "-l" && arg4 && typeof arg4 === "string" && !arg5) {
            add("-l", arg4);
        }
        else {
            console.log(help);
        }
    }
    else if (arg2 === "rm") {
        if (arg3 && arg3 === "-s" && arg4 && typeof Number(arg4) === "number" && !arg5) {
            rm("-s", Number(arg4));
        }
        else if (arg3 && arg3 == "-l" && arg4 && typeof Number(arg4) === "number" && !arg5) {
            rm("-l", Number(arg4));
        }
        else {
            console.log(help);
        }
    }
    else {
        console.log(help);
    }
}
//# sourceMappingURL=todo.js.map