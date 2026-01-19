vim.api.nvim_create_autocmd("CursorHold", {
    callback = function()
        vim.diagnostic.open_float(nil, {
            focus = false,
            focusable = false,
            border = "rounded",
            source = "always",
        })
    end,
})

vim.keymap.set('n', 'gD', function()
    vim.cmd('vsplit')
    vim.lsp.buf.definition()
end, { desc = "Go to definition (vertical split)" })

vim.opt.completeopt = { "menuone", "noselect", "popup" }

local on_attach = function(client, bufnr)
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

    vim.lsp.completion.enable(
        true,
        client.id,
        bufnr,
        {
            autotrigger = true,
        }
    )
    vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr })
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr })
    vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = bufnr })
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = bufnr })
end

vim.lsp.config["lua_ls"] = {
    cmd = { "lua-language-server" },
    filetypes = { "lua" },
    root_markers = { ".git" },
    settings = {
        Lua = {
            runtime = { version = "LuaJIT" },
            diagnostics = { globals = { "vim" } },
            workspace = { library = vim.api.nvim_get_runtime_file("", true)},
            telemetry = { enable = true }
        },
    },
    on_attach = on_attach

}

vim.lsp.config["clangd"] = {
    cmd = { "clangd", "--background-index", "--clang-tidy" },
    filetypes = { "c", "cpp", "objc", "objcpp" },
    root_markers = {
        "compile_commands.json",
        "compile_flags.txt",
        ".git",
    },
    on_attach = on_attach,
    capabilities = vim.lsp.protocol.make_client_capabilities(),
}
