# Memento Python 

This memento summarizes some native Python features with structured examples.


# Type Hints & Static Checking

Type hints help document your code and catch bugs early. Combined with tools like `mypy`, they enable static analysis without running the code.

## Basic Type Hints

```python
def double(x: int) -> int:
    return x * 2

def greet(name: str) -> str:
    return f"Hello, {name}"
```

---

## Hints for Collections

```python
from typing import List, Dict

def total(prices: List[float]) -> float:
    return sum(prices)

def extract_ids(data: List[Dict[str, int]]) -> List[int]:
    return [row["id"] for row in data]
```
- In first example prices are a list of floats.
- In the second example, data is expected to be a list of dictionaries.Each dictionary maps strings to integers 
This means you expect something like:
`[{"id": 1}, {"id": 2}, {"id": 3}]
`
---

## Optional, Union, Literal

```python
from typing import Optional, Union, Literal

def maybe_add(a: int, b: Optional[int]) -> int:
    return a + (b or 0)
```
???+ note "🔍 maybe_add explained"

- b is optional, meaning it can be int or None (Optional[int])
- If b is None, use 0 instead
- If b is an integer (e.g., 5), use it

```python
def handle_event(type: Union[str, int]) -> None:
    print(type)
```
???+ note "🔍 handle_event explained"

- type can be a str or an int
- The function returns nothing (None)

```python
def status_color(status: Literal["ok", "error", "warning"]) -> str:
    return {"ok": "green", "error": "red", "warning": "yellow"}[status]
```
???+ note "🔍 status_color explained"
- `status: Literal["ok", "error", "warning"]` restricts allowed values.
- Helps prevent bugs by allowing only specific strings.
- If you try another value, static checkers like `mypy` will raise an error.

!!! attention "Type Hints Are Static Only"
    Python does **not enforce types at runtime**.  
    Type hints are for **developers**, IDEs, and tools like `mypy` — they make your code safer and more readable but don’t stop bad values at runtime unless you add validation.   

---

## Typed Dicts 

```python
from typing import TypedDict

class Product(TypedDict):
    id: int
    price: float

def apply_discount(p: Product) -> float:
    return p["price"] * 0.9
```

???+ note "🔍 What is TypedDict?" - TypedDict allows you to define the structure of a dictionary using class-like syntax. - It’s perfect for describing JSON-like data, where keys and value types are known. - Fields are type-checked with tools like mypy, but at runtime it’s still just a dict.

---
## NamedTuples

```python
from typing import NamedTuple

class User(NamedTuple):
    id: int
    name: str
```

???+ note "🔍 NamedTuple explained"
    - Combines tuple immutability with named fields and type hints.
    - Values are **positionally fixed** and **read-only**.
    - Supports dot notation: `user.name`, like an object.
    
✅ Example:
```python
user = User(id=1, name="Alice")
print(user.name)  # ➜ Alice
```
- 🔒 NamedTuples are immutable — you can’t do `user.name = "Bob"`

---

## Run `mypy` to Check
mypy scan a python file and report any type violations based on annotations (e.g., using TypedDict, List[int], etc.).
```bash
mypy script.py
```
- It analyzes your code without running it.
- It checks if your type hints are correct.
- It helps prevent bugs early by catching issues like missing return types, wrong arguments, etc.

We can add a config file `mypy.ini` to enforce rules, It tells mypy:

- How strict to be
- What files or modules to include/exclude
- Whether to allow missing type hints
- Whether to treat certain errors as warnings
- Project-specific overrides

```ini
[mypy]
strict = True                   # Enables all strict checks (recommended!)
ignore_missing_imports = True   # Don’t fail on 3rd-party libraries with no stubs
disallow_untyped_defs = True    # Force you to type all function defs
warn_unused_ignores = True      # Warn if you ignore something unnecessarily
exclude = tests/                # Don't type-check test files
```

---
## Pydantic for Data Validation
- install latest pydantic v2
`pip install pydantic`

## 🔗 Resources

- [mypy Documentation](https://mypy.readthedocs.io/)
- [PEP 484 – Type Hints](https://peps.python.org/pep-0484/)
- [Python Typing Cheatsheet](https://mypy.readthedocs.io/en/stable/cheat_sheet_py3.html)
```
