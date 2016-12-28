Workflow
========

The basic workflow is described below. It assumes a certain amount of knowledge of git commands and github functionality.

1.  Using the github website, fork https://github.com/rpgwnn/rpgcat into your own rpgcat repo (referred to as YOURGITHUBUSER/rpgcat.git)

2.  Clone your fork into a working directory.

        git clone git@github.com:YOURGITHUBUSER/rpgcat.git

3.  Make sure you have an upstream repo added.

        git remote add upstream https://github.com/rpgwnn/rpgcat.git

4.  If the work may take a long time, perhaps create a branch

        git checkout -b FEATURE_NAME

5.  Do some work on the files

6.  Work out which files need to be added using `git status` and `git diff filename`. If there are any files which need parts of it adding but not everything, use `git add -p filename` to review each part of the patch before adding. After adding some changes, use `git commit` to create a commit for those changes.

    If making lots of changes, consider making multiple commits consisting of just a few related files at a time. You can create a single pull request for several commits.

        git status
        git add filename
        git commit

7.  Update your forked rpgcat repository. You may have to add extra parameters if you created a branch for this group of commits.

        git push

8.  Go to https://github.com/YOURGITHUBUSER/rpgcat and create a pull request back to rpgwnn/rpgcat with your changes in it. Be sure to explain what the changes are! If you created a branch, ensure you create the pull request *for the branch*.

9.  Wait for request to be merged.

10. Fetch the upstream version (which should contain your changes)

        git fetch upstream

11. If you are currently working on a branch other than master, you'll want to switch back to master.

        git checkout master

12. Merge the upstream version into your master branch. If you prefer, you can use `git rebase` instead of `git merge` but consult documentation for the differences between these two commands.

        git merge upstream/master

Multiple features/branches
--------------------------

You can work on multiple branches at the same time, switching between them as required. Once you have created a pull request for a branch, please be aware that any further commits to that branch will also be included in the pull request!

