#!/usr/bin/env python3
'''endrend: a script to render endnotes in email

Turns endnotes in the form "[[endnote]]" to normal numbered endnotes.

Usage:
    endrend [options] < mail.txt > newmail.txt

Options:
    -p PREFIX, --prepend PREFIX  Prepend a string to each endnote number.
    -a SUFFIX, --append SUFFIX   Append a string to each endnote number.
    -s NUM, --start-at NUM       Start at this number. [default: 1]
    --help                       Show this screen and exit.
    --version                    Display version and exit.
'''

import sys
import re
from docopt import docopt
args = docopt(__doc__, version="0.1")

try:
    args["--start-at"] = int(args["--start-at"])
except:
    print("invalid start-at number: {} is not an integer!".format(args["--start-at"]))
    sys.exit(2)

if not args["--prepend"]:
    args["--prepend"] = ""

if not args["--append"]:
    args["--append"] = ""

def process_line(line, next_number, parens_open) -> ("lines to put at the end", "next_number", "parens_open"):
    if parens_open:

        # finish off the current endnote
        if "]]" in line:
            first_end, rest_of_line = line.split("]]", maxsplit=1)
            second_end, next_number, parens_open = process_line(rest_of_line, next_number, False)
            return (first_end + second_end, next_number, parens_open)

        # the whole line is an endnote
        else:
            return (line, next_number, True)

    else:

        # start a new endnote
        if "[[" in line:
            endnote_label = '[' + args["--prepend"] + str(next_number) + args["--append"] + ']'
            next_number += 1

            normal_text, rest_of_line = line.split("[[", maxsplit=1)
            sys.stdout.write(normal_text)
            sys.stdout.write(endnote_label)

            end, next_number, parens_open = process_line(rest_of_line, next_number, True)
            return ("\n\n" + endnote_label + ": " + end, next_number, parens_open)

        # the whole line contains no endnotes; just pass to stdout
        else:
            sys.stdout.write(line)
            return ("", next_number, parens_open)

end = ""
next_number = args["--start-at"]
parens_open = False
for line in sys.stdin:
    new_end, next_number, parens_open = process_line(line, next_number, parens_open)
    end += new_end
if end:
    sys.stdout.write(end)
