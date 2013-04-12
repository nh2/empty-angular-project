# Filters


angular.module("project.filters", []).filter "checkmark", ->
  (input) -> if input then "✓" else "✘"
