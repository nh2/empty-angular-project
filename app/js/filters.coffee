# Filters


angular.module("project.filters", [])
  .filter "checkmark", ->
    (input) -> if input then "✓" else "✘"


  # Replaces with regex in the given string.
  #
  # Usage: {{ expression | regexReplace: 'f.*o':'bar' }}
  .filter "regexReplace", ->

    (input, searchRegex, replaceRegex) ->

      if searchRegex is undefined
        throw "regexReplace: you must specify a search string"
      if replaceRegex is undefined
        throw "regexReplace: you must specify a replacement string"

      return input.replace RegExp(searchRegex), replaceRegex


  # Runs encodeURIComponent on the input.
  .filter "urlEncode", ->
    (value) -> encodeURIComponent value


  # Runs decodeURIComponent on the input.
  .filter "urlDecode", ->
    (value) -> decodeURIComponent value
