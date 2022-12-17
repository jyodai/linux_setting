call ddc#custom#patch_global('ui', 'native')

call ddc#custom#patch_global('sources', ['vim-lsp', 'around'])

call ddc#custom#patch_global('sourceOptions', #{
            \ _: #{
            \ matchers: ['matcher_head'],
            \ sorters: ['sorter_rank']},
            \ })

call ddc#custom#patch_global('sourceOptions', #{
            \ vim-lsp: #{
            \ mark: 'lsp',
            \ matchers: ['matcher_head'],
            \ sorters: ['sorter_rank'],
            \ forceCompletionPattern: '\.|:|->|"\w+/*',
            \ maxItems: 5,
            \ }})

call ddc#custom#patch_global('sourceOptions', #{
            \ around: #{
            \ mark: 'A',
            \ maxItems: 5,
            \ },
            \ })

call ddc#custom#patch_global('sourceParams', #{
            \ around: #{ maxSize: 500 },
            \ })

call ddc#enable()
