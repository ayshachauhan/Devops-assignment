# 🚀 DevOps Assignment: Single GitHub Actions Workflow for Multi-Environment React Application

## 📌 Scenario

You are given a simple React application.

The application:

- Uses environment variables (e.g. `REACT_APP_ENVIRONMENT`)
- Needs to be built and containerized using Docker
- Must support three environments: **Development (dev)**, **Staging (stage)**, and **Production (prod)**

Your task is to design and implement a **single GitHub Actions workflow** that:

1. Detects the branch
2. Sets environment-specific variables
3. Builds a multi-stage Docker image
4. Tags the image correctly
5. Pushes it to Docker Hub

---

## 🎯 Objective

Create a CI pipeline that behaves differently depending on the branch:

| Branch Name | Environment | Docker Tag Format     |
|-------------|-------------|-----------------------|
| `develop`   | dev         | `dev-<short-sha>`     |
| `staging`   | stage       | `stage-<short-sha>`   |
| `main`      | prod        | `prod-<short-sha>`    |

---

## 📂 About the Application

- **Framework:** React 18 (Create React App)
- **Environment Variable:** `REACT_APP_ENVIRONMENT` — displayed on the page to indicate which environment is active
- **Scripts:**
  - `npm install` — install dependencies
  - `npm start` — run the dev server on port 3000
  - `npm run build` — create a production build in the `build/` directory

### App Preview

![App Preview](screenshots/app-preview.png)

### Project Structure

```
react-env-app/
├── public/
│   └── index.html
├── src/
│   ├── App.js          # Reads and displays REACT_APP_ENVIRONMENT
│   └── index.js        # Entry point
├── .gitignore
└── package.json
```

---

## 📝 Tasks

### Task 1 — Dockerfile

Write a **multi-stage Dockerfile** for this application.

**Requirements:**

- **Stage 1 (Build):** Use a Node.js base image to install dependencies and build the app
- **Stage 2 (Serve):** Use an Nginx base image to serve the built static files
- The `REACT_APP_ENVIRONMENT` variable must be configurable at **build time** (hint: `ARG`)

---

### Task 2 — GitHub Actions Workflow

Create a **single workflow file** (`.github/workflows/ci.yml`) that does the following:

**Trigger:**

- Runs on push to `develop`, `staging`, and `main` branches

**Steps:**

1. **Checkout** the repository
2. **Detect** which branch triggered the workflow
3. **Set environment variables** based on the branch:

   | Branch    | `REACT_APP_ENVIRONMENT` |
   |-----------|-------------------------|
   | `develop` | `development`           |
   | `staging` | `staging`               |
   | `main`    | `production`            |

4. **Build** the Docker image
   - Pass `REACT_APP_ENVIRONMENT` as a build argument
   - Tag the image as: `<dockerhub-username>/react-env-app:<env>-<short-sha>`
5. **Login** to Docker Hub using GitHub Secrets
6. **Push** the image to Docker Hub

---

### Task 3 — GitHub Secrets

Configure the following secrets in your GitHub repository:

| Secret Name         | Description                |
|---------------------|----------------------------|
| `DOCKER_USERNAME`   | Your Docker Hub username   |
| `DOCKER_PASSWORD`   | Your Docker Hub password or access token |

---

## ✅ Expected Deliverables

- [ ] A working `Dockerfile` in the project root
- [ ] A single workflow file at `.github/workflows/ci.yml`
- [ ] Docker Hub secrets configured in the repo
- [ ] Successful pipeline runs on all three branches with correctly tagged images on Docker Hub

---

## 💡 Hints

- Use `github.ref_name` or `github.ref` to detect the branch in GitHub Actions
- Use `github.sha` and shell substring to get the short SHA (first 7 characters)
- Use `docker/login-action` and `docker/build-push-action` or plain `docker` CLI commands — your choice
- CRA only embeds environment variables prefixed with `REACT_APP_` at **build time**, not runtime

---

## 📚 Resources

- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [Docker Multi-Stage Builds](https://docs.docker.com/build/building/multi-stage/)
- [Create React App — Environment Variables](https://create-react-app.dev/docs/adding-custom-environment-variables/)
