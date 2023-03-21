% An article with many subdocuments.
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{multidocument}[2023/03/21 Class for long, multi-file documents.]

\RequirePackage{kvoptions}

% Relative path to the project root.
\DeclareStringOption[.]{root}
% Base class to extend.
\DeclareStringOption[article]{baseclass}

\DeclareDefaultOption{\PassOptionsToClass{\CurrentOption}{\multidocument@baseclass}}
\ProcessKeyvalOptions*\relax

% Disable options after processing.
\DisableKeyvalOption[action=undef]{multidocument}{root}
\DisableKeyvalOption[action=undef]{multidocument}{baseclass}

\LoadClass{\multidocument@baseclass}

\RequirePackage{docmute}

\let\projectroot=\multidocument@root\relax
% Relative sectioning.
\RequirePackage{multidocument-relative-sectioning}

\endinput