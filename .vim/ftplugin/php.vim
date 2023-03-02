inoreabbrev _construct public function __construct()<CR>{<CR><CR>}<C-o>2k<ESC>

inoreabbrev _public public function (): void<CR>{<CR><CR>}<C-o>2k<ESC>
inoreabbrev _private private function (): void<CR>{<CR><CR>}<C-o>2k<ESC>
inoreabbrev _protected protected function (): void<CR>{<CR><CR>}<C-o>2k<ESC>

inoreabbrev _if if () {<CR><CR>}<C-o>2k<ESC>
inoreabbrev _elseif } elseif () {<CR><C-o>2k<ESC>
inoreabbrev _ifelse if () {<CR><CR>} else {<CR><CR>}<C-o>4k<ESC>

inoreabbrev _for for ($i = 1; $i <= 1; $i++) {<CR><CR>}<C-o>2k<ESC>
inoreabbrev _fore foreach ($t as $v) {<CR><CR>}<C-o>2k<ESC>

inoreabbrev _sw switch () {<CR>case 0:<CR>break;<CR>}<C-o>4k<ESC>

inoreabbrev _try try {<CR><CR>} catch (Exception $e) {<CR><CR>}<C-o>4k<ESC>

inoreabbrev _llog logger( . "\n", ['file' => __FILE__, 'line' => __LINE__]);<C-o>50h<ESC>
