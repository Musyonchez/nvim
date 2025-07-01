-- Set pylint to work in virtualenv
require("lint").linters.pylint.cmd = "python"
require("lint").linters.pylint.args = { "-m", "pylint", "-f", "json" }

-- it doesn't work
