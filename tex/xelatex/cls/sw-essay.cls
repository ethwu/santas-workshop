\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{sw-essay}[2023-02-06 Configurable styles for writing papers.]

\RequirePackage{etoolbox}

% Microsoft Word style.
\newbool{lunwen:word}
\DeclareOption{word}{%
    \booltrue{lunwen:word}%
    \PassOptionsToClass{12pt}{article}%
}
    % Microsoft Word style with double-spacing.
    \newbool{lunwen:word:double}\DeclareOption{wordbl}{\booltrue{lunwen:word:double}}
    % Basic headings for Microsoft Word style.
    \newbool{lunwen:word:basic}\DeclareOption{wordbasic}{\booltrue{lunwen:word:basic}}
    % Whether to force the Times New Roman/Arial/Courier New combo.
    \newbool{lunwen:word:fonts}\DeclareOption{wordfonts}{\booltrue{lunwen:word:fonts}}
% Load table packages.
\newbool{lunwen:tab}\DeclareOption{tab}{\booltrue{lunwen:tab}}
% Load reference packages.
\newbool{lunwen:ref}\DeclareOption{ref}{\booltrue{lunwen:ref}}
% Pass through undefined options.
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions*\relax

% Superclass article.
\LoadClass{article}

% Set font settings according to engine.
\RequirePackage{iftex}
\ifPDFTeX
    \RequirePackage[utf8]{inputenc}
    \RequirePackage[T1]{fontenc}
    \RequirePackage{lmodern}
\else
    \ifXeTeX
        \RequirePackage{fontspec}
    \else
        \RequirePackage{luatextra}
    \fi
    % Unicode super- and subscripts.
    \RequirePackage{realscripts}
    \defaultfontfeatures{Ligatures=TeX}
\fi

% Typographic adjustments.
\RequirePackage{microtype}
% Page layout.
\RequirePackage{geometry}
% Restore default page layout.
\Gm@restore@org

\ifbool{lunwen:word}{%
    % Microsoft Word style.

    % Adjust line spacing.
    \RequirePackage{setspace}

    % Use Microsoft Word fonts.
    \ifPDFTeX
        \RequirePackage{mathptmx}
        \RequirePackage[scaled=.90]{helvet}
        \RequirePackage{courier}
    \else
        \IfFontExistsTF{Times Roman}{
            \setmainfont{Times Roman}
            \setromanfont{Times Roman}
        }{
            \setmainfont{Times New Roman}
            \setromanfont{Times New Roman}
        }
        \ifbool{lunwen:word:fonts}{
            % Just use Arial and Courier New.
            \setsansfont{Arial}
            \setmonofont{Courier New}
        }{
            % Replace Arial with Helvetica.
            \IfFontExistsTF{Helvetica}{
                \setsansfont{Helvetica}
            }{
                \setsansfont{Arial}
            }
            % Replace Courier New with Courier Prime.
            \IfFontExistsTF{Courier Prime}{
                \setmonofont{Courier Prime}
            }{
                \setmonofont{Courier New}
            }
        }
    \fi

    % Set the margins to 1 inch.
    \geometry{includefoot, margin=1in}

    % Style title block.

    % Set the title styles.
    \RequirePackage{titling}%
    \pretitle{\LARGE\sffamily\bfseries\vspace*{-\baselineskip}}%
    \posttitle{\par}%
    \preauthor{\large\begin{tabular}[t]{@{}l@{}}}%
    \postauthor{\end{tabular}\par}%
    \predate{\large}%
    \postdate{\par}%
    % Remove the built-in maketitle vertical spacing.%
    \setlength{\droptitle}{-2em}%
    % Flush entire title block to the left.%
    \renewcommand{\maketitlehooka}{\flushleft\ifbool{lunwen:word:double}{\singlespacing}{}}%
    \renewcommand{\maketitlehookd}{\endflushleft\vskip-1.5em}%

    \ifbool{lunwen:word:double}{%
        % Set line spacing to "double spacing".
        \setstretch{2.33}}{}

    % Style headings.

    % Style section headers.
    \RequirePackage{titlesec}%
    \titleformat*{\section}{\ifbool{lunwen:word:basic}{\normalsize}{\LARGE}\sffamily\bfseries}%
    \titlespacing*{\section}{\z@}{*1}{*0.5}%
    \titleformat*{\subsection}{\ifbool{lunwen:word:basic}{\normalsize}{\Large}\sffamily\bfseries\itshape}%
    \titlespacing*{\subsection}{\z@}{*1}{*0.5}%
    \titleformat*{\subsubsection}{\ifbool{lunwen:word:basic}{\normalsize}{\Large}\sffamily\bfseries\itshape}%
    \titlespacing*{\subsubsection}{\z@}{*1}{*0.5}%
    \titleformat*{\paragraph}{\normalsize\sffamily\itshape}%
    \titlespacing*{\paragraph}{\z@}{*1}{*0.5}%
    \titleformat*{\subparagraph}{\normalsize\sffamily\itshape}%
    \titlespacing*{\subparagraph}{\parindent}{*1}{*0.5}%

    % Use half-inch paragraph indents.
    \setlength{\parindent}{0.5in}
}{}

\ifbool{lunwen:tab}{%
    % Provide table packages.

    % Table formatting.
    \RequirePackage{booktabs}%
}{}

\endinput
