return {
	cmd = { "clangd", "--clang-tidy", "--background-index", "--offset-encoding=utf-16" },
	filetypes = { "c", "cpp", "cc", "h", "hpp" },
	root_markers = { ".git", ".clangd" },
}
