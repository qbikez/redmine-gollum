Redmine Gollum
==============

This is a plugin which lets a Redmine project web site use Gollum as wiki.

Gollum is the wiki which is used here at [GitHub](https://github.com/github/gollum). This plugin makes it available to Redmine.

A gollum wiki is a git repository that contains simple text files.

You can set a base path for all of your wikis if you want all wikis to be in the specific folder.

You can also go to project settings and set a custom wiki git path.

The wiki will be created when you go to a plugin tab. Old wikis will not be deleted or moved.


Be cautious:

- You can have a .git repository pretty much anywhere the running process has access to, configure via plugins in administrator area
- If you change the wiki path (.git repo), it will NOT be moved
- It requires your redmine process (passenger / mongrel... whatever) to be able to write your git repositories
- Redmine Gollum will not warn you if you have files with the same name in one repo (but in different directories). Even if you set up different page files 	directory.
- IT DOES NOT IMPORT YOUR CURRENT WIKI CONTENT
