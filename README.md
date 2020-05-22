# Readme

This is a github action that will run the [black python formatter](https://github.com/psf/black) on a PR, but only on the files changed in your PR. This helps avoid situations where one runs the formatter on an old code base and gets hundreds of files with warnings and hints.

## Installation

To install, create a GitHub Actions Workflow:

```yaml
name: Black

# Run action on PRs to master
on:
  pull_request:
    branches: [ master ]

jobs:
  suggest:
    runs-on: ubuntu-latest

    steps:
      # Checks-out your repository under $GITHUB_WORKSPACE, so that black can inspect it
      - uses: actions/checkout@v2
      - uses: rgasper/python-black-pull-request-action@master
        env:
          GITHUB_TOKEN : ${{ secrets.GITHUB_TOKEN }}
```

## Configuration

By default, runs black with all default configurations except for `--line-length 130`, because 88 characters feels a bit small. This can be changed by assigning the argument in the Workflow.

```yaml
    etc...
      - uses: rgasper/python-black-pull-request-action@master
        env:
          GITHUB_TOKEN : ${{ secrets.GITHUB_TOKEN }}
        with:
          line-length: 1000 # please don't do this
```
