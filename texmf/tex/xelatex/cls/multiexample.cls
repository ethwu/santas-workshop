% An example of a shared preamble.
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{multiexample}[2023/03/21 Example of a shared preamble.]

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions*\relax

\LoadClass{article}

% Font setup.
\RequirePackage{fonts}
% Figures and tables.
\RequirePackage{figs}

\AtBeginDocument{
    % Load the referencing packages.
    \RequirePackage{refs}
}

\endinput