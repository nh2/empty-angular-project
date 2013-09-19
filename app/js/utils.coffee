# Utilities


utils = angular.module("project.utils", [])


# Do not forget to add new functions to the "Exported functions" at the end!
utils.factory "utils", ["$q", ($q) ->


  # Converts an angular $resource 'future' value `resource` to a $q promise.
  # The promise success callback will be given the returned data.
  # The promise reject callback will be given the $http error response.
  # Example:
  #
  #     p = resourceToPromise (Phones.get { vendor: 'v' })
  #
  #     p.then (phones) -> console.log phones
  #
  # This function becomes unnecessary once angular allows getting promises
  # directly from resources; this will probably happen in angular 1.2.0 or earlier.
  # See: https://github.com/angular/angular.js/pull/2060
  resourceToPromise = (resource, selectorFn) ->
    if not resource
      throw new Error "resourceToPromise: missing resource"

    do ->  # Critical to not share freaking variables!
      d = $q.defer()
      resource.$then (res) ->
        # If we did `d.resolve res` here instead to return the resource 'value'
        # iself, the resolve action will never be called. This is probably
        # because angular detects it as some kind of 'future' value.
        # We could circumvent that by `delete res.$then`, but this is ugly
        # since .$then will probably be removed soon.
        d.resolve res.data
      , (err) ->
        d.reject err

      return d.promise
