## Introduction to pytest
**What is pytest?**
- `pytest` is a testing framework for Python that simplifies the process of writing and running tests.
- It is widely used due to its easy syntax, rich feature set, and powerful plugins.
- It supports fixtures, parametrization, assertions, and integrates easily with continuous integration (CI) tools.

## Prerequisites
**Before starting, you’ll need:**
- Basic understanding of Python programming.
- Installation of `pytest` (install via `pip install pytest`).
- Familiarity with writing basic Python functions and understanding unit tests.

## Basic pytest Usage
**Writing a Simple Test:**
- To get started, write a Python function that you want to test.
- Create a test function using the `test_` prefix so `pytest` can identify it as a test.

```python
# math_operations.py
def add(a, b):
    return a + b
```

**Creating a Test File:**
- Create a new file with the prefix `test_` (e.g., `test_math_operations.py`).

```python
# test_math_operations.py
from math_operations import add

def test_add():
    assert add(2, 3) == 5
```

- Run the tests with `pytest` by executing the following in the terminal:
```bash
$ pytest test_math_operations.py
```

**Test Output:**
- Pytest will run the tests and show output indicating whether the test passed or failed.

## Running pytest
**Running Tests from the Command Line:**
- Simply run `pytest` to find and execute all tests in the current directory and subdirectories.

```bash
$ pytest
```

**Specifying Tests to Run:**
- You can specify individual tests or files.
```bash
$ pytest test_math_operations.py::test_add
```

**Running Tests with Verbose Output:**
- Use the `-v` flag to get more detailed output.
```bash
$ pytest -v
```

## Assertions in pytest
**Basic Assertions:**
- `pytest` uses Python's built-in `assert` statement for verifying conditions.

```python
def test_add():
    result = add(2, 3)
    assert result == 5
```

**Custom Error Messages:**
- You can add custom error messages to assertions for better debugging.
```python
def test_add():
    result = add(2, 3)
    assert result == 5, f"Expected 5, but got {result}"
```

## Fixtures
**What Are Fixtures?**
- Fixtures are used for setting up test environments or initializing data that is shared across multiple tests.

**Creating a Fixture:**
- Use the `@pytest.fixture` decorator to define a fixture.

```python
import pytest

@pytest.fixture
def sample_data():
    return {"name": "John", "age": 30}
```

**Using Fixtures in Tests:**
- You can pass fixtures as arguments to test functions.

```python
def test_name(sample_data):
    assert sample_data["name"] == "John"
```

**Running Tests with Fixtures:**
- When you run the test, pytest will automatically provide the fixture's return value.

## Parametrization
**What is Parametrization?**
- Parametrization allows running a single test function with multiple sets of inputs and expected results.

**Using `@pytest.mark.parametrize`:**
- You can define multiple sets of parameters for a test function.

```python
import pytest

@pytest.mark.parametrize("a, b, expected", [(2, 3, 5), (4, 5, 9), (0, 0, 0)])
def test_add(a, b, expected):
    assert add(a, b) == expected
```

- This will run the `test_add` three times with different values for `a`, `b`, and `expected`.

## pytest Markers
**Using Markers for Custom Labels:**
- Markers are used to label or categorize tests.

**Marking Tests:**
- Use `@pytest.mark.<marker>` to assign a marker to a test function.
```python
import pytest

@pytest.mark.slow
def test_add():
    assert add(2, 3) == 5
```

**Running Tests with a Marker:**
- You can run tests with specific markers using the `-m` flag.
```bash
$ pytest -m slow
```

## Handling Test Failures
**Handling Expected Failures:**
- Use `@pytest.mark.xfail` to mark a test that you expect to fail (it will not count as a failure).

```python
@pytest.mark.xfail
def test_divide_by_zero():
    assert 1 / 0 == 0
```

**Skipping Tests:**
- Use `@pytest.mark.skip` to skip tests explicitly.
```python
@pytest.mark.skip
def test_skipped():
    assert 2 + 2 == 4
```

**Skipping Tests Based on Conditions:**
- Use `@pytest.mark.skipif` to skip tests if a condition is met.
```python
@pytest.mark.skipif(sys.platform == "win32", reason="Doesn't work on Windows")
def test_linux_specific_feature():
    assert 1 == 1
```

## Test Discovery
**Test Discovery:**
- By default, `pytest` will automatically discover all files that start with `test_` and contain functions that begin with `test_`.

**Changing Test Discovery Rules:**
- You can change the default test discovery rules using the `--python-files` and `--python-functions` options.

```bash
$ pytest --python-files="*.py" --python-functions="check_*"
```

## Running Tests in Parallel
**Running Tests in Parallel with `pytest-xdist`:**
- You can speed up test execution by running tests in parallel using the `pytest-xdist` plugin.

**Install the Plugin:**
```bash
$ pip install pytest-xdist
```

**Running Tests in Parallel:**
```bash
$ pytest -n 4
```
- This will run the tests using 4 processes.

## pytest Plugins
**Useful pytest Plugins:**
- `pytest-cov`: Provides code coverage reports.
- `pytest-mock`: Simplifies mocking in tests.
- `pytest-django`: A plugin for testing Django applications.

**Installing Plugins:**
```bash
$ pip install pytest-cov
```

**Using Plugins:**
```bash
$ pytest --cov=your_module test_your_module.py
```

## Conclusion
**Key Takeaways:**
- `pytest` simplifies testing by using Python's `assert` statement and providing rich features like fixtures, parametrization, and plugins.
- TDD with `pytest` helps write clean, reliable, and maintainable tests.
- Pytest’s ability to run tests in parallel and extend functionality with plugins makes it powerful for larger test suites.

**Next Steps:**
- Practice writing tests with `pytest` for your projects.
- Learn more about advanced `pytest` features like fixtures, mock testing, and working with external resources.
- Explore additional `pytest` plugins to improve your testing workflow.

Last update : 2025-05-04T19:34:16Z
