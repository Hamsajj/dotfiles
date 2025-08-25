set number
syntax on
colorscheme desert

" Set terminal-specific cursor shapes for different modes
let &t_SI = "\e[5 q"    " Insert mode: blinking vertical bar
let &t_EI = "\e[2 q"    " Normal mode: steady block
let &t_SR = "\e[4 q"    " Replace mode: steady underline
