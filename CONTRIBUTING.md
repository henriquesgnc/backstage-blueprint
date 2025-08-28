# Contributing

Thanks for your interest in contributing to Backstage Blueprint.

## Setup

1. Fork the repository
2. Clone your fork
3. Install dependencies:

```bash
yarn install
```

4. Start in development mode:

```bash
yarn dev
```

Or use Docker:

```bash
docker-compose up -d
```

## Making Changes

1. Create a branch from `main`
2. Make your changes
3. Run linters and tests:

```bash
yarn lint:all
yarn test:all
yarn prettier:check
```

4. If you modified the Docker build, verify it still works:

```bash
docker-compose down && docker-compose up --build -d
```

5. Commit using [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/):

```
feat(template): add GitLab CI template
fix(k8s-deploy): correct ECR login step
docs(readme): add GKE connection guide
```

## Pull Request Guidelines

- Keep PRs focused on a single change
- Reference any issues your PR addresses
- For new templates, include a complete `template.yaml` and `skeleton/`
- Update documentation if your change affects user-facing behavior

## Code Style

- TypeScript strict mode (enabled by default)
- Prettier for formatting (`@backstage/cli/config/prettier`)
- ESLint for linting (Backstage shared config)
- Use `yarn fix` for auto-fixes

## Adding Templates

Templates use Backstage's built-in scaffolder actions only (`fetch:template`, `publish:github`, `catalog:register`).

1. Create `templates/<name>/template.yaml` — follow the [Scaffolder template spec](https://backstage.io/docs/features/software-templates/)
2. Create `templates/<name>/skeleton/` with files to scaffold
3. Use `${{ values.xxx }}` for Nunjucks placeholders in skeleton files
4. For GitHub Actions expressions in skeletons, escape with: `${{ '{{' }} secrets.X {{ '}}' }}`
5. Register the template in `app-config.yaml` under `catalog.locations`

### Skeleton Guidelines

- Every skeleton must include `catalog-info.yaml` for Backstage auto-discovery
- Include `.github/workflows/` for CI/CD
- Keep skeletons minimal — users customize after scaffolding
- Default language is Node.js for Docker/K8s templates; Lambda supports Node.js and Python

## Questions?

Open a [discussion](https://github.com/henriquesgnc/backstage-blueprint/discussions) or an issue.
