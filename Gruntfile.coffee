module.exports = (grunt) ->

  # Project configuration.
  grunt.initConfig
    pkg: grunt.file.readJSON("package.json")

    # Variables for storing where which files are.
    # Used in the other directives.
    src:
      coffee: ["app/**/*.coffee"]
      plain: ["app/**/*.js"]
      stylus: ["app/**/*.styl"]
      coffee_test: ["test/**/*.coffee"]
      lib: [
        "components/jquery/jquery.js"
        "components/underscore/underscore.js"
        # jQuery must be before angular for selectors
        "components/angular/angular.js"
        "components/angular/angular-resource.js"
        "components/bootstrap/docs/assets/js/bootstrap.js"
      ]


    # Variables for storing names of generated files for convenience.
    # Used in the other directives.
    dest:
      all_js: "build/all.js"
      all_js_min: "build/all.min.js"

      plain_js: "build/plain.js"
      plain_js_min: "build/plain.min.js"

      lib_js: "build/lib.js"
      lib_js_min: "build/lib.min.js"

    # Concatenation of JS files
    # - needs grunt-contrib-concat
    concat:
      plain:
        src: "<%= src.plain %>"
        dest: "<%= dest.plain_js %>"
      lib:
        src: "<%= src.lib %>"
        dest: "<%= dest.lib_js %>"

    # Minimization
    # - needs grunt-contrib-uglify
    uglify:
      lib:
        src: "<%= dest.lib_js %>"
        dest: "<%= dest.lib_js_min %>"
      build:
        src: "<%= dest.all_js %>"
        dest: "<%= dest.all_js_min %>"

    # .coffee -> .js compilation
    # - needs grunt-contrib-coffee
    coffee:
      options:
        sourceMap: true
        bare: true

      # Compiles each .coffee files into a .js file.
      compile_recursive:
        expand: true
        src: ["<%= src.coffee %>", "<%= src.coffee_test %>"]
        dest: "build/"
        ext: ".js"

      # Compiles all .coffee files into a single .js file.
      compile_concat:
        files:
          "<%= dest.all_js %>": ["<%= src.coffee %>"]

    # .styl -> .css compilation
    # - needs grunt-contrib-stylus
    stylus:
      compile_recursive:
        options:
          # dirs to scan for @import directives
          paths: []
          'include css': true

        expand: true
        src: ["<%= src.stylus %>"]
        dest: "build/"
        ext: ".css"

    # Runs webserver and tests
    # - needs grunt-shell
    shell:
      options: { stdout: true }

      server:
        command: "node scripts/web-server.js"
      vogue:
        command: "vogue --rewrite='static/:'"
      unittests:
        command: "./scripts/test.sh --single-run"
      e2etests:
        command: "./scripts/e2e-test.sh"

    # Automatic rebuilding on file change
    # - needs grunt-contrib-watch
    watch:
      concat:
        files: ["<%= src.lib %>", "<%= src.plain %>"]
        tasks: "concat"
      coffee:
        files: ["<%= src.coffee %>", "<%= src.coffee_test %>"]
        tasks: "coffee"
      stylus:
        files: ["<%= src.stylus %>"]
        tasks: "stylus"
      # We don't currently need JS minification.
      # uglify:
      #   files: ["<%= uglify.build.src %>", "<%= uglify.lib.src %>"]
      #   tasks: "uglify"

    # Running tasks in parallel, especially for running different watchers at the same time
    # (such as coffee, stylus and vogue) with a single 'grunt dev' command.
    # - needs grunt-parallel
    parallel:
      dev:
        grunt: true
        tasks: ['shell:vogue', 'watch']

    # Running tasks in parallel, especially for running different watchers at the same time
    # (such as coffee, stylus and vogue) with a single 'grunt dev' command.
    # - needs grunt-parallel
    parallel:
      dev:
        grunt: true
        tasks: ['shell:vogue', 'watch']

    # Cleaning of generated files
    # - needs grunt-contrib-clean
    clean: ["build/"]


  # Load plugins.
  grunt.loadNpmTasks "grunt-contrib-watch"
  grunt.loadNpmTasks "grunt-contrib-clean"
  grunt.loadNpmTasks "grunt-contrib-concat"
  grunt.loadNpmTasks "grunt-contrib-uglify"
  grunt.loadNpmTasks "grunt-contrib-coffee"
  grunt.loadNpmTasks "grunt-contrib-stylus"
  grunt.loadNpmTasks "grunt-shell"
  grunt.loadNpmTasks "grunt-parallel"


  # Top-level tasks

  # Build
  grunt.registerTask "build", ["concat", "coffee", "stylus"] # "uglify"

  # Development server
  grunt.registerTask "server", ["shell:server"]

  # Stylesheet development live reloading server
  grunt.registerTask "vogue", ["shell:vogue"]

  # Run unit and e2e test suites once.
  grunt.registerTask "test", ["shell:unittests", "shell:e2etests"]
  # For auto-refresh unit testing, run ./scripts/test.sh.

  # Build first, then keep watching files managed by grunt (only).
  grunt.registerTask "buildwatch", ["build", "watch"]

  # The ultimate development target.
  # Build first, then runs all fancy development watchers in parallel.
  grunt.registerTask "dev", ["", "parallel:dev"]
  # NOTE: With the current grunt-parallel 0.1.0, this hides the output
  # of the called targets! Use 'grunt' and 'grunt vogue' manually until fixed.

  # Default task(s).
  grunt.registerTask "default", ["buildwatch"]
