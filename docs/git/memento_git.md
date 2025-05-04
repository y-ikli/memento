# Git Tutorial & Practical Use Cases

This tutorial provides a structured guide to Git, covering basic commands, advanced features, and practical scenarios commonly encountered in software development.

---

## 📋 Table of Contents

1. [Basic Setup](#1-basic-setup)
2. [Initializing & Cloning Repositories](#2-initializing--cloning-repositories)
3. [Basic Workflow](#3-basic-workflow)
4. [Branching & Merging](#4-branching--merging)
5. [Working with Remote Repositories](#5-working-with-remote-repositories)
6. [Undoing Changes](#6-undoing-changes)
7. [Stashing Work](#7-stashing-work)
8. [Rebasing & Fixing Commits](#8-rebasing--fixing-commits)
9. [Handling Merge Conflicts](#9-handling-merge-conflicts)
10. [Tags & Releases](#10-tags--releases)
11. [Inspecting & Debugging](#11-inspecting--debugging)
12. [Working with Multiple Repositories](#12-working-with-multiple-repositories)
13. [Practical Use Cases](#13-practical-use-cases)

---

## 1. Basic Setup

Before using Git, configure your name and email:

```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

Check your configuration:

```bash
git config --list
```

---

## 2. Initializing & Cloning Repositories

### Initialize a New Repository

```bash
git init
```

Creates a new Git repository in the current directory.

### Clone an Existing Repository

```bash
git clone <repository_url>
```

Copies a remote repository to your local machine.

---

## 3. Basic Workflow

### Check Status

```bash
git status
```

Shows changed files and the current branch.

### Add Changes to Staging

```bash
git add <file>  # Add a specific file
git add .       # Add all changes
```

### Commit Changes

```bash
git commit -m "Commit message"
```

Saves changes locally.

### View Commit History

```bash
git log --oneline --graph --decorate --all
```

---

## 4. Branching & Merging

### Create a New Branch

```bash
git branch new-feature
```

Creates a new branch called `new-feature`.

### Switch Branch

```bash
git switch new-feature
```


### Create and Switch to a New Branch

```bash
git switch -c new-feature
```
### Push the New Branch to the Remote Repository
```bash
git push -u origin feature-xyz
```
To avoid specifying -u on every push, configure Git to automatically set up tracking for new branches:

```bash
git config --global push.autoSetupRemote always
```
With this configuration, after creating and switching to a new branch, you can simply use git push, and Git will automatically set up the upstream tracking. 
### Merge Branches

```bash
git switch main
git merge new-feature
```

Merges `new-feature` into `main`.

### Delete a Branch

```bash
git branch -d new-feature
```

---

## 5. Working with Remote Repositories

### View Remote Repositories

```bash
git remote -v
```

### Fetch Changes from Remote

```bash
git fetch
```

### Pull Changes (Fetch + Merge)

```bash
git pull origin main
```

### Push Changes to Remote

```bash
git push origin main
```

---

## 6. Undoing Changes

### Undo Unstaged Changes

```bash
git checkout -- <file>
```

Resets a file to the last committed version.

### Reset Staged Changes

```bash
git reset HEAD <file>
```

Removes file from staging but keeps changes.

### Undo Last Commit (Keep Changes)

```bash
git reset --soft HEAD~1
```

### Undo Last Commit (Lose Changes)

```bash
git reset --hard HEAD~1
```

---

## 7. Stashing Work

### Save Uncommitted Changes

```bash
git stash
```

### List Stashes

```bash
git stash list
```

### Restore Stashed Changes

```bash
git stash pop
```

---

## 8. Rebasing & Fixing Commits

### Rebase a Branch

```bash
git switch feature-branch
git rebase main
```

Applies `feature-branch` commits on top of `main`.

### Squash Commits (Interactive Rebase)

```bash
git rebase -i HEAD~3
```

Allows combining commits.

### Amend Last Commit

```bash
git commit --amend -m "New commit message"
```

---

## 9. Handling Merge Conflicts

When a conflict occurs:

1. Git will show conflicting files. Open them and manually fix the conflicts.
2. After resolving, stage the fixed files:

   ```bash
   git add <file>
   ```

3. Continue the merge:

   ```bash
   git merge --continue
   ```

   or

   ```bash
   git rebase --continue
   ```

---

## 10. Tags & Releases

### Create a Tag

```bash
git tag -a v1.0 -m "Version 1.0"
```

### Push Tags to Remote

```bash
git push origin --tags
```

### Delete a Tag

```bash
git tag -d v1.0
git push origin --delete v1.0
```

---

## 11. Inspecting & Debugging

### Show File Changes in a Commit

```bash
git show <commit-hash>
```

### See Differences Between Branches

```bash
git diff main feature-branch
```

### Blame (Find Who Changed a Line)

```bash
git blame <file>
```

---

## 12. Working with Multiple Repositories

### Add a New Remote Repository

```bash
git remote add upstream <repo-url>
```

### Fetch and Merge from Another Repository

```bash
git fetch upstream
git merge upstream/main
```

---

## 13. Practical Use Cases

### Collaborative Feature Development

**Scenario**: Multiple developers are working on different aspects of a new feature.

**Solution**:

1. **Create a Feature Branch**:

   ```bash
   git checkout -b feature-branch
   ```

2. **Push the Branch to Remote**:

   ```bash
   git push -u origin feature-branch
   ```

3. **Developers Work on Their Parts**:

   Each developer pulls the branch and commits their changes.

4. **Merge Feature Branch into Main**:

   ```bash
   git checkout main
   git merge feature-branch
   ```

---

### Managing Diverged Branches

**Scenario**: Your local branch and the remote branch have diverged.

**Solution**:

1. **Fetch Latest Changes**:

   ```bash
   git fetch origin
   ```

2. **Rebase Your Changes**:

   ```bash
   git rebase origin/main
   ```

   Resolve any conflicts and continue:

   ```bash
   git add <resolved-files>
   git rebase --continue
   ```

---

### Cleaning Up Commit History

**Scenario**: You have multiple small commits that you want to combine into one.

**Solution**:

1. **Interactive Rebase**:

   ```bash
   git rebase -i HEAD~n
   ```

   Replace `n` with the number of commits to review.

2. **In the Editor**:

   Change `pick` to `squash` for commits you want to combine.

3. **Finalize Commit Message**:

   Edit the commit message as desired, then save and exit.

---

### Undoing Changes

**Scenario**: You want to discard changes or reset files.

**Solutions**:

- **Discard Changes in Working Directory**:

  ```bash
  git checkout -- <file>
  ```

- **Unstage a File**:

  ```bash
  git reset HEAD <file>
  ```

- **Reset to a Previous Commit**:

  ```bash
  git reset --hard <commit-hash>
  ```

  *Caution*: This will erase uncommitted changes.

---

### Using Git Tags for Releases

**Scenario**: Marking a specific commit as a release point.

**Solution**:

1. **Create a Tag**:

   ```bash
   git tag -a v1.0 -m "Release version 1.0"
   ```

2. **Push Tags to Remote**:

   ```bash
   git push origin v1.0
   ```

---

### Cherry-Picking Specific Commits

**Scenario**: Apply a specific commit from one branch to another.

**Solution**:

1. **Checkout Target Branch**:

   ```bash
   git checkout main
   ```

2. **Cherry-Pick Commit**:

   ```bash
   git cherry-pick <commit-hash>
   ```

---

### Finding Bug-Introducing Commits

**Scenario**: Identify the commit that introduced a bug.

**Solution**:

1. **Start Bisect**:

   ```bash
   git bisect start
   git bisect bad   # Current commit is bad
   git bisect good <commit-hash>   # Known good commit
   ```

2. **Test Commits**:

   Git will checkout commits between good and bad. Test each and mark as good or bad:

   ```bash
   git bisect good
   # or
   git bisect bad
   ```

3. **Reset Bisect**:

   ```bash
   git bisect reset
   ```

---

### Working with Submodules

**Scenario**: Include another Git repository within your project.

**Solution**:

1. **Add Submodule**:

   ```bash
   git submodule add https://github.com/example/repo.git path/to/submodule
   ```

2. **Initialize and Update Submodules**:

   ```bash
   git submodule update --init --recursive
   ```

3. **Cloning Repository with Submodules**:

   ```bash
   git clone --recursive https://github.com/your/repo.git
   ```

---

## Tips & Tricks

### Recovering from Mistakes

**Scenario**: You made a mistake and need to revert to a previous state.

**Solution**:

```bash
git reflog
# Find the commit before the mistake
git reset --hard HEAD@{index}
```

### Amending the Last Commit

**Scenario**: You want to modify the last commit.

**Solution**:

```bash
# Make your changes
git add .
git commit --amend
```

*Note*: Avoid amending commits that have been pushed to shared branches.

---

**End of Tutorial**









Author : Younes IKLI  
Last update : 2025-05-04
