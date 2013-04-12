module.exports = (grunt) ->

  # Project configuration.
  grunt.initConfig
    pkg: grunt.file.readJSON("package.json")

    # Variables for storing where which files are.
    # Used in the other directives.
    src:
      coffee: ["app/**/*.coffee"]
      stylus: ["app/**/*.styl"]
      coffee_test: ["test/**/*.coffee"]


    # Variables for storing names of generated files for convenience.
    # Used in the other directives.
    dest:
      all_js: "build/all.js"
      all_js_min: "build/all.min.js"

    # Minimization
    # - needs grunt-contrib-uglify
    uglify:
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

        expand: true
        src: ["<%= src.stylus %>"]
        dest: "build/"
        ext: ".css"

    # Runs webserver and tests
    # - needs grunt-shell
    shell:
      server:
        command: "node scripts/web-server.js"
      unittests:
        command: "./scripts/test.sh --single-run"
      e2etests:
        command: "./scripts/e2e-test.sh"

    # Automatic rebuilding on file change
    # - needs grunt-contrib-watch
    watch:
      coffee:
        files: ["<%= src.coffee %>", "<%= src.coffee_test %>"]
        tasks: "coffee"
      stylus:
        files: ["<%= src.stylus %>"]
        tasks: "stylus"
      uglify:
        files: ["<%= uglify.build.src %>"]
        tasks: "uglify"

    # Cleaning of generated files
    # - needs grunt-contrib-clean
    clean: ["build/"]


  # Load plugins.
  grunt.loadNpmTasks "grunt-contrib-watch"
  grunt.loadNpmTasks "grunt-contrib-clean"
  grunt.loadNpmTasks "grunt-contrib-uglify"
  grunt.loadNpmTasks "grunt-contrib-coffee"
  grunt.loadNpmTasks "grunt-contrib-stylus"
  grunt.loadNpmTasks "grunt-shell"


  # Top-level tasks

  # Build
  grunt.registerTask "build", ["coffee", "stylus", "uglify"]

  # Development server
  grunt.registerTask "server", ["shell:server"]

  # Run unit and e2e test suites once.
  grunt.registerTask "test", ["shell:unittests", "shell:e2etests"]
  # For auto-refresh unit testing, run ./scripts/test.sh.

  # Build first, then keep watching.
  grunt.registerTask "buildwatch", ["build", "watch"]

  # Default task(s).
  grunt.registerTask "default", ["buildwatch"]
