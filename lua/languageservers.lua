local languageservers = {}

function languageservers.setup (cap)
    require'lspconfig'.hls.setup{cap}
    require'lspconfig'.pyright.setup{cap}
    require'lspconfig'.clangd.setup{cap}
    require'lspconfig'.eslint.setup{cap}
    require'lspconfig'.tsserver.setup{cap}
    require'lspconfig'.rls.setup{cap}
    require'lspconfig'.cmake.setup{cap}
end

return languageservers
