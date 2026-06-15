---
description: "This rule provides base guidelines for writing new code in Python projects."
alwaysApply: true
---

## General Principles

- **Readability is the top requirement** — prioritize ease of
  reading over ease of writing.
- **Maintain consistency within the project** — don't mix different
  styles.
- **Use tool defaults** unless explicitly overridden by these
  conventions.
- Keep code predictable, simple, and explicit.

---

### Line length

- Hard limit: 80 characters (enforced by formatter/linter).

### File length

- Target maximum file length: ~500 lines.

### Quotes and strings

- Prefer single quotes (`quote-style = "single"` in Ruff formatter).
- Use f-strings for interpolation.

---

## Naming Conventions

| Element                | Convention            |
| ---------------------- | --------------------- |
| Variables, functions   | `snake_case`          |
| Classes, exceptions    | `PascalCase`          |
| Module-level constants | `UPPER_SNAKE_CASE`    |
| Private members        | `_leading_underscore` |

---

## Type Usage

- Annotate function parameters and return types.
- Prefer inference for local variables when the type is obvious.
- Prefer built-in generics (`list[int]`, `dict[str, str]`).
- Avoid `Any` — use `object` and narrow with `isinstance` when the
  type is truly unknown.

---

## Function Structure

- Ideal function size: 25–50 lines.
- Prefer early returns over deep nesting.
- Limit function parameters to ~4–5. When more are needed, group them
  into a dataclass or options object.

```python
# Correct — options object keeps the signature clean
@dataclass(frozen=True)
class CreateUserOptions:
    name: str
    email: str
    age: int
    role: UserRole

def create_user(options: CreateUserOptions) -> User:
    ...

# Avoid — too many positional parameters
def create_user(name: str, email: str, age: int, role: UserRole) -> User:
    ...
```

```python
# Correct — early return, flat structure
def process_order(order: Order) -> Result:
    if order.is_cancelled:
        return Result.skip('cancelled')

    if not order.items:
        return Result.error('empty order')

    total = sum(item.price for item in order.items)
    return Result.ok(total)

# Avoid — deep nesting
def process_order(order: Order) -> Result:
    if not order.is_cancelled:
        if order.items:
            total = sum(item.price for item in order.items)
            return Result.ok(total)
        else:
            return Result.error('empty order')
    else:
        return Result.skip('cancelled')
```

---

## Async

- Prefer `async`/`await` for asynchronous code.
- Do not swallow exceptions silently.
- Use exception chaining (`raise ... from exc`).
- Never call blocking/synchronous I/O inside an `async def` — offload
  to a thread pool (`asyncio.to_thread`) or use an async-native library.

```python
# Correct — exception chaining
try:
    data = await fetch_remote(url)
except httpx.HTTPError as exc:
    raise ServiceUnavailableError(f'upstream failed: {url}') from exc

# Avoid — original traceback is lost
try:
    data = await fetch_remote(url)
except httpx.HTTPError:
    raise ServiceUnavailableError('upstream failed')
```

```python
# Correct — non-blocking file read
contents = await asyncio.to_thread(Path('data.csv').read_text)

# Avoid — blocks the event loop
contents = Path('data.csv').read_text()  # inside async def
```

---

## Testing

- Name test files `test_<module>.py`.
- One logical assertion per test when practical.
- Prefer fixtures over repeated setup code.
- Use descriptive names that encode the scenario and expectation:
  `test_<unit>__<state>__<expected_behavior>`.

```python
# Correct — intent is immediately clear
def test_get_user__when_exists__returns_user_data():
    ...

def test_get_user__when_missing__raises_not_found():
    ...

# Avoid — vague, says nothing about the scenario
def test_get_user():
    ...

def test_get_user_2():
    ...
```

---

## Best Practices

- Use `is None` / `is not None`.
- Avoid commented-out code.
- Comments should explain _why_, not what.
- Prefer timezone-aware datetimes.
- Raise specific exception types.

```python
# Correct
if user is None:
    raise ValueError('user must not be None')

created_at = datetime.now(tz=timezone.utc)

# Avoid
if not user:          # falsy check — fails on empty string, 0, etc.
    raise Exception()  # too broad, no message

created_at = datetime.now()  # naive datetime, no timezone
```

---

## Constants and Enumerations

- Avoid magic numbers and strings — promote to named constants.
- Use `enum.Enum` for fixed sets of values. Prefer explicit values
  when the enum is persisted or API-facing.

```python
# Correct
DEFAULT_TIMEOUT_SECONDS = 5
MAX_RETRIES = 3

# Avoid — meaning is unclear at the call site
await client.get(url, timeout=5)
```

```python
from enum import Enum

class Status(str, Enum):
    PENDING = 'pending'
    APPROVED = 'approved'
    REJECTED = 'rejected'
```