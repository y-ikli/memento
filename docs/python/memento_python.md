# Memento Python

This memento summarizes some native Python features with structured examples.


## Type Hints & Static Checking

Type hints help document your code and catch bugs early. Combined with tools like `mypy`, they enable static analysis without running the code.

**Basic Type Hints**

```python
def double(x: int) -> int:
    return x * 2

def greet(name: str) -> str:
    return f"Hello, {name}"
```

---

**Hints for Collections**

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

**Optional, Union, Literal**

```python
from typing import Optional, Union, Literal

def maybe_add(a: int, b: Optional[int]) -> int:
    return a + (b or 0)
```
???+ note 

- b is optional, meaning it can be int or None (Optional[int])
- If b is None, use 0 instead
- If b is an integer (e.g., 5), use it

```python
def handle_event(type: Union[str, int]) -> None:
    print(type)
```
???+ note 

- type can be a str or an int
- The function returns nothing (None)

```python
def status_color(status: Literal["ok", "error", "warning"]) -> str:
    return {"ok": "green", "error": "red", "warning": "yellow"}[status]
```
???+ note 
- `status: Literal["ok", "error", "warning"]` restricts allowed values.
- Helps prevent bugs by allowing only specific strings.
- If you try another value, static checkers like `mypy` will raise an error.

!!! attention "Type Hints Are Static Only"
    Python does **not enforce types at runtime**.  
    Type hints are for **developers**, IDEs, and tools like `mypy` — they make your code safer and more readable but don’t stop bad values at runtime unless you add validation.   

---
**Other Special Types**

- `Any`: Indicates that a value can be of any type.
- `Union[T1, T2, ...]`: Used to indicate that a value can be one of several types.
- `Optional[T]`: A shorthand for `Union[T, None]`, meaning the value could be of type `T` or `None`.
- `Callable[[Arg1Type, Arg2Type], ReturnType]`: Represents a function or any other callable object with the specified argument types and return type.
- `TypeVar`: Used for creating generic types.

---
## TypedDict

```python
from typing import TypedDict

class Product(TypedDict):
    id: int
    price: float

def apply_discount(p: Product) -> float:
    return p["price"] * 0.9
```

???+ note 
- TypedDict allows you to define the structure of a dictionary using class-like syntax. - It’s perfect for describing JSON-like data, where keys and value types are known. - Fields are type-checked with tools like mypy, but at runtime it’s still just a dict.

---
## NamedTuples

```python
from typing import NamedTuple

class User(NamedTuple):
    id: int
    name: str
```

???+ note 
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

## mypy
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

## Pydantic
Pydantic is a powerful library that uses Python type hints to enforce data structure and validate inputs at runtime.

Basic Model:

```python
from pydantic import BaseModel

class User(BaseModel):
    id: int
    name: str
    is_active: bool = True
```

✅ Example:
```python
user = User(id="123", name="Alice")
print(user.id)  # ➜ 123 (auto-converted to int)
```

???+ note "Why use Pydantic?"
- Enforces types at runtime
- Converts compatible types (e.g., str ➜ int)
- Raises clear validation errors on failure


Field Constraints:

```python
from pydantic import BaseModel, Field

class Product(BaseModel):
    name: str = Field(..., min_length=2)
    price: float = Field(..., gt=0)
```

✅ Example:
```python
Product(name="Laptop", price=1000.0)  # ✅ Valid
Product(name="A", price=-10)          # ❌ ValidationError
```

???+ note "Field Constraints"
- `min_length=2`: name must be at least 2 characters
- `gt=0`: price must be greater than 0
- `Field(...)`: required with constraints

**Nested Models**

```python
class Address(BaseModel):
    city: str
    country: str

class Customer(BaseModel):
    name: str
    address: Address
```

✅ Example:
```python
cust = Customer(name="Bob", address={"city": "Paris", "country": "FR"})
```

???+ note "Nested Models"
- Nested BaseModels are validated recursively
- Great for structured data like JSON config or API payloads

---

**Custom Validation**

```python
from pydantic import validator

class Event(BaseModel):
    type: str
    payload: dict

    @validator("type")
    def must_be_known(cls, v):
        if v not in {"click", "view", "purchase"}:
            raise ValueError("Invalid event type")
        return v
```

✅ Example:
```python
Event(type="click", payload={})       # ✅
Event(type="unknown", payload={})     # ❌ ValidationError
```

???+ note "🔍 Custom Logic"
- Validators allow custom logic on fields
- Raise `ValueError` to reject bad input

---

**Tools like Pydantic**

Pydantic is powerful, but We might also consider:

- `TypedDict` → static-only, no runtime checks
- `attrs` → high-performance data classes with validation
- `marshmallow` → schema-based (de)serialization and validation
- `typeguard` → simple runtime type enforcement with decorators
- `Protobuf` → typed messages for streaming / microservices

---
## Data Contracts with Protobuf

For data engineers working with **microservices**, **streaming**, or **cross-language systems**, **Protocol Buffers (Protobuf)** provide a fast, strongly typed, and schema-first approach to data serialization.

What is Protobuf?

- Defines structured data with `.proto` schema files
- Generates code in multiple languages (Python, Go, Java…)
- Perfect for APIs, Kafka events, gRPC, and long-term data contracts

---

Defining a Schema (`.proto`):

```proto
syntax = "proto3";

message Event {
  int64 id = 1;
  string type = 2;
  string payload = 3;
}
```

