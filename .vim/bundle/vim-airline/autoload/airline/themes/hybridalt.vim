" Color palette
let s:gui_bg      = "#1d1f21"
let s:gui_fg      = "#c5c8c6"
let s:gui_dgrey   = "#282a2e"
let s:gui_grey    = "#373b41"
let s:gui_lgrey   = "#707880"
let s:gui_red     = "#cc6666"
let s:gui_orange  = "#de935f"
let s:gui_yellow  = "#f0c674"
let s:gui_green   = "#b5bd68"
let s:gui_aqua    = "#8abeb7"
let s:gui_blue    = "#81a2be"
let s:gui_purple  = "#b294bb"
let s:gui_dblue   = "#00005f"
let s:gui_dcyan   = "#005f5f"
let s:gui_dred    = "#5f0000"
let s:gui_dpurple = "#5f005f"

let s:cterm_bg      = "234"
let s:cterm_fg      = "250"
let s:cterm_dgrey   = "235"
let s:cterm_grey    = "237"
let s:cterm_lgrey   = "243"
let s:cterm_red     = "167"
let s:cterm_orange  = "173"
let s:cterm_yellow  = "221"
let s:cterm_green   = "143"
let s:cterm_aqua    = "109"
let s:cterm_blue    = "110"
let s:cterm_purple  = "139"
let s:cterm_dblue   = "17"
let s:cterm_dcyan   = "24"
let s:cterm_dred    = "52"
let s:cterm_dpurple = "53"

let g:airline#themes#hybridalt#palette = {}

" Normal mode
let s:N1 = [s:gui_bg, s:gui_grey, s:cterm_bg, s:cterm_grey]
let s:N2 = [s:gui_lgrey, s:gui_dgrey, s:cterm_lgrey, s:cterm_dgrey]
let s:N3 = [s:gui_lgrey, s:gui_bg, s:cterm_lgrey, s:cterm_bg]
let g:airline#themes#hybridalt#palette.normal = airline#themes#generate_color_map(s:N1, s:N2, s:N3)

" Insert mode
let s:I1 = [s:gui_bg, s:gui_blue, s:cterm_bg, s:cterm_blue]
let s:I2 = [s:gui_lgrey, s:gui_dgrey, s:cterm_lgrey, s:cterm_dgrey]
let s:I3 = [s:gui_lgrey, s:gui_bg, s:cterm_lgrey, s:cterm_bg]
let g:airline#themes#hybridalt#palette.insert = airline#themes#generate_color_map(s:I1, s:I2, s:I3)

" Replace mode
let s:R1 = [s:gui_bg, s:gui_red, s:cterm_bg, s:cterm_red]
let s:R2 = [s:gui_lgrey, s:gui_dgrey, s:cterm_lgrey, s:cterm_dgrey]
let s:R3 = [s:gui_lgrey, s:gui_bg, s:cterm_lgrey, s:cterm_bg]
let g:airline#themes#hybridalt#palette.replace = airline#themes#generate_color_map(s:R1, s:R2, s:R3)

" Visual mode
let s:V1 = [s:gui_bg, s:gui_orange, s:cterm_bg, s:cterm_orange]
let s:V2 = [s:gui_lgrey, s:gui_dgrey, s:cterm_lgrey, s:cterm_dgrey]
let s:V3 = [s:gui_lgrey, s:gui_bg, s:cterm_lgrey, s:cterm_bg]
let g:airline#themes#hybridalt#palette.visual = airline#themes#generate_color_map(s:V1, s:V2, s:V3)

" Inactive
let s:IA1 = [s:gui_bg, s:gui_dgrey, s:cterm_bg, s:cterm_dgrey]
let s:IA2 = [s:gui_lgrey, s:gui_dgrey, s:cterm_lgrey, s:cterm_dgrey]
let s:IA3 = [s:gui_lgrey, s:gui_bg, s:cterm_lgrey, s:cterm_bg]
let g:airline#themes#hybridalt#palette.inactive = airline#themes#generate_color_map(s:IA1, s:IA2, s:IA3)

" Warning
let s:WI = [s:gui_fg, s:gui_dred, s:cterm_fg, s:cterm_dred]
let g:airline#themes#hybridalt#palette.normal.airline_warning = [
     \ s:WI[0], s:WI[1], s:WI[2], s:WI[3]
     \ ]

let g:airline#themes#hybridalt#palette.insert.airline_warning =
     \ g:airline#themes#hybridalt#palette.normal.airline_warning

let g:airline#themes#hybridalt#palette.replace.airline_warning =
     \ g:airline#themes#hybridalt#palette.normal.airline_warning

let g:airline#themes#hybridalt#palette.visual.airline_warning =
     \ g:airline#themes#hybridalt#palette.normal.airline_warning

" Accents
let g:airline#themes#hybridalt#palette.accents = {
     \ 'red': [s:gui_dred, s:gui_bg, s:cterm_dred, s:cterm_bg]
     \ }
