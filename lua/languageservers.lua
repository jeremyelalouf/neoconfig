local languageservers = {}

function languageservers.setup (cap)
    require'lspconfig'.rust_analyzer.setup{cap}
    require'lspconfig'.hls.setup{cap}
    require'lspconfig'.pyright.setup{cap}
    require'lspconfig'.clangd.setup{cap}
    require'lspconfig'.eslint.setup{cap}
    require'lspconfig'.tsserver.setup{cap}
    require'lspconfig'.cmake.setup{cap}
    require'lspconfig'.dockerls.setup{cap}
    require'lspconfig'.docker_compose_language_service.setup{cap}
end

return languageservers
