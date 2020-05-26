#!/bin/bash
if [[ -z ${GITHUB_TOKEN} ]]
then
    echo "must define the environment variable GITHUB_TOKEN, try: 'GITHUB_TOKEN : \$\{\{ secrets.GITHUB_TOKEN \}\}' in your workflow's main.yml"
    exit 1
fi

if [[ ${GITHUB_EVENT_NAME} != "pull_request" ]]
then
    echo "this action runs only on pull request events"
    exit 1
fi

github_pr_url=`echo -En ${GITHUB_EVENT_PATH} | jq '.pull_request.url'`
github_diff=`curl --request GET --url ${github_pr_url} --header "authorization: Bearer ${GITHUB_TOKEN}" --header "Accept: application/vnd.github.v3.diff"`
list_of_edited_files=`echo -En ${github_diff} | grep -E -- "\+\+\+ " | awk '{print $2}' | grep -Po -- "(?<=[ab]/).+(.py$)"`

line_length=`${LINE_LENGTH}:-130`
black --line_length ${line_length} ${list_of_edited_files}