- Define message structure
- Fields have fixed types and unique IDs
- Supports primitives, enums, nesting, repeated fields, etc.

---

Generating Python Code:

```bash
# Install
pip install protobuf

# Generate Python classes
protoc --python_out=. event.proto
```

This generates a Python class `Event` , we can import and use.

---

Using Generated Code:

```python
from event_pb2 import Event

event = Event(id=123, type="click", payload="{}")
print(event.type)         # ➜ click
print(event.SerializeToString())  # ➜ binary format
```

✅ Example: serialize the event and send it over a socket or Kafka.

---

Deserialization:

```python
data = event.SerializeToString()
```
On the receiving side:
```python
event2 = Event()
event2.ParseFromString(data)
print(event2.id)  # ➜ 123
```

- We can safely parse and validate the binary payload using the generated schema.
- If the payload doesn't match, it fails fast.

???+ note "Why Use Protobuf Instead of JSON?"
- Faster: compact binary format is smaller and faster than JSON
- Typed: strict field types prevent many bugs
- Evolvable: supports optional fields and versioning without breaking older clients

---
- Use `mypy-protobuf` to generate `.pyi` stub files for better IDE/type checker support:
    ```bash
    pip install mypy-protobuf
    protoc --python_out=. --mypy_out=. schema.proto
    ```

- Combine Protobuf messages with Kafka or gRPC for fast, safe communication.
- Avoid tight coupling: keep `.proto` files in shared versioned repos for teams.

---

## Python Documentation Generator
Pyment is a simple tool for generating and enhancing docstrings in Python. It supports multiple formats, including Google, NumPy, and reST. 
First, install Pyment using `pip`:

```bash
pip install pyment
```
To generate and initialize docstrings for your Python file(with google format), run the following command:
`pyment --init --format google <your-python-file.py>`

Generating Docstrings for Classes
Pyment can also generate docstrings for Python classes.

`pyment --init --class <your-python-file.py>`

Generate Docstrings for Entire Project
You can also generate docstrings for an entire project (all Python files) using Pyment.

`pyment --init --all`
This command will go through all Python files in the current directory and generate docstrings for functions, methods, and classes.

## match:
match statement: It’s used to match a value (expression) against several patterns.

Patterns: These are conditions that specify what data to match, such as literal values, variable bindings, and complex patterns (like sequences, mappings, or classes).

Basic Syntax:

```python

match value:
    case pattern1:
        # code if value matches pattern1
    case pattern2:
        # code if value matches pattern2
    case _:
        # code for any other case (wildcard)
```
**Why Use match Over if-elif?**
- Readability: match provides a clean, concise way to handle complex data structures and patterns.
- Flexibility: Supports powerful features like guards, destructuring, and multiple pattern matching.
- Maintainability: It's easier to extend and modify as the logic is more declarative and expressive than if-elif.
- In summary, match is a modern and robust alternative to if-elif chains for pattern matching, offering clearer, more maintainable code when working with complex data types.

```python
def traiter_message(message):
    match message:
        case {'type': 'texte', 'contenu': contenu}:  # Correspond au dictionnaire avec les clés 'type' et 'contenu'
            print(f"Message texte reçu: {contenu}")
        case {'type': 'image', 'url': url}:  # Correspond au dictionnaire avec les clés 'type' et 'url'
            print(f"Image reçue: {url}")
        case {'type': 'video', 'url': url, 'durée': durée}:  # Correspond au dictionnaire avec les clés 'type', 'url', et 'durée'
            print(f"Vidéo reçue: {url}, durée: {durée} secondes")
        case _:
            print("Type de message inconnu")
```
## Map and Reduce

`map()` and `reduce()` are **functional programming tools** in Python that allow concise **transformation** and **aggregation** of data collections.

---

🔹 `map(func, iterable)`

- Applies a function to **each item** in an iterable.
- Returns a new iterable (`map` object), often converted to a list.

Example with a Named Function:
```python
def square(x: int) -> int:
    return x * x

nums = [1, 2, 3, 4]
squares = list(map(square, nums))
print(squares)  # ➜ [1, 4, 9, 16]
#example with Lambda function
squares = list(map(lambda x: x**2, nums))
print(squares)  # ➜ [1, 4, 9, 16]
```

## Decorators
A decorator is a special type of function in Python that allows you to "decorate" or modify another function (or method) without changing its actual code. It allows you to add functionality to an existing function in a clean, readable way.
```python
def my_decorator(func):
    def wrapper():
        print("Something is happening before the function is called.")
        func()
        print("Something is happening after the function is called.")
    return wrapper

@my_decorator
def say_hello():
    print("Hello!")


```
**Common Built-in Decorators**
Python provides a few built-in decorators that are commonly used. Here are some examples:

**a. @staticmethod**
A staticmethod is a method that belongs to the class but doesn't require an instance of the class to be called. It does not have access to self (instance) or cls (class).
```python
class MyClass:
    @staticmethod
    def say_hello():
        print("Hello from a static method!")
```

**b. @classmethod**
A classmethod is a method that works with the class itself rather than instances. It takes cls as the first argument, which refers to the class.
```python
class MyClass:
    @classmethod
    def say_hello(cls):
        print(f"Hello from {cls}!")
```
**c. @property**
The @property decorator turns a method into a read-only property. Instead of calling it like a method, you access it like an attribute.
```python
class MyClass:
    def __init__(self, x):
        self._x = x

    @property
    def x(self):
        return self._x

```



Author : Younes IKLI
Last update : 2025-05-03
