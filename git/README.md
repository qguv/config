# git aliases

Some aliases from my config that may be useful:

<details>
<summary>ff: attempt a fast-forward merge; abort if not possible</summary><br />

To activate:

    git config --global alias.ff merge --ff-only
    git ff

</details>

<details>
<summary>g: a more useful `git grep`</summary><br />

To activate:

    git config --global alias.g grep --break --heading --line-number
    git g [pattern]

</details>

<details>
<summary>ignore: ignore changes to an already-tracked file</summary><br />

- `ignore` tells git to ignore additional changes to an already-committed file
- `track` counteracts a previous `ignore`
- `ignored` lists files that have been `ignore`d

To activate:

    git config --global alias.ignore update-index --assume-unchanged
    git config --global alias.track update-index --no-assume-unchanged
    git config --global alias.ignored '!f() { git ls-files -v \"$@\" | sed -n '"'s:^h ::p'"'; }; f'
    git ignore [filename...]
    git track [filename...]

</details>

<details>
<summary>flog: a more comprehensive commit log</summary><br />

Like `log`, but shows where commits correspond to the head of a branch, any tags pointing to that commit, and any notes for that commit. Also shows which files were changed but not the contents of the patch.

To activate:

    git config --global alias.flog log --decorate --notes --stat
    git flog

</details>

<details>
<summary>ls: show which files are tracked</summary><br />

To activate:

    git config --global alias.ls ls-tree --name-only HEAD
    git ls

</details>

<details>
<summary>graph: a pretty log that shows branches, merge history, and tags</summary><br />

To activate:

    git config --global alias.graph log --graph --decorate --pretty=oneline --abbrev-commit
    git graph
    git graph --all

</details>

<details>
<summary>whoops: alter last commit to incorporate currently staged changes</summary><br />

Note: The commit you're altering **must not have already been pushed**! Or you'll need to force push.

To activate:

    git config --global alias.whoops commit --amend --no-edit
    git whoops

</details>

<details>
<summary>release: move a tag to HEAD and push it to origin</summary><br />

`release` creates or moves a tag to the specified (or HEAD) commit, then pushes that tag to origin.

To activate:

    git config --global alias.release '!f(){ git tag -f \"${1:?'"'Usage: git release TAG [REMOTE] [REF]'"'}\" \"${3:-HEAD}\" \"$@\" && git push -f \"${2:-origin}\" \"$1\"; }; f'
    git release TAG [REMOTE] [REF]

</details>
<details>
<summary>merged-branches: list branches that have been merged into the current branch</summary><br />

To activate:

    git config --global alias.merged-branches '!f() { git branch --merged \"$@\" | sed -n '"'s:^  ::p'"'; }; f'
    git merged-branches [REF]

</details>
