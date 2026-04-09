local M = {}

local function get_json_schemas()
    local ok, schemastore = pcall(require, "schemastore")
    return ok and schemastore.json.schemas() or {}
end

local function get_yaml_schemas()
    local ok, schemastore = pcall(require, "schemastore")
    return ok and schemastore.yaml.schemas() or {}
end

M.common = {
    dockerls = {
        cmd = { "docker-langserver", "--stdio" },
        filetypes = { "dockerfile" },
        root_markers = { "Dockerfile", "docker-compose.yml", "docker-compose.yaml" }
    },
    helm_ls = {
        cmd = { "helm_ls", "serve" },
        filetypes = { "helm" },
        root_markers = { "Chart.yaml", "Chart.yml" },
    },
    gopls = {
        cmd = { "gopls" },
        filetypes = { "go", "gomod", "gowork", "gotmpl" },
        root_markers = { "go.work", "go.mod", ".git" },
        settings = {
            gopls = {
                completeUnimported = true,
                usePlaceholders = true,
                staticcheck = true,
                analyses = { unusedParams = true },
            },
        },
    },
    lua_ls = {
        cmd = { "lua-language-server" },
        filetypes = { "lua" },
        root_markers = { ".luarc.json", ".luarc.jsonc", ".git" },
        settings = {
            Lua = {
                workspace = {
                    checkThirdParty = false,
                    library = {
                        vim.env.VIMRUNTIME,
                        vim.fn.stdpath("config") .. "/lua",
                    },
                },
                diagnostics = { globals = { "vim" } },
                completion = { callSnippet = "Replace" },
                telemetry = { enable = false },
            },
        },
    },
    jsonls = {
        cmd = { "vscode-json-language-server", "--stdio" },
        filetypes = { "json",  "jsonc"},
        on_new_config = function(new_config)
            new_config.settings.json.schemas = get_json_schemas()
        end,
        settings = {
            json = {
                validate = { enable = true }
            }
        },
    },
    yamlls = {
        cmd = { "yaml-language-server", "--stdio" },
        filetypes = { "yml", "yaml" },
        on_new_config = function(new_config)
            new_config.settings.yaml.schemas = get_yaml_schemas()
        end,
        settings = {
            yaml = {
                schemaStore = { enable = false, url = "" },
            }
        }
    },
}

M.workstation = {
    pyright = {
        cmd = { "pyright-langserver", "--stdio" },
        filetypes = { "python" },
        root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", "Pipfile", "pyrightconfig.json", ".git" },
        settings = {
            python = {
                analysis = {
                    autoSearchPaths = true,
                    diagnosticMode = "openFilesOnly",
                    useLibraryCodeForTypes = true,
                },
            },
        },
    },
    ts_ls = {
        cmd = { "typescript-language-server", "--stdio" },
        filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact", "vue" },
        root_markers = { "package.json", "tsconfig.json", "jsconfig.json", ".git" },
    },
    cssls = {
        cmd = { "vscode-css-language-server", "--stdio" },
        filetypes = { "css", "scss", "less", },
        root_markers = { "package.json" },
        settings = {
            css = { validate = true },
            scss = { validate = true },
            less = { validate = true },
            hover = {
                documentation = true,
                references = true,
            },
        },
    },
    html = {
        cmd = { "vscode-html-language-server", "--stdio" },
        filetypes = { "htm", "html" },
        root_markers = {},
        settings = {
            html = {
                autoClosingTags = true,
                autoCreateQuotes = "doublequotes",
                format = {
                    enable = true,
                    wrapLineLength = 120,
                },
                hover = {
                    documentation = true,
                    references = true,
                },
                mirrorCursorOnMatchingTag = false,
                validate = {
                    scripts = true,
                    styles = true,
                },
            }
        }
    }
}

M.systems = {
    clangd = {
        cmd = {
            "clangd",
            "--clang-tidy",
            "--background-index",
            "--offset-encoding=utf-8",
        },
        root_markers = { ".clangd", "compile_commands.json", "CMakeLists.txt", ".git" },
        filetypes = { "c" },
    },
    rust_analyzer = {
        cmd = { "rust-analyzer" },
        filetypes = { "rust" },
        root_markers = { "Cargo.toml", ".git" },
        settings = {
            ["rust_analyzer"] = {
                inlayHints = {
                },
            },
            checkOnSave = { command = "clippy" },
            procMacro = { enable = true },
        },
    },
    ols = {
        cmd = { "ols" },
        filetypes = { "odin" },
        root_markers = { "ols.json", ".git" },
    },
    nimlangserver = {
        cmd = { "nimlangserver" },
        filetypes = { "nim" },
        root_markers = { "nim.nimble", "package.nim", "config.nims", ".git" },
        settings = {
            nim = {
                nimsuggestPath = "/usr/bin/nimsuggest",
                nimSearchPaths = {
                    '/usr/lib/nim/lib',
                },
            },
        },
    },
}

return M
