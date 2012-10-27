# Disables Rainbow's global syntax highlighting on page load, which for some
# reason double-highlights any code in the previewer
if window.removeEventListener
  window.removeEventListener("load", Rainbow.color)
else
  window.detachEvent("onload", Rainbow.color)
