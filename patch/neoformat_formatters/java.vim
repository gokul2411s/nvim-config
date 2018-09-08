function! neoformat#formatters#java#enabled() abort
   return ['google']
endfunction

function! neoformat#formatters#java#google() abort
     return {
            \ 'exe': 'sh',
            \ 'args': ['$XDG_CONFIG_HOME/google_formatter/google-java-format-1.6-all-deps.sh'],
            \ 'stdin': 1,
            \ }
endfunction

