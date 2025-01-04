-- Neovim "邪魔モード"プラグイン
-- 作者: あなた
-- 説明: Neovimを邪魔的に振る舞わせるネタプラグイン

local interference = {}

-- コンフィグ設定
interference.config = {
  enable_colors = true,
  enable_scroll = true,
  enable_errors = true,
  enable_files = true,
  enable_break = true,
  start_shortcut_key = "<leader>rb",
  stop_shortcut_key = "<leader>rq"
}

-- 設定を更新
function interference.setup(user_config)
  interference.config = vim.tbl_extend("force", interference.config, user_config)
end

-- 意味を持つエラーメッセージのリスト
local error_messages = {
  "Error 42-B: Quantum flux alignment failed. Please recalibrate the continuum.",
  "Warning: The noodle length exceeds the pasta threshold. Cutting recommended.",
  "Fatal Error: Cats exceeded maximum curiosity limit.",
  "System Halted: Unexpected interdimensional ping detected.",
  "Error 808: Infinite loop in finite playlist detected. Dance mode activated.",
  "Error X-12: The toaster refuses to comply. Negotiation required.",
  "Critical Failure: Moonlight misaligned with starlight. Reboot under the full moon.",
  "Error 314: Pie integrity compromised. Reconstruct the filling matrix.",
  "System Error: Schrödinger's cat encountered. Status both running and crashed.",
  "Error 101010: Binary conflict in the existential stack. Divide by life.",
  "Error 7-Z: Hyperbolic time chamber overflow. Please invert the timeline.",
  "Warning: Too many ducks in the quantum pond. Reduce fowl density.",
  "Fatal Error: Coffee machine achieved sentience. Prepare for negotiation.",
  "System Halted: Temporal paradox detected. Await causality repair.",
  "Error 5050: Unexpected recursion while resolving recursion.",
  "Error G-99: Gravitational anomaly in the snack drawer. Relocate cookies.",
  "Critical Error: Dream buffer full. Clear unconscious thought cache.",
  "Warning: Reality out of sync with perception. Please recalibrate your eyes.",
  "System Error: Infinite monkeys detected. Reboot the Shakespeare compiler.",
  "Error M-404: Missing marmalade. System requires more toast.",
  "Warning: Banana peel in the logical path. Proceed with caution.",
  "Critical Failure: Unicorn horn decoder malfunction. Enable rainbow mode.",
  "Error 0xBEEF: Insufficient bacon in the main stack. Add more breakfast.",
  "Fatal Error: Over-enthusiastic penguins attempting to colonize the CPU.",
  "System Halted: Syntax error in the cosmic equation. Rerun the universe.",
  "Error 123-ABC: Misalignment in the fictional narrative. Rewrite required.",
  "Warning: Catnip overflow in the feline processor. Pause for playtime.",
  "Error 404-BRAIN: Idea not found. Please try thinking harder.",
  "System Error: The potato battery has achieved critical mass.",
  "Critical Warning: The algorithm detected irony and crashed ironically."
}

