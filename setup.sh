#!/usr/bin/env bash

set -euo pipefail

rm LICENSE README.md setup.sh

curl -sO "https://creativecommons.org/licenses/by/4.0/legalcode.txt"
mv legalcode.txt LICENSE
echo "9ba9550ad48438d0836ddab3da480b3b69ffa0aac7b7878b5a0039e7ab429411  LICENSE" |
    sha256sum -c --quiet

cat <<EOF > README.md
# Paper

Compile with PDFLaTeX and BibTeX (on Linux and macOS, just run \`make\`).

*This repository is based on [paper](https://github.com/mrpg/paper) (commit $(git rev-parse HEAD | head -c7)).*

## License

Everything in this repository is licensed under the Creative Commons Attribution 4.0 International ([CC BY 4.0](https://creativecommons.org/licenses/by/4.0/)) license. See \`LICENSE\` for details. Note that there is **absolutely no warranty**.
EOF

rm -rf .git

git init .
git add .
git status

echo "Setup complete."
