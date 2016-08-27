#!/usr/bin/env bash
echo -e "\e[1;32m[🛠  Pre-commit hook]\e[0;1m Compiling static HTML\e[0m"
ruby ../../generate/generate.rb && git add ../../index.html
