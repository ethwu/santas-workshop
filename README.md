# `multidocument` Multiple-File LaTeX Template

Multiple-file LaTeX template for long documents.

## Compiling

For tooling to find the files, make sure that `TEXMFHOME` is set to the path to `texmf`.
You can configure a shell by changing directory to the repository root and running `. ./activate`.
The project `justfile` is already configured to work properly.

Use `just` to compile the project.
Note that `just` treats paths relative to the directory containing the `justfile`.

```sh
# Default action renders the final PDF and opens it with `open`.
$ just
# Renders the final PDF.
$ just build-final
# Get the path to the rendered PDF.
$ just output-path
# Clean up build artifacts.
$ just clean
```

Run `just --list` to get a full listing of available commands.

You can specify an entrypoint (for example, the file `src/children/child.tex`) to most recipes by passing the path relative from `src/`; for example, `just build-final children/child.tex`.
You can override the default settings by setting the `main` variable in the `justfile`.

## Project Organization

LaTeX source files for text content are kept under `src/`, with the entrypoint at `src/main.tex`.
Reusable project-wide configuration is siloed into `sty` and `cls` files underneath `texmf`.
To use a shared preamble for all documents, create a new `cls` and set it as the base class in `multidocument`'s arguments.
Use the `cls` file to set the

### Text Content

Text content is organized hierarchically underneath `src/`.
An entrypoint file has the following structure:

```tex
% src/main.tex
\documentclass[baseclass=multiexample]{multidocument}

% All imports required by the entire document.
\usepackage{lipsum}

\begin{document}

\rinput{children/child.tex}
\rinput{children/cousin.tex}

\end{document}
```

`multidocument` takes two optional arguments:

- `root` specifies a relative path to the root directory of the project.
  It defaults to `root=.`.
  This is most important for subdocuments.
- `baseclass` specifies a base class.
  Relative sectioning commands are only set up for the `article` base class.
  It defaults to `baseclass=article`.

Subdocuments need to be included with the `\rinput` command, with an unprefixed relative path from the project root.

Sections in subdocuments should also use the `\rsection`, `\rsubsection`, and `\rsubsubsection` commands, which adjust sectioning levels automatically.
When a subdocument has been included with the `\rsinput` command instead of `\rinput`, the sectioning level of the included document is reduced by one.
This functionality is tested with `article`.

Subdocuments can be compiled individually so long as all packages they require are imported in their preamble.
This repository contains an example, with the following file structure:

```txt
src/
    |-> children/
    |   |-> child.tex
    |   |-> cousin.tex
    |   |-> grandchildren/
    |   |   |-> grandchild.tex
    |-> main.tex
texmf/
    |-> tex/
    |   |-> xelatex/
    |   |   |-> cls/
    |   |   |   |-> multiexample.cls
```
