## Introduction to GitHub Actions
**What is GitHub Actions?**
- GitHub Actions is a CI/CD and automation service provided by GitHub.
- It allows you to automate workflows for tasks such as building, testing, deploying, and more.
- Workflows are defined in YAML files and are triggered by specific GitHub events (e.g., push, pull request, issue creation).

## Prerequisites
**Before starting, you’ll need:**
- A GitHub account and access to a repository.
- Basic knowledge of Git and GitHub.
- Familiarity with YAML syntax.

## Creating a GitHub Actions Workflow
**What is a Workflow?**
- A workflow is an automated process that runs in response to an event in your repository.
- It is defined in a `.github/workflows/` directory within your repository.

**Example of a Simple Workflow:**
```yaml
name: Simple CI

on: [push]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Set up Python
        uses: actions/setup-python@v2
        with:
          python-version: '3.8'
      - name: Install dependencies
        run: |
          python -m pip install --upgrade pip
          pip install -r requirements.txt
      - name: Run tests
        run: |
          pytest
```
- **name:** The name of the workflow.
- **on:** Defines the event that triggers the workflow (e.g., `push`, `pull_request`).
- **jobs:** Contains the different jobs that will run as part of the workflow.
- **steps:** The individual actions to be executed in each job.

## Workflow Triggers
**Common Triggers:**
- `push`: Triggered when changes are pushed to the repository.
- `pull_request`: Triggered when a pull request is opened or updated.
- `workflow_dispatch`: Manually triggered via the GitHub UI.
- `schedule`: Triggered on a scheduled basis (e.g., cron jobs).

```yaml
on:
  push:
    branches:
      - main
  pull_request:
    branches:
      - main
  workflow_dispatch:
```

**Scheduled Triggers:**
- Example for running a job on a schedule:
```yaml
on:
  schedule:
    - cron: '0 0 * * *'
```
- This runs the workflow every day at midnight.

## Jobs and Runners
**What is a Job?**
- A job is a set of steps that execute on the same runner.
- Jobs are executed in parallel by default, but you can control the order with the `needs:` keyword.

**Setting Up a Job:**
```yaml
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Build Project
        run: make build
```

**Specifying Runners:**
- You can specify the operating system for your runner (`ubuntu-latest`, `windows-latest`, `macos-latest`).

```yaml
jobs:
  build:
    runs-on: ubuntu-latest
```

**Job Dependencies (Using `needs`):**
- You can define job dependencies so that one job waits for another to finish.
```yaml
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Build Project
        run: make build

  deploy:
    runs-on: ubuntu-latest
    needs: build
    steps:
      - uses: actions/checkout@v2
      - name: Deploy Project
        run: make deploy
```

## Steps in a Job
**Actions:**
- Actions are reusable pieces of code in a step.
- GitHub provides a marketplace with a wide variety of actions (e.g., `actions/checkout`, `actions/setup-python`).

**Example of an Action:**
```yaml
steps:
  - uses: actions/checkout@v2
```
- This action checks out your repository so the subsequent steps can access it.

**Running Shell Commands:**
- You can run shell commands in steps using `run`:
```yaml
steps:
  - name: Run tests
    run: |
      pip install -r requirements.txt
      pytest
```

## Caching Dependencies
**Using Cache in Workflows:**
- GitHub Actions supports caching dependencies between workflow runs to speed up builds.
```yaml
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Cache Python dependencies
        uses: actions/cache@v2
        with:
          path: ~/.cache/pip
          key: ${{ runner.os }}-python-${{ hashFiles('**/requirements.txt') }}
          restore-keys: |
            ${{ runner.os }}-python-
      - name: Install dependencies
        run: pip install -r requirements.txt
```

**Cache Key Explanation:**
- The `key` is based on the hash of `requirements.txt`, which ensures cache is refreshed when dependencies change.

## Environment Variables and Secrets
**Environment Variables:**
- You can set environment variables at the job or step level.
```yaml
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - name: Set environment variable
        run: echo "MY_VAR=some_value" >> $GITHUB_ENV
```

**Using Secrets:**
- Secrets are stored securely in GitHub and can be accessed during workflows.
- Store secrets in the GitHub repository settings under `Settings > Secrets`.

```yaml
jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - name: Deploy to Server
        run: ./deploy.sh
        env:
          API_KEY: ${{ secrets.API_KEY }}
```

## Matrix Builds
**Running Tests Across Multiple Configurations:**
- Use a matrix strategy to run jobs across multiple configurations (e.g., different versions of Python, Node.js, etc.).
```yaml
jobs:
  build:
    runs-on: ubuntu-latest
    strategy:
      matrix:
        python-version: [3.7, 3.8, 3.9]
    steps:
      - uses: actions/checkout@v2
      - name: Set up Python
        uses: actions/setup-python@v2
        with:
          python-version: ${{ matrix.python-version }}
      - name: Install dependencies
        run: pip install -r requirements.txt
      - name: Run tests
        run: pytest
```

**Matrix Example Explanation:**
- This matrix will run the `build` job for Python versions 3.7, 3.8, and 3.9.

## Notifications and Alerts
**Sending Notifications:**
- GitHub Actions allows you to send notifications to Slack, email, etc., using third-party actions or webhooks.

**Example: Sending Slack Notification on Success:**
```yaml
jobs:
  notify:
    runs-on: ubuntu-latest
    steps:
      - uses: rtCamp/action-slack-notify@v2
        with:
          status: ${{ job.status }}
          webhook-url: ${{ secrets.SLACK_WEBHOOK_URL }}
```

## Manual Triggers (workflow_dispatch)
**Triggering Workflows Manually:**
- You can define workflows that are manually triggered via the GitHub UI or API.
```yaml
on:
  workflow_dispatch:
```
- This allows you to trigger the workflow on demand rather than in response to a push or pull request.

## Conclusion
**Key Takeaways:**
- GitHub Actions enables powerful automation workflows directly within your GitHub repository.
- Workflows are defined in `.github/workflows/` and consist of jobs, steps, and triggers.
- You can run jobs on multiple environments, cache dependencies, and manage secrets securely.
- Use matrix builds to test across multiple configurations and manual triggers for on-demand workflows.

**Next Steps:**
- Create a `.github/workflows/` directory and start defining simple workflows.
- Explore GitHub Actions Marketplace to add pre-built actions to your workflows.
- Use caching, matrix builds, and environment variables to optimize and customize your workflows.

Last update : 2025-05-04T19:41:43Z
