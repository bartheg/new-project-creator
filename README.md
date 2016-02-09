# new-project-creator

Automatically creates a project directory with files: Gemfile, .ruby-version, .ruby-gemset.
It saves project names and ruby version numbers in the new-project-creator.projects file.

Project name is the same as directory name and it is the same as gemset name.

Each time the program is used it also checks if all directories from the new-project-creator.projects exist in the current directory.
If some didn't it means you have delete them so the program will delete proper project names from the new-project-creator.projects
and automatically delete proper RVM gemsets.

Tested only on Linux.

It requires RVM.

## How to install

Copy new-project-creator.rb file to your directory where you want to have your Ruby projects. You can rename this file.

## How to uninstall

Delete new-project-creator.rb and new-project-creator.projects files.

## How it works (terminal capture)

```bash
u@laptop:~/ruby-projects$ ls
new-project-creator.rb
u@laptop:~/ruby-projects$ rvm gemset list_all

gemsets for ruby-2.2.1 (found in /home/u/.rvm/gems/ruby-2.2.1)
=> (default)
   blog
   global
   moron-project


gemsets for ruby-2.3.0 (found in /home/u/.rvm/gems/ruby-2.3.0)
=> (default)
   blog
   empty
   global
   gosu-test
   guess-my-number
   minitesty-w-ruby

u@laptop:~/ruby-projects$ rvm current
ruby-2.3.0
u@laptop:~/ruby-projects$ ruby new-project-creator.rb superproject 2.2.1
A new file new-project-creator.projects was created
A new file new-project-creator.projects was created
mkdir superproject
cd ./superproject
A new file .ruby-version was created
A new file .ruby-gemset was created
A new file Gemfile was created
cd -
The file new-project-creator.projects was updated.
u@laptop:~/ruby-projects$ ls
new-project-creator.projects  new-project-creator.rb  superproject
u@laptop:~/ruby-projects$ ls -la superproject/
total 20
drwxrwxr-x 2 u u 4096 lut  9 20:04 .
drwxrwxr-x 3 u u 4096 lut  9 20:04 ..
-rw-rw-r-- 1 u u   43 lut  9 20:04 Gemfile
-rw-rw-r-- 1 u u   12 lut  9 20:04 .ruby-gemset
-rw-rw-r-- 1 u u   10 lut  9 20:04 .ruby-version
u@laptop:~/ruby-projects$ cd superproject/
ruby-2.2.1 - #gemset created /home/u/.rvm/gems/ruby-2.2.1@superproject
ruby-2.2.1 - #generating superproject wrappers..........
u@laptop:~/ruby-projects/superproject$ rvm current
ruby-2.2.1@superproject
u@laptop:~/ruby-projects/superproject$ rvm gemset list_all

gemsets for ruby-2.2.1 (found in /home/u/.rvm/gems/ruby-2.2.1)
   (default)
   blog
   global
   moron-project
=> superproject


gemsets for ruby-2.3.0 (found in /home/u/.rvm/gems/ruby-2.3.0)
   (default)
   blog
   empty
   global
   gosu-test
   guess-my-number
   minitesty-w-ruby

u@laptop:~/ruby-projects/superproject$ cat .ruby-version
ruby-2.2.1
u@laptop:~/ruby-projects/superproject$ cat .ruby-gemset 
superproject
u@laptop:~/ruby-projects/superproject$ cat Gemfile 
source 'https://rubygems.org'

ruby "2.2.1"
u@laptop:~/ruby-projects/superproject$ cd ..
u@laptop:~/ruby-projects$ cat new-project-creator.projects 
2.2.1@superproject
u@laptop:~/ruby-projects$ rm -fr superproject/
u@laptop:~/ruby-projects$ ls
new-project-creator.projects  new-project-creator.rb
u@laptop:~/ruby-projects$ rvm current
ruby-2.3.0
u@laptop:~/ruby-projects$ ruby new-project-creator.rb anotherproject
Removing gemset superproject......
A new file new-project-creator.projects was created
mkdir anotherproject
cd ./anotherproject
A new file .ruby-version was created
A new file .ruby-gemset was created
A new file Gemfile was created
cd -
The file new-project-creator.projects was updated.
u@laptop:~/ruby-projects$ ls
anotherproject  new-project-creator.projects  new-project-creator.rb
u@laptop:~/ruby-projects$ cat new-project-creator.projects 
2.3.0@anotherproject
u@laptop:~/ruby-projects$ rvm gemset list_all

gemsets for ruby-2.2.1 (found in /home/u/.rvm/gems/ruby-2.2.1)
=> (default)
   blog
   global
   moron-project


gemsets for ruby-2.3.0 (found in /home/u/.rvm/gems/ruby-2.3.0)
=> (default)
   blog
   empty
   global
   gosu-test
   guess-my-number
   minitesty-w-ruby

```
