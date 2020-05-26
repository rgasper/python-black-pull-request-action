#!/bin/bash
if [[ ${GITHUB_EVENT_NAME} != "pull_request" ]]
then
    echo "this action runs only on pull request events"
    exit 1
fi

github_pr_url=`echo -En ${GITHUB_EVENT_PATH} | jq '.pull_request.url'`
github_diff=`curl --request GET --url ${github_pr_url} --header "authorization: Bearer ${GITHUB_TOKEN}" --header "Accept: application/vnd.github.v3.diff"`
list_of_edited_files=`echo -En ${github_diff} | grep -E -- "\+\+\+ " | awk '{print $2}' | grep -Po -- "(?<=[ab]/).+(.py$)"`

black ${list_of_edited_files}