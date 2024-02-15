# Exercises for session 2

## Setting up GitHub and Git

* Exercise 1: Create a GitHub account if you don't have one yet (see also [Register a GitHub account](https://happygitwithr.com/github-acct))
  * Go to https://github.com/signup and sign up – have a look at https://github.com/signup before picking your user name

* Exercise 2: Find your Git (see also [Git already installed?](https://happygitwithr.com/install-git.html?q=which%20git#git-already-installed))
  * `which git` (Mac, Linux, Git Bash shell on Windows)
  * `where git` (Windows command prompt, i.e. cmd.exe)

* Exercise 3: Check which version of Git you have installed
  * Run `git --version`

* Exercise 4: Check if you have already configured your Git user name and email
  * Run `git config --global --list` to check all globally defined config variables for Git
  * You can also run `git config --global user.name` or `git config --global user.email` to only check if you set your name / email

* Exercise 5: Introduce yourself to Git if you did not see your name/email in the previous exercise (see also [Introduce yourself to Git](https://happygitwithr.com/hello-git))
  * Run `git config --global user.name "your-user-name"`
  * Run `git config --global user.email "your@email.com"`

## Setting up a local Git repository manually

* Exercise 6:
  * Open a new project in RStudio
    * Click on `File -> New Directory -> New Project` (Untick `Create a git repository` and `Use renv with this project` because we'll   initialise a Git repository manually)
  * Go to the Terminal in RStudio (Should be next to your R Console)
  * Run `git status` (You should see an error message like this `fatal: not a git repository`, why?)
  * Run `git init` (What is happening here?)
  * Run `git status` again (Why do you suddenly see something?)
  * Create a new R file and add some text or code
  * Run `git status` again (What has changed?)
  * Add the new file to the "staging" area
    * Run `git add name_of_your_new_file.R`
  * Run `git status` again (What has changed?)
  * Run `git log --oneline` (You should see an error message like this: `fatal: your current branch 'main' does not have any commits yet`)
  * Commit the file Run `git commit -m "Add new file"`
  * Run `git log --oneline` again (What do you see?)
  * Run `git remote -v` (What do you see? Why?)

## Creating a remote GitHub repository

* Sorry, I ran out of time preparing this, we'll have to do this together!