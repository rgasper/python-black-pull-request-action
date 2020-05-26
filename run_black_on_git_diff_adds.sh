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

set -x

github_pr_url=`jq '.pull_request.url' ${GITHUB_EVENT_PATH}`
# github pr url sometimes has leading and trailing quotes
github_pr_url=`sed -e 's/^"//' -e 's/"$//' <<<"$github_pr_url"`
github_diff=`curl --request GET --url ${github_pr_url} --header "authorization: Bearer ${GITHUB_TOKEN}" --header "Accept: application/vnd.github.v3.diff"`
list_of_edited_files=`echo -En ${github_diff} | grep -E -- "\+\+\+ " | awk '{print $2}' | grep -Po -- "(?<=[ab]/).+(.py$)"`

if [[ -z "${LINE_LENGTH}" ]]; then
    line_length=130
else
    line_length="${LINE_LENGTH}"
fi

black --line-length ${line_length} --check ${list_of_edited_files}