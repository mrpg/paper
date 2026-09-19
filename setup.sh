#!/usr/bin/env bash

set -euo pipefail

cd -- "$(dirname -- "${BASH_SOURCE[0]}")"

git_available=false
template_commit=
if command -v git >/dev/null 2>&1; then
    git_available=true
    template_commit=$(git rev-parse --short=7 HEAD 2>/dev/null || true)
fi

rm LICENSE README.md setup.sh template-preview.png
rm -rf -- .git

curl -sO "https://creativecommons.org/licenses/by/4.0/legalcode.txt"
mv legalcode.txt LICENSE
echo "9ba9550ad48438d0836ddab3da480b3b69ffa0aac7b7878b5a0039e7ab429411  LICENSE" |
    if command -v sha256sum >/dev/null 2>&1; then
        sha256sum -c --quiet
    else
        shasum -a 256 -c --quiet
    fi

if [[ -n "$template_commit" ]]; then
    template_source=" (commit $template_commit)"
else
    template_source=
fi

cat <<EOF > README.md
# Paper

Compile with PDFLaTeX and BibTeX (on Linux and macOS, just run \`make\`).

*This repository is based on [paper](https://github.com/mrpg/paper)${template_source}.*

## License

Everything in this repository is licensed under the Creative Commons Attribution 4.0 International ([CC BY 4.0](https://creativecommons.org/licenses/by/4.0/)) license. See \`LICENSE\` for details. Note that there is **absolutely no warranty**.
EOF

if "$git_available"; then
    git init .
    git add .
    git status
fi

echo "Setup complete."
