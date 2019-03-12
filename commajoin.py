#!/usr/bin/env python3

import sys

if len(sys.argv) != 2:
    print("Usage: newline or space separated string that should be made comma separated")

arr = sys.argv[1].split("\n")

print(", ".join(arr))