-- 意味のあるエラーメッセージをランダムに吐く
local function meaningful_error()
  if not interference.config.enable_errors then return end
  local message = error_messages[math.random(#error_messages)]
  vim.api.nvim_err_writeln("邪魔: " .. message)
end

-- ランダムなハイライトと色変化
local function randomly_change_colors()
  if not interference.config.enable_colors then return end

  local function generate_color()
    local r, g, b
    repeat
      r, g, b = math.random(0, 200), math.random(0, 200), math.random(0, 200)
    until math.abs(r - g) > 50 or math.abs(g - b) > 50 or math.abs(b - r) > 50
    return string.format("#%02x%02x%02x", r, g, b)
  end

  local fg_color = generate_color()
  local bg_color = generate_color()
  vim.cmd("highlight Normal guifg=" .. fg_color .. " guibg=" .. bg_color)
  vim.api.nvim_echo({{"こっちのほうが見やすいでしょ？", "WarningMsg"}}, true, {})
end

-- 自動ランダムスクロールの気まぐれ
local function randomly_scroll()
  if not interference.config.enable_scroll then return end

  local total_lines = vim.fn.line("$")
  local target_line = math.random(1, total_lines)
  vim.api.nvim_win_set_cursor(0, {target_line, 0})
  vim.api.nvim_echo({{"ここが見たかったんだよね", "WarningMsg"}}, true, {})
end

-- 休憩メッセージとモーダル制御
local function display_break_message()
  if not interference.config.enable_break then return end
  vim.cmd("echohl WarningMsg | echomsg '1分たったよ！そろそろ休憩しよう！' | echohl None")
  vim.cmd("autocmd CursorMoved * stopinsert | echom '動かないで！休憩中！'")
end

-- 定期的に別のファイルを開く
local function open_random_file()
  local files = vim.fn.globpath(vim.fn.getcwd(), "*", false, true)
  if #files > 0 then
    local random_file = files[math.random(#files)]
    vim.cmd("edit " .. random_file)
    vim.api.nvim_echo({{"気分転換にこっちを編集しよう！", "WarningMsg"}}, true, {})
  end
end

-- ランダムに行を非表示（折りたたむ）
local function randomly_hide_lines()
  if not interference.config.enable_scroll then return end

  local total_lines = vim.fn.line("$")
  if total_lines > 1 then
    local start_line = math.random(1, total_lines)
    local end_line = math.min(start_line + math.random(0, 5), total_lines)
    vim.cmd(start_line .. "," .. end_line .. "fold")
    vim.api.nvim_echo({{"その行、邪魔だったでしょ？", "WarningMsg"}}, true, {})
  else
    vim.api.nvim_echo({{"隠す行がもうないよ！", "WarningMsg"}}, true, {})
  end
end



-- 主な邪魔機能をランダムに実行
local function trigger_interference()
  local actions = {}
  if interference.config.enable_colors then table.insert(actions, randomly_change_colors) end
  if interference.config.enable_scroll then table.insert(actions, randomly_scroll) end
  if interference.config.enable_errors then table.insert(actions, meaningful_error) end
  if interference.config.enable_scroll then table.insert(actions, randomly_hide_lines) end

  if #actions > 0 then
    local action = actions[math.random(1, #actions)]
    action()
  end
end

-- 邪魔をバックグラウンドで高速実行
local function start_background_interference()
  local timer = vim.loop.new_timer()
  timer:start(500, 1500, vim.schedule_wrap(function()
    trigger_interference()
  end))

  if interference.config.enable_break then
    local break_timer = vim.loop.new_timer()
    break_timer:start(60000, 60000, vim.schedule_wrap(display_break_message))
    interference.break_timer = break_timer
  end

  if interference.config.enable_files then
    local file_timer = vim.loop.new_timer()
    file_timer:start(120000, 120000, vim.schedule_wrap(open_random_file))
    interference.file_timer = file_timer
  end

  interference.timer = timer
end

-- 定期的に邪魔を実行
function interference.start()
  vim.api.nvim_create_augroup("InterferenceMode", { clear = true })
  start_background_interference()
  print("邪魔モードが始まりました！")
end

-- 停止
function interference.stop()
  if interference.timer then
    interference.timer:stop()
    interference.timer:close()
    interference.timer = nil
  end
  if interference.break_timer then
    interference.break_timer:stop()
    interference.break_timer:close()
    interference.break_timer = nil
  end
  if interference.file_timer then
    interference.file_timer:stop()
    interference.file_timer:close()
    interference.file_timer = nil
  end
  vim.cmd("highlight clear Normal")
  print("邪魔モードが終了しました。")
end

vim.api.nvim_set_keymap('n', interference.config.start_shortcut_key, ':lua require("interference").start()<CR>', {noremap = true, silent = true})
vim.api.nvim_create_user_command(
  'InterferenceStart',
  function() require('interference').start() end,
  { desc = 'Start interference mode' }
)
vim.api.nvim_set_keymap('n', interference.config.stop_shortcut_key, ':lua require("interference").stop()<CR>', {noremap = true, silent = true})
vim.api.nvim_create_user_command(
  'InterferenceStop',
  function() require('interference').stop() end,
  { desc = 'Stop interference mode' }
)

return interference

