# Jamie Noel Hugo Site

This site is built with [Hugo](https://gohugo.io/) using the `etch` theme.

The most important Hugo rule for editing this site is:

```text
layouts/ beats themes/etch/layouts/
```

If a layout file exists in the project-level `layouts/` directory, Hugo uses it before the matching file in the theme. That means you can override a theme file by copying it from `themes/etch/layouts/...` to the same path under `layouts/...`, then editing the project-level copy.

Avoid editing files directly inside `themes/etch/` unless you intentionally want to modify the vendored theme.

## Current Site Structure

```text
content/
  _index.md              Home page content
  about.md               About page content
  posts/
    _index.md            Posts list page metadata
    welcome.md           Individual blog post

layouts/
  _default/li.html       Local override for post list rows
  _markup/render-passthrough.html

themes/etch/layouts/
  _default/baseof.html   Shared HTML shell
  index.html             Home page main block
  _default/list.html     Section list pages, including /posts/
  _default/single.html   Single content pages, including /about/ and posts
  _default/taxonomy.html Tags/categories list pages
  404.html               Not found page
  partials/head.html     Head metadata and CSS bundle
  partials/header.html   Site title and nav menu
  partials/footer.html   Footer
  partials/posts.html    Post list renderer
```

## Shared Page Shell

Almost every rendered page goes through:

```text
themes/etch/layouts/_default/baseof.html
```

That file provides the shared document structure:

```text
<!doctype html>
html
  partials/head.html
  body
    partials/header.html
    main#content
      block "main"
    partials/footer.html
```

Edit these files for site-wide changes:

```text
themes/etch/layouts/_default/baseof.html      Overall HTML shell
themes/etch/layouts/partials/head.html        Metadata, favicon, CSS bundle, page title
themes/etch/layouts/partials/header.html      Site title and top navigation
themes/etch/layouts/partials/footer.html      Footer copyright
```

To customize one safely, copy it to the same path under `layouts/` first. For example:

```text
themes/etch/layouts/partials/header.html
```

becomes:

```text
layouts/partials/header.html
```

## Home Page

URL:

```text
/
```

Content source:

```text
content/_index.md
```

Layout inheritance:

```text
content/_index.md
  -> themes/etch/layouts/index.html
      -> themes/etch/layouts/_default/baseof.html
          -> themes/etch/layouts/partials/head.html
          -> themes/etch/layouts/partials/header.html
          -> themes/etch/layouts/partials/footer.html
```

The home page template does two things inside the `main` block:

```text
1. Renders the Markdown content from content/_index.md
2. Renders the post list via themes/etch/layouts/partials/posts.html
```

Edit points:

```text
content/_index.md                              Home page text
themes/etch/layouts/index.html                 Home page structure
themes/etch/layouts/partials/posts.html        Home page post list block
layouts/_default/li.html                       Each post row in the list
```

## Posts List Page

URL:

```text
/posts/
```

Content source:

```text
content/posts/_index.md
```

Layout inheritance:

```text
content/posts/_index.md
  -> themes/etch/layouts/_default/list.html
      -> themes/etch/layouts/partials/posts.html
          -> layouts/_default/li.html
      -> themes/etch/layouts/_default/baseof.html
          -> themes/etch/layouts/partials/head.html
          -> themes/etch/layouts/partials/header.html
          -> themes/etch/layouts/partials/footer.html
```

The `posts.html` partial lists pages from:

```toml
[params]
  mainSections = ["posts"]
```

That setting lives in:

```text
hugo.toml
```

Edit points:

```text
content/posts/_index.md                        Posts page title/metadata
themes/etch/layouts/_default/list.html         Section list page wrapper
themes/etch/layouts/partials/posts.html        Which posts are listed
layouts/_default/li.html                       Markup for each listed post
```

## Individual Blog Posts

Example URL:

```text
/posts/welcome/
```

Content source:

```text
content/posts/welcome.md
```

Layout inheritance:

```text
content/posts/*.md
  -> themes/etch/layouts/_default/single.html
      -> themes/etch/layouts/_default/baseof.html
          -> themes/etch/layouts/partials/head.html
          -> themes/etch/layouts/partials/header.html
          -> themes/etch/layouts/partials/footer.html
```

The final URL for posts is controlled by:

```toml
[permalinks]
  posts = '/posts/:slug/'
```

Edit points:

```text
content/posts/*.md                             Post content and front matter
themes/etch/layouts/_default/single.html       Post page article structure
hugo.toml                                      Post permalink pattern
```

## About Page

URL:

```text
/about/
```

Content source:

```text
content/about.md
```

Layout inheritance:

```text
content/about.md
  -> themes/etch/layouts/_default/single.html
      -> themes/etch/layouts/_default/baseof.html
          -> themes/etch/layouts/partials/head.html
          -> themes/etch/layouts/partials/header.html
          -> themes/etch/layouts/partials/footer.html
```

The About page uses the same `single.html` template as individual posts. If you want About to have a different layout from blog posts, create a more specific layout override.

Common options:

```text
layouts/page/single.html       Applies to regular top-level pages like about.md
layouts/about/single.html      Applies to pages with type = "about"
layouts/_default/single.html   Applies broadly to all single pages
```

Edit points:

```text
content/about.md                              About page content
themes/etch/layouts/_default/single.html      Current About page structure
hugo.toml                                     Navigation link to /about/
```

## Taxonomy Pages

Generated URLs include:

```text
/tags/
/categories/
```

Layout inheritance:

```text
Generated taxonomy pages
  -> themes/etch/layouts/_default/taxonomy.html
      -> layouts/_default/li.html
      -> themes/etch/layouts/_default/baseof.html
          -> themes/etch/layouts/partials/head.html
          -> themes/etch/layouts/partials/header.html
          -> themes/etch/layouts/partials/footer.html
```

Edit points:

```text
themes/etch/layouts/_default/taxonomy.html    Tags/categories page structure
layouts/_default/li.html                      Each listed page row
```

## 404 Page

URL:

```text
/404.html
```

Layout file:

```text
themes/etch/layouts/404.html
```

Edit point:

```text
themes/etch/layouts/404.html                  Not found page markup
```

If you want to customize it without editing the theme, copy it to:

```text
layouts/404.html
```

## Navigation

The navigation links are configured in:

```text
hugo.toml
```

Current menu:

```toml
[menu]
  [[menu.main]]
    identifier = 'posts'
    name = 'Posts'
    title = 'Posts'
    url = '/posts/'
    weight = 10

  [[menu.main]]
    identifier = 'about'
    name = 'About'
    title = 'About'
    url = '/about/'
    weight = 20
```

The menu is rendered by:

```text
themes/etch/layouts/partials/header.html
```

Edit points:

```text
hugo.toml                                      Add/remove/reorder nav items
themes/etch/layouts/partials/header.html       Change nav markup
```

## Post List Rows

The site already overrides the theme's default list item template:

```text
layouts/_default/li.html
```

This controls each row in post lists and taxonomy lists. It currently renders:

```text
Post title
Post date
Post summary
```

This override is used when templates call:

```go-html-template
{{ .Render "li" }}
```

That call appears in:

```text
themes/etch/layouts/partials/posts.html
themes/etch/layouts/_default/taxonomy.html
```

Edit this file when you want to change how posts appear in lists:

```text
layouts/_default/li.html
```

## Markdown And Math Rendering

This site enables Goldmark passthrough delimiters in:

```text
hugo.toml
```

Relevant config:

```toml
[markup.goldmark.extensions.passthrough]
  enable = true
```

The local render hook is:

```text
layouts/_markup/render-passthrough.html
```

Edit points:

```text
hugo.toml                                      Markdown/math parser settings
layouts/_markup/render-passthrough.html        Passthrough rendering behavior
```

## CSS

The active CSS files come from the theme assets:

```text
themes/etch/assets/css/main.css
themes/etch/assets/css/min770px.css
themes/etch/assets/css/dark.css
themes/etch/assets/css/syntax.css
```

They are loaded and bundled by:

```text
themes/etch/layouts/partials/head.html
```

To override theme CSS without editing the theme, copy the relevant CSS file into:

```text
assets/css/
```

using the same file name. For example:

```text
themes/etch/assets/css/main.css
```

can be overridden by:

```text
assets/css/main.css
```

## Where To Edit Common Things

```text
Site title                     hugo.toml
Browser title                  Page front matter title, rendered by partials/head.html
Top navigation links           hugo.toml
Top navigation markup          themes/etch/layouts/partials/header.html
Footer text                    hugo.toml params.copyright
Footer markup                  themes/etch/layouts/partials/footer.html
Home page text                 content/_index.md
Home page layout               themes/etch/layouts/index.html
Posts page title               content/posts/_index.md
Post list block                themes/etch/layouts/partials/posts.html
Post list row                  layouts/_default/li.html
Individual post content        content/posts/*.md
Individual post layout         themes/etch/layouts/_default/single.html
About page content             content/about.md
About page layout              themes/etch/layouts/_default/single.html
Tags/categories layout         themes/etch/layouts/_default/taxonomy.html
404 page                       themes/etch/layouts/404.html
CSS bundle selection           themes/etch/layouts/partials/head.html
CSS rules                      themes/etch/assets/css/*.css or assets/css/*.css override
Post URLs                      hugo.toml permalinks.posts
Math passthrough               hugo.toml and layouts/_markup/render-passthrough.html
```

## Safe Override Workflow

Use this workflow when changing theme behavior:

```text
1. Find the theme file that controls the thing you want to change.
2. Copy it to the same path under project-level layouts/ or assets/.
3. Edit the project-level copy.
4. Run hugo server -D.
5. Check the affected page in the browser.
```

Examples:

```text
Header:
themes/etch/layouts/partials/header.html
-> layouts/partials/header.html

Single page layout:
themes/etch/layouts/_default/single.html
-> layouts/_default/single.html

Post list partial:
themes/etch/layouts/partials/posts.html
-> layouts/partials/posts.html

Main CSS:
themes/etch/assets/css/main.css
-> assets/css/main.css
```

## Local Development

Run the dev server from the project root:

```sh
hugo server -D
```

Then open the URL Hugo prints, usually:

```text
http://localhost:1313/
```
