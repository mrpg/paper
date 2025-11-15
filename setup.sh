#!/usr/bin/env bash

set -euo pipefail

rm LICENSE README.md setup.sh

curl -sLO "https://creativecommons.org/licenses/by-sa/4.0/legalcode.txt"
mv legalcode.txt LICENSE
echo "28a9529c7d0bb4dc51f4bf5c116a3d16ef247a052f7591466768ddf563fd1cf5  LICENSE" |
    sha256sum -c --quiet

cat <<EOF > README.md
# Paper

Compile with PDFLaTeX and BibTeX (on Linux and macOS, just run \`make\`).

*This repository is based on [paper](https://github.com/mrpg/paper) (commit $(git rev-parse HEAD | head -c7)).*

## License

Everything in this repository is licensed under [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/), or (at your option) any later version. See \`LICENSE\` for details. Note that there is **absolutely no warranty**.
EOF

rm -rf .git

git init .
git add .
git status

echo "Setup complete."
