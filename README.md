# Backstage Blueprint

[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![Backstage](https://img.shields.io/badge/backstage-1.42.1-6963DE?logo=data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdCb3g9IjAgMCAyNCAyNCI+PHBhdGggZmlsbD0iI2ZmZiIgZD0iTTEyIDJMNCA3djEwbDggNSAxMC02VjdMMTIgMnptMCAzLjVMMTguNSA4djIuNUwxMiAxM2wtNi41LTIuNVY4TDEyIDUuNXpNNi41IDEydjIuNUwxMiAxN2w1LjUtMi41VjEyeiIvPjwvc3ZnPg==)](https://backstage.io)
[![Docker](https://img.shields.io/badge/docker-compose%20up-2496ED?logo=docker)](https://docs.docker.com/compose/)
[![Node](https://img.shields.io/badge/node-20%20%7C%2022-339933?logo=nodedotjs)](https://nodejs.org)

A **Backstage developer portal blueprint** with 7 production-ready software templates. Scaffold repositories, deploy to Kubernetes (raw manifests or Helm), build and push Docker images to ECR or Docker Hub, deploy AWS Lambda functions, create Terraform modules, and publish documentation sites — all from a single `docker-compose up`.

## Architecture

```
┌──────────────────────────────────────────────┐
│           Backstage (port 3000)               │
│                                              │
│  ┌──────────┐ ┌──────────┐ ┌──────────┐     │
│  │ Create   │ │ K8s      │ │ K8s      │     │
│  │ Repo     │ │ Manifest │ │ Helm     │     │
│  └──────────┘ └──────────┘ └──────────┘     │
│  ┌──────────┐ ┌──────────┐ ┌──────────┐     │
│  │ Docker   │ │ Lambda   │ │ Terraform│     │
│  │ Build    │ │ Deploy   │ │ Module   │     │
│  └──────────┘ └──────────┘ └──────────┘     │
│  ┌──────────┐                                │
│  │ TechDocs │                                │
│  └──────────┘                                │
│                                              │
│  Scaffolder → GitHub → Actions → Deploy      │
└──────────────────────────────────────────────┘

Template Flow:
  Developer clicks "Create"
         │
         ▼
  Scaffolder form (parameters)
         │
         ├──► fetch:template     →  Renders skeleton from templates/
         │
         ├──► publish:github     →  Creates GitHub repository
         │
         ├──► catalog:register   →  Registers component in Backstage catalog
         │
         └──► GitHub Actions     →  CI/CD pipeline (build, test, deploy)
```

## Who is this for?

This project is for:

- **Platform engineering teams** starting an Internal Developer Portal
- **DevOps/SRE teams** adopting Backstage for service scaffolding and catalog
- **Engineering leaders** looking for a practical Backstage starter with working templates
- **Teams that want ready-to-use software templates** without writing custom scaffolder actions
- **Developers who want to test Backstage locally** with a single `docker-compose up`

## What this project is not

This is **not** a fully hardened enterprise Backstage deployment. It is a practical **blueprint** for getting started quickly with Backstage, software templates, GitHub integration, and developer portal workflows.

For production environments, you should replace:
- Guest authentication → real auth provider (GitHub, Okta, Azure AD, etc.)
- In-memory SQLite → persistent PostgreSQL database
- Local TechDocs publisher → S3, GCS, or external storage
- Disabled permissions → Backstage permission policies
- Personal Access Token → GitHub App credentials when possible
- Local Docker Compose → Kubernetes deployment with ingress

## Key Features

| Feature | Description |
|---------|-------------|
| **7 Production Templates** | Repo, K8s (raw + Helm), Docker Build, Lambda, Terraform, TechDocs |
| **GitHub Integration** | Scaffolded repos include CI/CD workflows (GitHub Actions) |
| **Multi-Registry** | Docker templates support AWS ECR and Docker Hub |
| **Multi-Runtime** | Lambda template supports Node.js 20.x and Python 3.12 |
| **Multi-Cloud** | Terraform template supports AWS, GCP, Azure |
| **K8s: 2 Deploy Options** | Raw K8s manifests or Helm chart — your choice |
| **Built-in Actions Only** | No custom scaffolder actions — uses `fetch:template`, `publish:github`, `catalog:register` |
| **Auto-Catalog Registration** | Every scaffolded repo registers itself via `catalog-info.yaml` |
| **Docker Compose Ready** | One-command setup: `docker-compose up -d` |
| **Guest Authentication** | No login required for local development |

## Templates

### 1. Create Repository

Scaffold a new GitHub repository with language boilerplate and CI pipeline.

| Parameter | Type | Values |
|-----------|------|--------|
| `repoName` | string | Repository name |
| `description` | string | Short description |
| `language` | enum | Node.js, Python, Go |
| `visibility` | enum | public, private |

**What you get:** `catalog-info.yaml`, `.github/workflows/ci.yaml` (lint + test), `README.md`, boilerplate source

### 2. Deploy to Kubernetes (Raw Manifests)

Scaffold an app with K8s manifests and CI/CD that builds, pushes, and deploys.

| Parameter | Type | Values |
|-----------|------|--------|
| `appName` | string | Application name |
| `port` | integer | Container port (default: 3000) |
| `replicas` | integer | Pod replicas (1-10) |
| `registry` | enum | AWS ECR, Docker Hub |

**What you get:** `k8s/*.yaml`, `Dockerfile`, CI/CD workflow, Node.js app, `catalog-info.yaml`

### 3. Deploy to Kubernetes (Helm)

Scaffold an app with a complete Helm chart and CI/CD pipeline. **Industry standard** for K8s package management.

| Parameter | Type | Values |
|-----------|------|--------|
| `appName` | string | Application + chart name |
| `port` | integer | Container port (default: 3000) |
| `replicas` | integer | Pod replicas (1-10) |
| `registry` | enum | AWS ECR, Docker Hub |

**What you get:** `Chart.yaml`, `values.yaml`, `templates/` (deployment + service), `Dockerfile`, CI/CD workflow (`helm upgrade --install`), `catalog-info.yaml`

### 4. Build & Push Docker Image

Scaffold an app with Dockerfile and CI/CD to build and push images.

| Parameter | Type | Values |
|-----------|------|--------|
| `appName` | string | App + image name |
| `port` | integer | Container port (default: 3000) |
| `registry` | enum | AWS ECR, Docker Hub |

**What you get:** `Dockerfile`, `build-push.yaml` workflow, Node.js app, `catalog-info.yaml`

### 5. Deploy AWS Lambda

Scaffold a serverless function with CI/CD pipeline to AWS Lambda.

| Parameter | Type | Values |
|-----------|------|--------|
| `functionName` | string | Lambda function name |
| `runtime` | enum | Node.js 20.x, Python 3.12 |
| `memory` | enum | 128–2048 MB |
| `timeout` | integer | 1–900 seconds |

**What you get:** `lambda/index.js` or `handler.py`, CI/CD workflow (zip → deploy), `catalog-info.yaml`

### 6. Terraform Module

Scaffold a Terraform module with full CI/CD (fmt → validate → plan → apply).

| Parameter | Type | Values |
|-----------|------|--------|
| `moduleName` | string | Module name |
| `provider` | enum | AWS, GCP, Azure |
| `backend` | enum | S3, GCS, AzureRM |

**What you get:** `main.tf`, `variables.tf`, `outputs.tf`, `versions.tf`, CI/CD workflow (3 jobs), `README.md` with usage docs, `catalog-info.yaml`

### 7. Documentation Site (TechDocs)

Scaffold a MkDocs documentation site rendered by Backstage TechDocs.

| Parameter | Type | Values |
|-----------|------|--------|
| `docName` | string | Site name |
| `description` | string | Description |

**What you get:** `mkdocs.yml`, `docs/index.md`, `docs/getting-started.md`, `docs/architecture.md`, `catalog-info.yaml`

## Repository Structure

```
backstage-blueprint/
├── templates/
│   ├── create-repo/                    # Template 1: GitHub repo scaffolding
│   ├── k8s-deploy/                     # Template 2: K8s raw manifests
│   ├── k8s-deploy-helm/                # Template 3: K8s with Helm chart
│   ├── docker-build/                   # Template 4: Docker build & push
│   ├── lambda/                         # Template 5: AWS Lambda deploy
│   ├── terraform/                      # Template 6: Terraform module
│   └── techdocs/                       # Template 7: Documentation site
├── packages/
│   ├── app/                            # Backstage frontend (React)
│   └── backend/                        # Backstage backend (Node.js)
├── catalog/components.yaml             # Manually registered components
├── docker-compose.yml                  # Single-service Backstage
├── .env.example                        # Environment variables
├── app-config.yaml                     # Backstage configuration
└── catalog-info.yaml                   # Self-registration entity
```

## Quick Start

### Prerequisites

- Docker and Docker Compose
- [GitHub Personal Access Token](https://github.com/settings/tokens) with `repo` + `workflow` scopes

### 1. Clone and configure

```bash
git clone https://github.com/henriquesgnc/backstage-blueprint
cd backstage-blueprint
cp .env.example .env
```

Edit `.env` and set your `GITHUB_TOKEN` and `GITHUB_ORG`.

### 2. Start

```bash
docker-compose up -d
```

### 3. Access

| Service | URL |
|---------|-----|
| Backstage | http://localhost:3000 |

### 4. Create your first component

1. Open http://localhost:3000
2. Go to **Create** → choose a template
3. Fill in the form, click **Create**
4. Repo is created, component appears in catalog

## Configuration

### Environment Variables

| Variable | Required | Description |
|----------|----------|-------------|
| `GITHUB_ORG` | yes | GitHub organization or username for repo creation |
| `GITHUB_TOKEN` | yes | GitHub PAT with `repo` + `workflow` scopes |
| `BACKSTAGE_BACKEND_SECRET` | yes | Any random string |
| `NODE_OPTIONS` | yes | `--no-node-snapshot`
| `NODE_OPTIONS` | yes | `--no-node-snapshot` |

### GitHub Secrets (per repo)

| Template | Required Secrets |
|----------|-----------------|
| `create-repo` | None |
| `k8s-deploy` | `AWS_ROLE_ARN` or `DOCKER_USERNAME`/`TOKEN`, `KUBECONFIG` |
| `k8s-deploy-helm` | `AWS_ROLE_ARN` or `DOCKER_USERNAME`/`TOKEN`, `KUBECONFIG` |
| `docker-build` | `AWS_ROLE_ARN` or `DOCKER_USERNAME`/`TOKEN` |
| `lambda` | `AWS_ROLE_ARN`, `LAMBDA_ROLE_ARN` |
| `terraform` | `AWS_ROLE_ARN` (per provider) |
| `techdocs` | None |

## Commands

```bash
docker-compose up -d       # Start
docker-compose down        # Stop
docker-compose logs -f     # View logs
```

### Development (without Docker)

```bash
yarn install
yarn dev
```

## Development vs Production

This blueprint is optimized for **local development and evaluation** by default.

| Configuration | Development (default) | Production |
|---------------|----------------------|------------|
| Auth | Guest (no login) | GitHub, Okta, Azure AD, etc. |
| Database | SQLite in-memory | PostgreSQL (persistent) |
| TechDocs | Local publisher | S3, GCS, or external storage |
| Permissions | Disabled | Backstage permission policies |
| GitHub Auth | Personal Access Token | GitHub App credentials |
| Secrets | `.env` file | GitHub Secrets / Vault / SSM |
| Deployment | Docker Compose | Kubernetes with ingress |

To harden for production:
```bash
# Set real auth provider in app-config.yaml
# Switch to PostgreSQL in app-config.production.yaml
# Configure external TechDocs storage
# Enable and configure permissions
# Use OIDC for GitHub Actions instead of PAT where possible
```

## Customization

### Adding a New Template

1. Create `templates/<name>/template.yaml`
2. Create `templates/<name>/skeleton/` with files to scaffold
3. Register it in `app-config.yaml` under `catalog.locations`
4. Use `${{ values.xxx }}` for Nunjucks placeholders
5. For GitHub Actions expressions in skeletons, escape with: `${{ '{{' }} secrets.X {{ '}}' }}`

### Connecting Real Infrastructure

- **ECR**: Set `AWS_ROLE_ARN` in repo secrets and use OIDC trust
- **Kubernetes**: Encode `~/.kube/config` as base64 → GitHub secret `KUBECONFIG`
- **Lambda**: Set `AWS_ROLE_ARN` + `LAMBDA_ROLE_ARN`
- **Docker Hub**: Set `DOCKER_USERNAME` + `DOCKER_TOKEN`

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines on setup, code style, and pull requests.

## References

- [Backstage Documentation](https://backstage.io/docs)
- [Backstage Scaffolder](https://backstage.io/docs/features/software-templates/)
- [Scaffolder Built-in Actions](https://backstage.io/docs/features/software-templates/builtin-actions)
- [Helm Documentation](https://helm.sh/docs/)
- [Terraform Documentation](https://developer.hashicorp.com/terraform/docs)

## License

MIT — See [LICENSE](LICENSE) for details.
