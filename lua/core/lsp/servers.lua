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
    sqls = {
        cmd = { "sqls" },
        filetypes = { "sql", "mysql", "plsql" },
        root_markers = { ".sqls.yml", ".git" },
    },
    dockerls = {
        cmd = { "docker-langserver", "--stdio" },
        filetypes = { "dockerfile" },
        root_markers = { "Dockerfile", "docker-compose.yml", "docker-compose.yaml" }
    },
    helm_ls = {
        cmd = { "helm-ls", "serve" },
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
    yamlls = {
        cmd = { "yaml-language-server", "--stdio" },
        filetypes = { "yaml" },
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
    powershell_es = {
        cmd = { "pwsh", "-NoProfile", "-Function", "PowerShellEditorServices" },
        filetypes = { "ps1", "psm1", "psd1" },
        root_markers = { ".git" },
        settings = {
            powershell = {
                codeFormatting = {
                    preset = "OTBS",
                },
            },
        },
    },
    roslyn_ls = {
        cmd = { "roslyn-language-server", "--stdio" },
        filetypes = { "cs", "razor" },
        root_markers = {
            function(name)
                return name:match("%.sln$") or name:match("%.csproj$")
            end,
            ".git",
        },
        settings = {
            ["csharp|background_analysis"] = {
                dotnet_analyzer_diagnostics_scope = "openFiles",
                dotnet_compiler_diagnostics_scope = "openFiles",
            },
            ["csharp|symbol_search"] = {
                dotnet_search_reference_assemblies = true,
            },
            ["csharp|completion"] = {
                dotnet_show_completion_items_from_unimported_namespaces = true,
                dotnet_show_name_completion_suggestions = true,
            },
        },
    },
    jsonls = {
        cmd = { "vscode-json-language-server", "--stdio" },
        filetypes = { "json", "jsonc" },
        on_new_config = function(new_config)
            new_config.settings.json.schemas = get_json_schemas()
        end,
        settings = {
            json = {
                validate = { enable = true }
            }
        },
    },
    basedpyright = {
        cmd = { "basedpyright-langserver", "--stdio" },
        filetypes = { "python" },
        root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", "Pipfile", "pyrightconfig.json", ".git" },
        settings = {
            python = {
                analysis = {
                    autoSearchPaths = true,
                    autoImportCompletions = true,
                    diagnosticMode = "workspace",
                    useLibraryCodeForTypes = true,
                    typeCheckingMode = "standard",
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
        filetypes = { "html" },
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

return M
