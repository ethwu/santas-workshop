
# Use a texmf folder to contain shared configuration.
export TEXMFHOME := justfile_directory() / 'texmf'

# Directory containing TeX sources.
src := 'src'
# Name of the main file.
main := 'main.tex'

# LaTeX engine.
latex := 'xelatex'

# Build the final PDF and open it.
build-open file=main: (build-final file) (open file)

# Build the final PDF.
build-final file=main: (build-index file)
    cd {{quote(src / parent_directory(file))}} && {{latex}} {{quote(file_name(file))}}

# Build the index.
build-index file=main: (draft-pass file)
    cd {{quote(src / parent_directory(file))}} && makeindex {{quote(file_name(file))}}

# Build the project without generating a PDF.
draft-pass file=main:
    cd {{quote(src / parent_directory(file))}} && {{latex}} --no-pdf {{quote(file_name(file))}}

# Open the rendered PDF.
open file=main:
    open {{quote(src / without_extension(file))}}.pdf
alias o := open

# Get the path to the rendered PDF.
output-path file=main:
    @echo {{quote(src / without_extension(file))}}.pdf

# Clean up build artifacts.
clean:
    fd -I '.*\.(aux|glo|ist|log|pdf|sta|synctex.gz|xdv)' {{quote(src)}} -x rm {}
alias c := clean
