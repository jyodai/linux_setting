source ~/.vim/ftplugin/javascript.vim

inoreabbrev _compo components : {<CR>},<C-o>2k<ESC>
inoreabbrev _pr props : {<CR>},<C-o>2k<ESC>
inoreabbrev _em emits : [<CR>],<C-o>2k<ESC>
inoreabbrev _da data () {<CR>return {<CR>}<CR>},<C-o>2k<ESC>
inoreabbrev _me methods : {<CR>},<C-o>2k<ESC>

inoreabbrev _compu computed : {<CR>A () {<CR>}<CR>},<C-o>2k<ESC>
inoreabbrev _wa watch : {<CR>A : function(newVal, oldValue) {<CR>}<CR>},<C-o>2k<ESC>

inoreabbrev _cr created () {<CR>},<C-o>2k<ESC>
inoreabbrev _mo mounted () {<CR>},<C-o>2k<ESC>
