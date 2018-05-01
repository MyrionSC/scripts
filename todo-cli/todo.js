#!/usr/bin/env node
"use strict";
var needle = require('needle'); // for http calls
var url = "http://marand.dk:8002/";
var help = "Commands are:\n" +
    "todo ls\n" +
    "todo ls -pe\n" +
    "todo ls -pr\n" +
    "todo add -pe [string]\n" +
    "todo add -pr [string]\n" +
    "todo rm -pe [number]\n" +
    "todo rm -pr [number]\n";

var printGetPersonalResult = function (error, res) {
    if (error)
        return console.error(error);
    if (res.statusCode == 200) {
        for (var i = 0; i < res.body.length; i++) {
            var item = res.body[i];
            console.log(i + ": " + item);
        }
    }
    else {
        console.log("get personal returned with status: " + res.statusCode);
    }
};
var printGetProfessionalResult = function (error, res) {
    if (error)
        return console.error(error);
    if (res.statusCode == 200) {
        for (var i = 0; i < res.body.length; i++) {
            var item = res.body[i];
            console.log(i + ": " + item);
        }
    }
    else {
        console.log("get professional returned with status: " + res.statusCode);
    }
};
var printGetListResult = function (error, res) {
    if (error)
        return console.error(error);
    if (res.statusCode == 200) {
        console.log("personal:");
        for (var i = 0; i < res.body.personal.length; i++) {
            var item = res.body.personal[i];
            console.log(i + ": " + item);
        }
        console.log();
        console.log("professional");
        for (var i = 0; i < res.body.professional.length; i++) {
            var item = res.body.professional[i];
            console.log(i + ": " + item);
        }
    }
    else {
        console.log("get list returned with status: " + res.statusCode);
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
    if (flag && flag === "-pe") {
        needle.get(url + "api/personal", printGetPersonalResult);
    }
    else if (flag && flag === "-pr") {
        needle.get(url + "api/professional", printGetProfessionalResult);
    }
    else {
        needle.get(url + "api/list", printGetListResult);
    }
};
var add = function (flag, item) {
    if (flag === "-pe") {
        needle.post(url + "api/personal", {item: item}, printAddResult);
    }
    else {
        needle.post(url + "api/professional", {item: item}, printAddResult);
    }
};
var rm = function (flag, pos) {
    if (flag === "-pe") {
        needle.delete(url + "api/personal/" + pos, null, printDeleteResult);
    }
    else {
        needle.delete(url + "api/professional/" + pos, null, printDeleteResult);
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
        if (arg3 && arg3 === "-pe" && !arg4) {
            get("-pe");
        }
        else if (arg3 && arg3 === "-pr" && !arg4) {
            get("-pr");
        }
        else if (!arg3) {
            get();
        }
        else {
            console.log(help);
        }
    }
    else if (arg2 === "add") {
        if (arg3 && arg3 === "-pr" && arg4 && typeof arg4 === "string" && !arg5) {
            add("-pr", arg4);
        }
        else if (arg3 && arg3 == "-pe" && arg4 && typeof arg4 === "string" && !arg5) {
            add("-pe", arg4);
        }
        else {
            console.log(help);
        }
    }
    else if (arg2 === "rm") {
        if (arg3 && arg3 === "-pr" && arg4 && typeof Number(arg4) === "number" && !arg5) {
            rm("-pr", Number(arg4));
        }
        else if (arg3 && arg3 == "-pe" && arg4 && typeof Number(arg4) === "number" && !arg5) {
            rm("-pe", Number(arg4));
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