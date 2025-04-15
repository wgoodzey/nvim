local setup, fluttertools = pcall(require, "flutter-tools")
	if not setup then
		return
  end

fluttertools.setup({})
