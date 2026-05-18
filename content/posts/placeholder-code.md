+++
title = 'A Useful Python Pattern'
date = 2026-05-01T09:00:00Z
tags = ['python', 'programming']
+++

Using context managers for clean resource management:

```python
from contextlib import contextmanager

@contextmanager
def managed_resource(name):
    print(f"Acquiring {name}...")
    yield name
    print(f"Releasing {name}...")

with managed_resource("lock") as r:
    print(f"Using resource: {r}")
```

This ensures cleanup happens even if exceptions occur.