local M = {}

local helm_binary = vim.fn.executable("helm_ls") == 1 and "helm_ls" or "helm-ls"

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
        cmd = { helm_binary, "serve" },
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
    julials = {
        cmd = {
            "julia",
            "--project=" .. vim.fn.expand("~/.julia/environments/lsp/"),
            "--startup-file=no",
            "--history-file=no",
            "-e",
            [[
                using Pkg; Pkg.instantiate()
                using LanguageServer
                depot_path = get(ENV, "JULIA_DEPOT_PATH", "")
                project_path = let
                    p = Base.load_path_expand((
                        p = get(ENV, "JULIA_PROJECT", nothing);
                        p === nothing ? nothing : isempty(p) ? nothing : p
                    ))
                    fp = p === nothing ? Base.current_project() : p
                    fp === nothing ? pwd() : dirname(fp)
                end
                server = LanguageServer.LanguageServerInstance(stdin, stdout, project_path, depot_path)
                server.runlinter = true
                run(server)
            ]],
        },
        filetypes = { "julia" },
        root_markers = { ".git", "Project.toml", "JuliaProject.toml" },
        settings = {},
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

M.systems = {
    deno = {
        cmd = { "deno", "lsp" },
        filetypes = { "json", "jsonc" },
        settings = {
            enable = true,
            lint = true
        }
    },
    bashls = {
        cmd = { "bash-language-server", "start" },
        filetypes = { "sh", "bash" },
        root_markers = { ".git" },
    },
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
}

return M
