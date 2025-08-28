# ${{ values.repoName }}

${{ values.description }}

## Getting Started

```bash
# Install dependencies{% if values.language == 'node' %}
npm install{% elif values.language == 'python' %}
pip install -r requirements.txt{% elif values.language == 'go' %}
go mod tidy{% endif %}

# Run locally{% if values.language == 'node' %}
npm run dev{% elif values.language == 'python' %}
python main.py{% elif values.language == 'go' %}
go run main.go{% endif %}

# Run tests{% if values.language == 'node' %}
npm test{% elif values.language == 'python' %}
pytest{% elif values.language == 'go' %}
go test ./...{% endif %}
```

## CI/CD

This repository uses GitHub Actions for CI. See `.github/workflows/ci.yaml`.
