require("jupytext").setup({
    style = "markdown",
    output_format = "md",
    custom_language_formatting = {
        python = {
            extension = "md",
            style = "markdown",
            force_ft = "markdown",
        },
    },
})
