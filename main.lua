Component = require("component")
package.loaded["ARWidgets"] = nil
AR = require("ARWidgets")
local glasses = Component.glasses
glasses.removeAll()
--Test for changes
--ARG.hudText(glasses, "Test ", 10, 10, 0x00FFFF, 0)

text1 = AR.popupText(glasses, "Test For Rodney", 0, 10, 0x00FFFF)
AR.minimapOverlay(glasses)
os.sleep(10)
text1()

os.sleep(0)