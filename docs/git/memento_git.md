# Git Tutorial & Practical Use Cases

This tutorial provides a structured guide to Git, covering basic commands, advanced features, and practical scenarios commonly encountered in software development.

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

**Initialize a New Repository**

```bash
git init
```

Creates a new Git repository in the current directory.

**Clone an Existing Repository**

```bash
git clone <repository_url>
```

Copies a remote repository to your local machine.

---

## 3. Basic Workflow

**Check Status**

```bash
git status
```

Shows changed files and the current branch.

**Add Changes to Staging**

```bash
git add <file>  # Add a specific file
git add .       # Add all changes
```

**Commit Changes**

```bash
git commit -m "Commit message"
```

Saves changes locally.

**View Commit History**

```bash
git log --oneline --graph --decorate --all
```

---

## 4. Branching & Merging

**Create a New Branch**

```bash
git branch new-feature
```

Creates a new branch called `new-feature`.

**Switch Branch**

```bash
git switch new-feature
```


**Create and Switch to a New Branch**

```bash
git switch -c new-feature
```
**Push the New Branch to the Remote Repository**
```bash
git push -u origin feature-xyz
```
To avoid specifying -u on every push, configure Git to automatically set up tracking for new branches:

```bash
git config --global push.autoSetupRemote always
```
With this configuration, after creating and switching to a new branch, you can simply use git push, and Git will automatically set up the upstream tracking. 

**Merge Branches**

```bash
git switch main
git merge new-feature
```

Merges `new-feature` into `main`.

**Delete a Branch**

```bash
git branch -d new-feature
```

---

## 5. Working with Remote Repositories

- View connected remote repositories (e.g., GitHub, GitLab)
```bash
git remote -v
```
This command shows which remote repositories your local repository is connected to. For example, it might show the URL for GitHub or GitLab.

- Fetch changes from the remote repository without merging
```bash
git fetch
```
The git fetch command retrieves the latest updates from the remote repository but does not merge them into your local branch. It's useful to inspect what has changed on the remote before deciding to merge.

- Pull changes (Fetch + Merge)
```bash
git pull origin main
```
This command is a combination of git fetch and git merge. It fetches the latest updates from the main branch of the remote repository and automatically merges them into your current local branch.

- Push changes to the remote repository
```bash
git push origin main
```
The git push command pushes your local commits to the remote repository, making your changes available to others or deploying them.

---

## 6. Undoing Changes

**Reset Staged Changes**

```bash
git reset HEAD <file>
```
This command removes a file from the staging area but leaves the changes in the working directory, allowing you to unstage a file without losing any modifications.

**Undo Last Commit (Keep Changes)**

```bash
git reset --soft HEAD~1
```
This command undoes the last commit but keeps the changes in your working directory and staging area. It's useful when you want to amend or rework the changes without losing them.

**Undo Last Commit (Lose Changes)**

```bash
git reset --hard HEAD~1
```
This command completely removes the last commit, including the changes in the working directory. Use it with caution as it will permanently delete the commit and any associated changes.

---

## 7. Stashing Work

**Save Uncommitted Changes**

```bash
git stash
```

**List Stashes**

```bash
git stash list
```

**Restore Stashed Changes**

```bash
git stash pop
```

---

## 8. Rebasing & Fixing Commits

**Rebase a Branch**

```bash
git switch feature-branch
git rebase main
```

Applies `feature-branch` commits on top of `main`.

**Squash Commits (Interactive Rebase)**

```bash
git rebase -i HEAD~3
```

Allows combining commits.

**Amend Last Commit**

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

**Create a Tag**

```bash
git tag -a v1.0 -m "Version 1.0"
```

**Push Tags to Remote**

```bash
git push origin --tags
```

**Delete a Tag**

```bash
git tag -d v1.0
git push origin --delete v1.0
```

---

## 11. Inspecting & Debugging

**Show File Changes in a Commit**

```bash
git show <commit-hash>
```

**See Differences Between Branches**

```bash
git diff main feature-branch
```

**Blame (Find Who Changed a Line)**

```bash
git blame <file>
```

---

**12. Working with Multiple Repositories**

### Add a New Remote Repository

```bash
git remote add upstream <repo-url>
```

**Fetch and Merge from Another Repository**

```bash
git fetch upstream
git merge upstream/main
```

---

## 13. Practical Use Cases

**Collaborative Feature Development**

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

Last update : 2025-05-04T17:55:36Z
