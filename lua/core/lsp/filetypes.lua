vim.filetype.add({
    extension = {
        gotmpl = "gotmpl",
    },
    pattern = {
        [".*/templates/.*%.yaml"] = "helm",
        [".*/templates/.*%.tpl"] = "helm",
        ["helmfile.*%.yaml"] = "helm",
    },
})
