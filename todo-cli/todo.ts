#!/usr/bin/env node

let needle = require('needle'); // for http calls

let url = "http://marand.dk:8002/";
let help = "Commands are:\n" +
    "todo ls\n" +
    "todo ls -s\n" +
    "todo ls -l\n" +
    "todo add -s [string]\n" +
    "todo add -l [string]\n" +
    "todo rm -s [number]\n" +
    "todo rm -l [number]\n";

let printGetShortResult = (error: Error, res: any): void => {
    if (error) return console.error(error);
    if (res.statusCode == 200) {
        for (let i = 0; i < res.body.length; i++) {
            let item = res.body[i];
            console.log(i + ": " + item);
        }
    } else {
        console.log("get short returned with status: " + res.statusCode);
    }
};
let printGetLongResult = (error: Error, res: any): void => {
    if (error) return console.error(error);
    if (res.statusCode == 200) {
        for (let i = 0; i < res.body.length; i++) {
            let item = res.body[i];
            console.log(i + ": " + item);
        }
    } else {
        console.log("get long returned with status: " + res.statusCode);
    }
};
let printGetListResult = (error: Error, res: any): void => {
    if (error) return console.error(error);
    if (res.statusCode == 200) {
        console.log("short:");
        for (let i = 0; i < res.body.short.length; i++) {
            let item = res.body.short[i];
            console.log(i + ": " + item);
        }
        console.log();
        console.log("long");
        for (let i = 0; i < res.body.long.length; i++) {
            let item = res.body.long[i];
            console.log(i + ": " + item);
        }
    } else {
        console.log("get list returned with status: " + res.statusCode);
    }
};
let printAddResult = (error: Error, res: any): void => {
    if (error) return console.error(error);
    if (res.statusCode == 200) {
        console.log("add operation succesful");
    } else {
        console.log("add operation returned with status: " + res.statusCode);
    }
};
let printDeleteResult = (error: Error, res: any): void => {
    if (error) return console.error(error);
    if (res.statusCode == 200) {
        console.log("delete operation succesful");
    } else {
        console.log("delete operation returned with status: " + res.statusCode);
    }
};

let get = (flag?: string): void => {
    if (flag && flag === "-s") {
        needle.get(url + "api/short", printGetShortResult);
    } else if(flag && flag === "-l") {
        needle.get(url + "api/long", printGetLongResult);
    } else {
        needle.get(url + "api/list", printGetListResult);
    }
};

let add  = (flag: string, item: string): void => {
    if (flag === "-s") {
        needle.post(url + "api/short", {item: item}, printAddResult);
    } else {
        needle.post(url + "api/long", {item: item}, printAddResult);
    }
};
let rm  = (flag: string, pos: number): void => {
    if (flag === "-s") {
        needle.delete(url + "api/short/" + pos, null, printDeleteResult);
    } else {
        needle.delete(url + "api/long/" + pos, null, printDeleteResult)
    }
};

// parse arguments
let arg2 = process.argv[2];
if (!arg2 || arg2 != "ls" && arg2 != "add" && arg2 != "rm") {
    console.log(help)
} else {
    let arg3 = process.argv[3], arg4 = process.argv[4], arg5 = process.argv[5];
    if (arg2 === "ls") {
        if (arg3 && arg3 === "-s" && !arg4) {
            get("-s");
        } else if (arg3 && arg3 === "-l" && !arg4) {
            get("-l");
        } else if (!arg3) {
            get();
        } else {
            console.log(help);
        }
    } else if (arg2 === "add") {
        if (arg3 && arg3 === "-s" && arg4 && typeof arg4 === "string" && !arg5) {
            add("-s", arg4);
        } else if (arg3 && arg3 == "-l" && arg4 && typeof arg4 === "string" && !arg5) {
            add("-l", arg4);
        } else {
            console.log(help);
        }
    } else if (arg2 === "rm") {

        if (arg3 && arg3 === "-s" && arg4 && typeof Number(arg4) === "number" && !arg5) {
            rm("-s", Number(arg4));
        } else if (arg3 && arg3 == "-l" && arg4 && typeof Number(arg4) === "number" && !arg5) {
            rm("-l", Number(arg4));
        } else {
            console.log(help);
        }
    } else {
        console.log(help);
    }
}
