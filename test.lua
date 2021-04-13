local logger = hs.logger.new("test", "debug")

local pkg = require("UrlHandler2")
pkg.logger.setLogLevel("debug")
pkg.customBrowsers = {
    {id = "browser1.bundle.id", name = "Browser1 Name", label = "b1"},
    {id = "com.apple.Safari", name = "Safari2", label = "saf1"}
}
-- local urlHandler = pkg:start()
-- logger.df("_label2BundleMap = %s", hs.inspect(urlHandler._label2BundleMap))
-- urlHandler:show("https://github.com")

