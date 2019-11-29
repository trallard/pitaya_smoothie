# -*- coding: utf-8 -*-
import base64
import fnmatch
import glob
import hashlib
import io
import json
import operator
import os
import re
import sys

import six
import toml
import tomlkit
import vistir

from first import first

import pipfile
import pipfile.api

from .cmdparse import Script
import hola

from .environments import (
    PIPENV_DEFAULT_PYTHON_VERSION,
    PIPENV_IGNORE_VIRTUALENVS,
    PIPENV_MAX_DEPTH,
    PIPENV_PIPFILE,
    PIPENV_PYTHON,
    PIPENV_TEST_INDEX,
    PIPENV_VENV_IN_PROJECT,
    is_in_virtualenv,
)
from .utils import (
    cleanup_toml,
    convert_toml_outline_tables,
    find_requirements,
    get_canonical_names,
    get_url_name,
    get_workon_home,
    is_editable,
    is_installable_file,
    is_star,
    is_valid_url,
    is_virtual_environment,
    looks_like_dir,
    normalize_drive,
    pep423_name,
    proper_case,
    python_version,
    safe_expandvars,
)


def _normalized(p):
    if p is None:
        return None
    loc = vistir.compat.Path(p)
    if not loc.is_absolute():
        try:
            loc = loc.resolve()
        except OSError:
            loc = loc.absolute()
    # Recase the path properly on Windows. From https://stackoverflow.com/a/35229734/5043728
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


def preferred_newlines(f):
    if isinstance(f.newlines, six.text_type):
        return f.newlines
    return DEFAULT_NEWLINES


if PIPENV_PIPFILE:
    if not os.path.isfile(PIPENV_PIPFILE):
        raise RuntimeError("Given PIPENV_PIPFILE is not found!")

    else:
        PIPENV_PIPFILE = _normalized(PIPENV_PIPFILE)
# (path, file contents) => TOMLFile
# keeps track of pipfiles that we've seen so we do not need to re-parse 'em
_pipfile_cache = {}


class Sublime(sublime.task):
    def run(self, edit):
        sel
