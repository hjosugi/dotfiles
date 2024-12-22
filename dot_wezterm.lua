local wezterm = require("wezterm")
-- config.default_prog = { "nu.exe" }

local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- カラースキームの設定(おすすめはMaterialDesignColors)
config.color_scheme = "MaterialDesignColors"

-- 背景透過
config.window_background_opacity = 0.85

local mux = wezterm.mux
wezterm.on("gui-startup", function(cmd)
	local tab, pane, window = mux.spawn_window(cmd or { width = 158, height = 56 })
	window:gui_window():set_position(0, 0)
	window:set_inner_size(700, 1000)
end)
config.font = wezterm.font("FirgeNerd Console")

-- ショートカットキー設定
local act = wezterm.action
config.keys = {
	-- Alt(Opt)+Shift+Fでフルスクリーン切り替え
	{
		key = "f",
		mods = "SHIFT|META",
		action = wezterm.action.ToggleFullScreen,
	},
	-- Ctrl+Shift+tで新しいタブを作成
	{
		key = "t",
		mods = "SHIFT|CTRL",
		action = act.SpawnTab("CurrentPaneDomain"),
	},
	-- Ctrl+Shift+dで新しいペインを作成(画面を分割)
	{
		key = "d",
		mods = "SHIFT|CTRL",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	-- Ctrl+左矢印でカーソルを前の単語に移動
	{
		key = "LeftArrow",
		mods = "CTRL",
		action = act.SendKey({
			key = "b",
			mods = "META",
		}),
	},
	-- Ctrl+右矢印でカーソルを次の単語に移動
	{
		key = "RightArrow",
		mods = "CTRL",
		action = act.SendKey({
			key = "f",
			mods = "META",
		}),
	},
	-- Ctrl+Backspaceで前の単語を削除
	{
		key = "Backspace",
		mods = "CTRL",
		action = act.SendKey({
			key = "w",
			mods = "CTRL",
		}),
	},
}
config.default_prog = { "Nu" }

return config
