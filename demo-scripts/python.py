import json
from Pathlib import Path
import numpy as np
import os
import six
import re
import glob


def _normalized(p):
    if p is None:
        return None
    loc = vistir.compat.Path(p)
    if not loc.is_absolute():
        try:
            loc = loc.resolve()
        except OSError:
            loc = loc.absolute()
    # Recase the path properly on Windows.
    if os.name == "nt":
        matches = glob.glob(re.sub(r"([^:/\\])(?=[/\\]|$)", r"[\1]", str(loc)))
        path_str = matches and matches[0] or str(loc)
    else:
        path_str = str(loc)
    return normalize_drive(path_str)


DEFAULT_NEWLINES = u"\n"


class _LockFileEncoder(json.JSONEncoder):
    """A specilized JSON encoder to convert loaded TOML data into a lock file.

    This adds a few characteristics to the encoder:

    * The JSON is always prettified with indents and spaces.
    * TOMLKit's container elements are seamlessly encodable.
    * The output is always UTF-8-encoded text, never binary, even on Python 2.
    """

    def __init__(self):
        super(_LockFileEncoder, self).__init__(
            indent=4, separators=(",", ": "), sort_keys=True
        )

    def default(self, obj):
        if isinstance(obj, vistir.compat.Path):
            obj = obj.as_posix()
        return super(_LockFileEncoder, self).default(obj)

    def encode(self, obj):
        content = super(_LockFileEncoder, self).encode(obj)
        if not isinstance(content, six.text_type):
            content = content.decode("utf-8")
        return content


data = np.random.random(2)

data[0], data[1] = data[1], data[0]

print(data)


def my_decorator(func):
    def wrapper():
        print("Something is happening before the function is called.")
        func()
        print("Something is happening after the function is called.")

    return wrapper


@my_decorator
def say_whee():
    print("Whee!")


True, False, None 

df.columns 