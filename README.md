## Developer Setup

The following assume the terminal is in the root directory of the package.

  1. Create a virtual environment
      * In the root directory: `python3 -m venv .venv`
      * Activate the virtual environment: `source .venv/bin/activate`
  1. Install the package, with `dev` dependencies, in editable mode: `pip install --editable ".[dev]"`.
      * Only if above fails with missing packages:
          * `pip install --upgrade setuptools`
          * `pip install --upgrade build`
  1. Enable `pre-commit`: `pre-commit install`
      * `pre-commit run --all-files` will force the check on all files otherwise it will only check the files in the index (i.e., those that are part if the commit)

  To uninstall the package, `pip uninstall project0`. To deactivate the virtual environment: `deactivate`. The entry point for the CLI is `verify`.

## Testing

`pytest` should work as usual if you add the `test` folder as an argument (TODO: expand and explain). The `vscode` test section does need to be configured. All that means is that you select the _test beaker_ on the left, and when it asks to _Configure_ choose `pytest` and the `test` directory.
