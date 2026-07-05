---
paths:
    - "*.py"
---

# Python Docstrings

For functions that are more substantial than a one-liner helper function use a Google-style docstring. This docustring should at a minimum describe what the function does in simple English.

When creating a docstring there should be a newline after and before the closing three comments.

For substantial functions include documentation related to the parameters and return object.

An example:

```python
import re

def parse_file_for_frank(file_path: str) -> bool:
    """
    Function to check if the name "Frank" is in the contents of a file.
    """
    try:
        with open(file_path, "r") as file_to_open:
            file_content = file_to_open.read()
    except Exception as err:
        print(f"Error! {err}")
    
    return bool(re.search(r"Frank", file_content))
```
