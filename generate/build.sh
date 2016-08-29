#!/usr/bin/env bash
echo -e "\e[1;33m[🛠  Pre-commit hook]\e[0;1m Compiling static HTML\e[0m"
ruby $(dirname $0)/../../generate/generate.rb && git add $(dirname $0)/../../index.html
