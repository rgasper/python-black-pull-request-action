FROM python:3-slim

RUN apt update && apt -y upgrade
RUN apt install -y curl jq build-essential

RUN pip install black

COPY run_black_on_git_diff_adds.sh /run_black_on_git_diff_adds.sh

ENTRYPOINT ["/run_black_on_git_diff_adds.sh"]
