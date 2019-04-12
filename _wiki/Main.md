---
layout: wiki
title: Main Page
toc: false
created: 2009-04-12
modified: 2009-04-12
revisions:
- author: Alexis
  date: 2009-04-12
  comment: First version
---

# Why ?

I wrote this template in 2019 because I wanted to migrate a mediawiki-powered wiki to jekyll.

The template has a layout and a navigation that can replace my old wiki.

# How to

If you want to use this template, clone the [repository](https://github.com/jek4wik/jek4wik), customize it and write _wiki_ pages.

## Settings

The general settings are in the _config.yml file.

You may choose the *language*.
English (en) and french (fr) are supported out-of-the box.

```yaml
lang: en
```

You may customize the *collections*.
The only contraint is that the name of collections containing wiki pages should start with wiki.

```yaml
collections:
  wiki-one:
    output: true
    permalink: "/:path" 
    path: ""
  wiki-two:
    output: true
    permalink: "/:path"
    path: ""
  special:
    output: true
    permalink: "/:path"
    path: ""
```

Of course, you'll have to change the other site settings like title, description or url.

## i18n

The labels are in i18n files in the `_data/i18n` directory.

These files contain also prefixes for special pages, the name of home page and the logo that will be displayed on the top left.

```yaml
home: Main
logo: /img/wiki.png
label:
  author: Author
  links: Links
  tags: Other pages
  ...
prefix:
  tag: "Category:"
  user: "User:"
```

## Users

The users are declared in the _data/users.yml file.

```yaml
Alexis:
  name: Alexis Hassler
  logo: img/sewatech.png
```

Each user should have its page in the `_special` directory.
The name of this page starts with the prefix defined in the i18n file (here `User:`) 
and end with the user short name (here `Alexis`).

# Wiki pages

Wiki pages are in collections that name starts with wiki.
The bootstrap project provides 2 collections : `wiki` and `wiki-legacy`.

The pages can be written in HTML, Markdown or Asciidoc.

> Note: Asciidoc is not supported on Github pages.

## Regular wiki page

A regular wiki page should be place in a _wiki_ collection.
The only required metadata in frontmatter is the layout.
The simplest page may be something like this:

```yaml
---
layout: wiki
---
Example with minimal frontmatter
```

The frontmatter may contain the following attributes:

* title: will be displayed on top of the page
* author: will be displayed in a div in the left columns
* toc: true/false wether you want a generated table of content
* created and modified: date in format yyyy-MM-dd
* revisions: not displayed (maybe for a future use)

> Note: the toc plugin doesn't work on Github pages

## Redirect page

A redirect page should be place in a _wiki_ collection.
It should have a frontmatter with a **layout** and a **redirect**, and no content

```yaml
---
layout: redirect
redirect: New
---
```

> Note: redirections may be managed in an other way with the _jekyll-redirect-from_ plugin

## Tag page

A tag page should be place in a _special_ collection.
The file name should have the prefix defined in the _i18n_ file and end with the tag name.

For example, a file named `Tag:Example.md` would fit with the following i18n configuration.

```yaml
prefix:
  tag: "Tag:"
```

> Note: this is in the i18n files because mediawiki translates this prefix ; it is Category in english and Catégorie in french

The tag page may have the same metadata as a regular page.

```yaml
---
layout: tag
title: Example of Tag
tags: Example
toc: false
created: 2019-04-12
modified: 2019-04-12
revisions:
- author: Alexis
  date: 2019-04-12
  comment: First version
---
## Example Tag

Nice examples
```

## User pages

A user page should be place in a _special_ collection.
The file name should have the prefix defined in the _i18n_ file and end with the user name.

For example, a file named `User:Example.md` would fit with the following i18n configuration.

```yaml
prefix:
  user: "User:"
```

> Note: this is in the i18n files because mediawiki translates this prefix ; it is User in english and Utilisateur in french

The user page may have the same metadata as a regular page.

```yaml
---
layout: user
title: Alexis
created: 2019-04-12
modified: 2019-04-12
---
I'm a developer.
```

# Deploy

The simplest way to deploy your wiki is to generate the site and copy it to a Web Server.

```yaml
jekyll build
```

As any Jekyll web site, the generation may be done on a CI server (TravisCI,...) or with the CI capabilities of the Git server (Gitlab, Github actions,...).

## Apache HTTP server

A `.htaccess` file is provided.
If the site is deployed on a Apache HTTP server, some old mediawiki URLs are rewritten to the new Jekyll URLs.

## Github pages

The wiki may be deployed on Github pages with the following contraints:

* Only HTML or Markdown, no Asciidoc
* No generated toc

If you want to have this features on Github pages, you should push the generated site.
Any CI tool can help.

## Gitlab pages

[TBD]

## Github actions

[TBD]

## TravisCI

[TBD]

# Examples

* Example of a [new page](New.html)
* Example of a [legacy page](Old.html)
* Example of a [redirected page](Redirect.html)
* Example of a [user page](./User:Alexis.html)
* [RSS](feed.xml) feed of new pages
* Example of a [tag page](./Category:Example.html)
* [All tags page](./tags.html)
