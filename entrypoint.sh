#!/bin/bash
# TODO make this actually work, probably just convert into pythong
list_of_edited_files=`./git_diff_to_get_list_of_edited_files`
black ${list_of_edited_files}