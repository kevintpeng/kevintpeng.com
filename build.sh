#!/usr/bin/env bash
echo \x1b[1;32m[ 🛠 Pre-commit hook ] \x1b[0;1m Compiling static HTML\x1b[0m
ruby generate/generate.rb && git add index.html && git commit -m "generated index.html" && open index.html
