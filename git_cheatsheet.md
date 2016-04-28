You make your changes in your project's directory a.k.a the **working directory**. Likely you made three changes in three different files which we call it ChangeA, ChangeB, ChangeC. But you only want to commit the ChangeA and ChangeB which are more relational. So you just add ChangeA and ChangeB to the staging area where we will be prepared for the final committing thing. The last thing we do is commit the changes that we want. So you got the big picture of Git.:) hah

## Git basics
- `git init` creates a new Git repository
- `git status` inspects the contents of the working directory and staging area
- `git add` adds files from the working directory to the staging area
- `git diff` shows the differences between the working directory and the staging area
- `git commit` permanently stores file changes from the staging area in the repository
- `git log` show a list of all previous commits

## Git revert back
- `git checkout HEAD filename` Discards changes in the working directory
- `git reset HEAD filename` Unstages file changes in the staging area
- `git reset SHA` Can be used to reset to a previous commit in your commit history

## Git branches
- `git branch` Lists all a Git project's branchs
- `git branch branch_name` Creates a new branch
- `git checkout branch_name` Used to switch from one branch to another
- `git merge branch_name` Userd to join file changes from one branch to another
- `git branch -d branch_name` Deletes the branch specified

## Git remote
- `git clone` Creates a local copy of a remote
- `git remote -v` Lists a Git project's remotes
- `git fetch` Fetches work from the remote into the local copy
- `git merge origin/master` Merges origin/master into your local branch
- `git push origin <branch_name>` Pushes a local branch to the origin remote
