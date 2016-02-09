# new-project-creator

Automatically creates a project directory with files: Gemfile, .ruby-version, .ruby-gemset.
It saves project names and ruby version numbers in the new-project-creator.projects file.

Project name is the same as directory name and it is the same as gemset name.

Each time the program is used it also checks if all directories from the new-project-creator.projects exist in the current directory.
If some didn't it means you have delete them so the program will delete proper project names from the new-project-creator.projects
and automatically delete proper RVM gemsets.

Tested only on Linux.

It requires RVM.

## example of using

<p style="background: black; color: white;">asdasdasdasdasd</p>
