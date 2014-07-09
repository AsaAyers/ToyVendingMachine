

module.exports = (grunt) ->

    grunt.initConfig
        connect:
            server:
                options:
                    port: 9003

        watch:
            scripts:
                files: [ 'js/**/*.coffee' ]
                tasks: [ 'browserify' ]

        browserify:
            options:
                debug: true
                transform: [
                    'coffeeify'
                ]

            vendingmachine:
                files:
                    'build/index.js':  ['./js/index.coffee' ]

    grunt.loadNpmTasks('grunt-browserify')
    grunt.loadNpmTasks('grunt-contrib-connect')
    grunt.loadNpmTasks('grunt-contrib-watch')



