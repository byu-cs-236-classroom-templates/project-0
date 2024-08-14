After you have tested your code locally and verfied that it works you need to submit your code for grading.

To do this we are going to need to complete a couple of steps.
1. Create a branch
2. Submit a pull request
3. Merge the branch and close the pull request

Let's start by ensuring our actions are configured properly.

### Before you start
In your respository there should be a file at the following location:

```
/.github/workflows/classroom.yaml
```

The file should have the following contents:

```/.github/workflows/classroom.yaml
name: GitHub Classroom Workflow

on:
  pull_request:
    types:
      - closed

permissions:
  checks: write
  actions: read
  contents: read

jobs:
  build:
    name: Autograding
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: education/autograding@v1
```

If the file exists and has different content, please update it and replace the contents with the above block

### Make a branch

1. In your terminal run the following command:

```
git checkout -b passoff
```

Something to note here is that the name of the branch is changeable. In this case we named it "passoff". Your code will now be working on this new branch you made.

2. Make some small change to the code
This could be as simple as adding a comment
the run the following commands

```
git add .
git commit -m "added comment"
```

You now have a commit with new changes on the branch we just made

4. Run the following commands:

```
git checkout master
git merge passoff
```

This will change your branch to the master branch and merge in the change you just made
