#!/usr/bin/env python3

import os
import sys

def print_instructions():
    print("Finds english words containing a given substring")
    print("first arg should be a string")
    print("last arg can be flags:")
    print("  -b    Words beginning with arg1")
    print("  -e    Words ending with arg1")

if len(sys.argv) < 2:
    print_instructions()
    exit()

term = sys.argv[1]

wordsfile = open("words.txt", "r")
words = wordsfile.readlines()
matches = ""

if len(sys.argv) == 3 and sys.argv[2] == "-b":
    matches = [w.strip() for w in words if w.lower().startswith(term)]
elif len(sys.argv) == 3 and sys.argv[2] == "-e":
    matches = [w.strip() for w in words if w.lower().strip().endswith(term)]
else:
    matches = [w.strip() for w in words if w.lower().find(term) != -1]

print(", ".join(matches))


