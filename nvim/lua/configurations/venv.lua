local M = {}

local function detect_venv()
  local env = os.getenv("VIRTUAL_ENV")
  if env and vim.uv.fs_stat(env) then
    return env
  end
  local local_venv = vim.fn.getcwd() .. "/.venv"
  if vim.uv.fs_stat(local_venv) then
    return local_venv
  end
  return nil
end

local function find_site_packages(venv)
  if not venv then return nil end
  local matches = vim.fn.glob(venv .. "/lib/python*/site-packages", false, true)
  return matches[1]
end

local cached
function M.info()
  if cached then return cached end
  local venv = detect_venv()
  local robotcode_cmd = (venv and vim.fn.executable(venv .. "/bin/robotcode") == 1)
      and (venv .. "/bin/robotcode")
      or "robotcode"
  local python_exec = (venv and vim.fn.executable(venv .. "/bin/python") == 1)
      and (venv .. "/bin/python")
      or "python3"
  cached = {
    venv = venv,
    robotcode_cmd = robotcode_cmd,
    python_exec = python_exec,
    site_packages = find_site_packages(venv),
  }
  return cached
end

return M
