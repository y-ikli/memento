# Memento Git
# Advanced Git Tutorial

This tutorial covers advanced Git features and workflows using real-world use cases, with diagrams to enhance understanding.

---

## **Table of Contents**

1. [Rewriting History with Rebase](#rewriting-history-with-rebase)
2. [Interactive Rebase for Cleaning Up Commits](#interactive-rebase-for-cleaning-up-commits)
3. [Stashing Work](#stashing-work)
4. [Using Git Tags for Releases](#using-git-tags-for-releases)
5. [Cherry-picking Commits](#cherry-picking-commits)
6. [Bisecting to Find a Bug](#bisecting-to-find-a-bug)
7. [Working with Submodules](#working-with-submodules)

---

## **Rewriting History with Rebase**

Use case: Integrating changes from the `main` branch into a feature branch without polluting the history with merge commits.

```bash
git checkout feature-branch
git fetch origin
git rebase origin/main
```

### Diagram:
![Rebase vs Merge](https://raw.githubusercontent.com/git-guides/images/main/rebase-vs-merge.png)

---

## **Interactive Rebase for Cleaning Up Commits**

Use case: Squash multiple small commits into one meaningful commit before merging.

```bash
git checkout feature-branch
git rebase -i HEAD~5
```

Then choose your actions (`pick`, `squash`, `reword`, etc.).

### Example:
```
pick abc123 Initial commit
squash def456 Add feature
squash ghi789 Fix bug
```

### Diagram:
![Interactive Rebase](https://raw.githubusercontent.com/git-guides/images/main/interactive-rebase.png)

---

## **Stashing Work**

Use case: Save uncommitted changes temporarily.

```bash
git stash
git checkout another-branch
git stash pop
```

### Diagram:
![Git Stash](https://raw.githubusercontent.com/git-guides/images/main/git-stash.png)

---

## **Using Git Tags for Releases**

Use case: Marking specific commits as versioned releases.

```bash
git tag -a v1.0 -m "Release version 1.0"
git push origin v1.0
```

### Diagram:
![Git Tag](https://raw.githubusercontent.com/git-guides/images/main/git-tag.png)

---

## **Cherry-picking Commits**

Use case: Apply a commit from another branch to the current one.

```bash
git cherry-pick <commit-hash>
```

### Diagram:
![Cherry Pick](https://raw.githubusercontent.com/git-guides/images/main/cherry-pick.png)

---

## **Bisecting to Find a Bug**

Use case: Find the first bad commit using binary search.

```bash
git bisect start
git bisect bad
git bisect good <commit-hash>
```

Test and mark each revision until Git finds the culprit.

```bash
git bisect reset
```

### Diagram:
![Git Bisect](https://raw.githubusercontent.com/git-guides/images/main/git-bisect.png)

---

## **Working with Submodules**

Use case: Embed another Git repository inside your repo.

```bash
git submodule add https://github.com/example/lib.git libs/lib
git submodule update --init --recursive
```

To clone with submodules:

```bash
git clone --recursive <repo-url>
```

### Diagram:
![Git Submodule](https://raw.githubusercontent.com/git-guides/images/main/git-submodule.png)

---

**End of Tutorial**

