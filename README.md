## Visual Studio Code Setup

The only supported _integrated development environment_ (IDE) is [Visual Studio Code](https://code.visualstudio.com) (vscode). [Download and install vscode](https://code.visualstudio.com/download) if it is not already installed on the system being used. Become familiar with the [command line interface](https://code.visualstudio.com/docs/editor/command-line) for vscode's integrated terminal as it is very helpful.

Follow the [vscode python tutorial](https://code.visualstudio.com/docs/languages/python) to install [Python](https://www.python.org) and configure vscode for Python. Vscode will prompt to install additional extensions when it opens the project directory. If a prompt is not presented, then here are the recommended extensions (see `.vscode/extensions.json`):

  * [Microsoft Python](https://marketplace.visualstudio.com/items?itemName=ms-python.python)
  * [Microsoft Mypy Type Checker](https://marketplace.visualstudio.com/items?itemName=ms-python.mypy-type-checker)
  * [Astral Software Ruff](https://marketplace.visualstudio.com/items?itemName=charliermarsh.ruff)

## Developer Setup

Each project in the course is a Python package organized with a _src_ layout. All that means is that the package is in `src/project0` and the tests are in `test`. The dependencies for the package are defined in `./pyproject.toml`. This project file should not need to be edited except to add new package dependencies -- adding a dependency for this project or others is very unlikely to be needed.

Development takes place in a [Python virtual environment](https://docs.python.org/3/library/venv.html). The only supported virtual environment is venv. A virtual environment isolates this project from anything else installed on a system so that there are no conflicts between system level and package level dependencies. The instructions to setup a venv and install the project dependencies follow.

These steps assume the vscode integrated terminal is in the root directory of the package.

  1. Create a virtual environment
      * In the root directory: `python3 -m venv .venv`
      * Activate the virtual environment: `source .venv/bin/activate`
  1. Install the package, with `dev` dependencies, in editable mode: `pip install --editable ".[dev]"`.
      * Only if above fails with missing packages:
          * `pip install --upgrade setuptools`
          * `pip install --upgrade build`
  1. Enable `pre-commit`: `pre-commit install`

The project is now fully configured and everything is ready for development. The command `project0` on the terminal should print usage information (see `./pyproject.toml` under `scripts` to discover the entry point in the package for `project0`).

The project is installed by `pip` in the venv in _edit mode_. Edit mode means that `pip` is using the actual project files.  To uninstall the package from the venv, use the command `pip uninstall project0` -- should never need to uninstall for this course.

Be sure that the virtual environment is activated whenever working in the project from the terminal. In the integrated vscode terminal, there is a `.venv` preceding the terminal prompt. If that is not there, then activate the virtual environment from the project root directory: `source .venv/bin/activate`. To deactivate the virtual environment: `deactivate`.

## Pre-commit

[Pre-commit](https://pre-commit.com) is a tool to check files **before** committing them to the Git repository. Pre-commit runs with `git commit` on every file that is part of the commit. If all the files pass the checks, then the commit goes through. If any file fails any check, then the issues are reported on the terminal and the commit is rejected. The files need to be updated to resolve the issues and re-added to the commit in order for the commit to go through.

The checks performed by pre-commit are defined in `./.pre-commit-config.yaml` and summarized here:

  * Remove trailing whitespace on any line
  * Force files to end on a newline
  * Format check yaml files
  * Prevent large files from being added
  * Static check Python files for code smells (linting)
  * Reformat Python files to PEP standards
  * Type check Python files
  * Convert everything to Unix line encodings
  * Replace tabs with spaces

Formatting related checks that fail are automatically fixed, but the failures still abort the commit. Any updated file needs to be re-added to the commit and the commit needs to be run again. Linter and type check errors must be manually corrected. Detials for each failure are reported in the terminal.

File checks for commits may seem like an extra unnecessary step but studies have shown that these checks improve code quality and reduce defect rates. Although pre-commit runs automatically with `git commit`, it can be run manually too. To run manually, add all the files for the commit to the index, `git add <files>`, and then run pre-commit: `pre-commit run`. The command `pre-commit run --all-files` will check every file in the repository regardless of it being in the index for the commit.

## Type Annotations and Mypy

Pre-commit checks each Python file for type errors. For example, returning a `str` from a function that should return an `int` is a type error, as is assigning an `int` to a `str`.  Type error defects are easy to create in Python code and always seem to manifest at the absolute worst times.

[Mypy](https://mypy-lang.org) checks for type errors in all the Python files in the `src` directory and any file or directory that does not start with `test`. It relies on [type annotations](https://mypy.readthedocs.io/en/stable/builtin_types.html) in the Python code for the checks. On the surface, type annotations in Python appear to undermine some of Python's niceness, but the annotations greatly aid with maintaining, or working with, Python code.

Mypy is able to infer many types, but it does require annotations on function signatures and variable assignments when it is not able to infer the type in the assignment. The package dependencies include the `mypy` executable, so it can be run on the command line: `mypy --strict <file>`. The `--strict` flag is how it is configured in the project. The [Microsoft Mypy Type Checker](https://marketplace.visualstudio.com/items?itemName=ms-python.mypy-type-checker) extension (in the reccommended list) will flag Mypy errors in red in the editor and offer suggestions. Pre-commit can be run anytime as well to check the annotations (or lack thereof).

Class lectures and TA help sessinos will teach more about using type annotations and mypy.

## Testing

The only supported testing framework is [Pytest](https://pypi.org/project/pytest/). To run all tests, from the command line in the root folder type `pytest` followed by enter. All tests should fail. Vscode is configured by the Python extensions to integrate testing into its interface. That interface is the _test beaker_ in the left menu bar.

Click the beaker to open the testing pane. Click the _Configure Python Tests_ button. Choose the `pytest` framework. Choose the `./test` folder. Pytest will discover all tests in the `./test` folder and show them in the testing pane. From here, hovering over a test will present the play or debug options for the test. Double clicking the test will open the source file for the test.

 Individual tests can be run from the command line. `pytest --collect-only` gives the list of known tests. Here is an example of runing a specific test in this project:

 ```
 pytest -vv -s ./test/test_project0.py::test_given_goodinput_when_project0_then_match_pattern[who]
 ```
Try it out!

  * the `-vv` is verbose output
  * the `-s` includes any `print` output in the report
  * the `./test/test_project0.py` names the file where the test function is found
  * the `::test_given_goodinput_when_project0_then_match_pattern` names the function in the file
  * the `[who]` names the parameter to use for the test input.

The function in the example uses [@pytest.mark.parameterize](https://docs.pytest.org/en/7.1.x/how-to/parametrize.html) to list several inputs for the test to use. Parameterization is a great way to give the same test code several different inputs, and students are encouraged to use parameterization when writing tests.

## Test Driven Development

The best way do developed is with tests. Writing a test helps figure out the input, the computation, and the expected output. It also helps break seemingly overwhelming programming tasks into small manageable pieces defined by tests. _Test driven development_ (TDD) is the process of first writing a test for a new behavior in the code, running the test to see it fail (for whatever reason including missing definitions), and then writing code to make the test pass.

TDD makes programming such a nicer experience because it signals when the program is done, and it signals when the program is not working. It also provides immediate access to the debugger with failing input using the testing pane in vscode. Learning to write tests first and then code is an important part of the course.  It is also key to completing the programming projects in a timely manner. Write test. See test fail. Write code. Tackle one small part of the program at a time with each part starting with a test.

Tests written as part of developement belong in `test/test_project0.py`. These can be logically grouped using classes -- create a class with `Test` as a prefix, and then create functions in the class also prefixed by `test`.

## Project Pass-off

All the test files begining with `project_passoff` contain tests used to score submissions. These can be run anytime either in the testing pane or with `pytest test/test_passoff*` in the terminal. The suffix indicates the bucket the tests belong in. In this project, bucket 80 means that 80 points are awarded if **all tests in the bucket pass**, but bucket 100 means that 80 points come from bucket 80 and another 20 points come from bucket 100. If all tests pass in both buckets, then 100 points are awarded. Tests in a bucket have the same point value , `#tests/bucket_points`, so partial credit in each bucket is possible.

Projects in this course build on one another. That means that Project 2 relies on the code in Project 1.
Every project has a minimun bucket in order for the code to be _functional enough_ to be able to complete the next project. The minimun bucket is indicated in each project, and it means that all preceding buckets must pass all tests and all tests in the minimum bucket must pass too.

## Project Submission

Projects are submitted by pushing a commit to the `master` branch of the repository. **Warning**: be sure to add any new files that are part of the submission. Use `git status` and `git add` to add all files to the commit. After the commit, `git push` will submit. Multiple submissions are allowed.

A push on the `master` branch will kickoff the autograder on GitHub Classroom. In the classroom interface students can confirm their score (its the same tests run for pass-off) and inspect failing tests etc.

## What's next?

Open the `./test/project0.py` folder, read the comments, and start working on a solution!
