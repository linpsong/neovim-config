local Plugin = { "williamboman/mason.nvim" }

Plugin.event = "VeryLazy"

function Plugin.config()
	require("mason").setup({
		ui = {
			icons = {
				package_installed = "✓",
				package_pending = "➜",
				package_uninstalled = "✗",
			},
		},
	})
end

Plugin.build = ":MasonUpdate" -- :MasonUpdate updates registry contents

return Plugin
