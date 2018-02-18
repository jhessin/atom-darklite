# Welcome to DarkLite

# 🚧 Under Construction 🚧

This is an Atom package that I am developing to address an issue that I have noticed while developing other things.

Namely: Most Atom packages are very poorly written. Not that that is the fault of their developers, but most people who develop Atom packages have state of the art computers that can grind through poorly written code without crashing. My issue is I often find myself working on a system that is 5-10 years old and if there is the slightest overhead I get a big fat editor is not responding message and that just won't do.

# Enter: ATOM DarkLite

Dark - because I like a dark theme, but
Lite - because it is lightweight and easy to handle.

I am primarily using this for developing web applications using React and Coffeescript. If you don't like Coffeescript you obviously don't know what you are missing and I encourage you to give it a [try](http://coffeescript.org/).
If you still don't like Coffeescript... well go away this package isn't for you.

Many of the tools that I will be using (like my snippets) will be made for .coffee files.

## Current Features

### Snippets

I have a collection of snippets that I use when developing react apps (and coffeescript in general as well). The react specific ones will pop up with an \_ thanks to [@webbushka](https://atom.io/users/webbushka) for this idea. Others are obvious `import` `export` and a snippet to generate a getter and setter property with `getset`.

The most important snippet that makes coffeescript work with react is the `_header` snippet which needs to be at the top of every file that react sees (the comment mainly as it allows react to not throw a fit when coffeescript's var declaration appears above the import statements). Beyond that if you want a good starter for a project you should checkout [my Yeoman generator](https://github.com/jhessin/generator-coffee-react).

## Artifacts

As this is a package under development there are certain things that will remain until I am comfortable enough to get rid of them. I am currently using the keybinding `ctrl-;` to test aspects of the package and you may need to uncheck the keybindings in the package settings.

Also a menu item `Toggle atom-darklite` will show up when right clicking on files in the treeview - ignore it please - I intend to change this later for viewing .coffee files as .js and vice-versa.

## Installation

To install use apm

```bash
apm install atom-darklite
```

Or just search inside the atom package manager for atom-darklite.
