#!/usr/bin/env python3
from decimal import Decimal
from typing import Iterable, List
import sys


def get_unstripped_lines_from_stdin_or_file() -> List[str]:
    if len(sys.argv) == 1:
        return sys.stdin.readlines()

    else:
        with open(sys.argv[1]) as f:
            return f.readlines()


unstripped_lines = get_unstripped_lines_from_stdin_or_file()
lines: Iterable[str] = (line.strip() for line in unstripped_lines)
print(sum(map(Decimal, lines)))
