import sys
"""Small unix-like script that takes the current i3 workspace as an argument,
and returns on stdout the following i3 workspace. It works like this:

4  6  5   <- "secondary" ones, can be switched to
1  3  2   <- main ones, seen on boot
"""
assert len(sys.argv) > 1, "Missing first argument (the current workspace name)"
current_workspace_name = sys.argv[1]

TRANSLATE_DICT = {
"1": "4",
"2": "5",
"3": "6",
"4": "1",
"5": "2",
"6": "3",
}

if current_workspace_name not in TRANSLATE_DICT:
    print("Couldn't find correct new workspace from" +
        "current workspace {}".format(current_workspace_name) + 
        "using TRANSLATE_DICT {}".format(TRANSLATE_DICT))
    exit(1)
else:
    new_workspace_name = TRANSLATE_DICT[current_workspace_name]
    print(new_workspace_name)
