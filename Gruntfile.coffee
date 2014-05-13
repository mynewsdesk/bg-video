module.exports = (grunt) ->

  log = grunt.log

  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'

    # grunt coffee
    coffee:
      compile:
        expand: true
        cwd: 'src'
        src: ["**/*.coffee"]
        dest: 'dist/'
        ext: '.js'
        options:
          bare: true
          preserve_dirs: true

    # uglify
    uglify:
      options:
        banner: '/*! <%= pkg.name %> <%= grunt.template.today("yyyy-mm-dd") %> */\n'
      build:
        src: 'dist/bg_video.js'
        dest: 'dist/bg_video.min.js'

    # watching
    watch:
      scripts:
        files: '<%= uglify.build.src %>'
        tasks: ['uglify']
      coffee:
        files: '<%= coffee.compile.src %>'
        tasks: ['coffee']

  # Load plugins
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-uglify'

  # Tasks
  grunt.registerTask 'default', ['coffee', 'uglify', 'watch']
