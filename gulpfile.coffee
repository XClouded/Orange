gulp = require 'gulp'
path = require 'path'
$ = require('gulp-load-plugins')()

gulp.task 'clean', ->
  gulp.src(['./dist'], read: false)
    .pipe($.clean())

gulp.task 'css', ->
  gulp.src('./scss/*scss')
    .pipe($.compass
      project: path.join(__dirname, '/') # used for no .config.rb
      comments: false
      css: './dist/css'
      sass: './scss'
    )
    .pipe(gulp.dest 'dist/css')
    .pipe($.minifyCss())
    .pipe($.rename extname: '.min.css')
    .pipe(gulp.dest './dist/css')

# i have tried browserify and vinyl-source-stream but ...
# http://viget.com/extend/gulp-browserify-starter-faq
# https://github.com/gulpjs/plugins/issues/47
gulp.task 'scripts', ->
  gulp.src('./scripts/orange.coffee', read: false)
    .pipe($.browserify transform: ['coffeeify'], extensions: ['.coffee'])
    .pipe($.rename extname: '.js')
    .pipe(gulp.dest './dist/js')
    .pipe($.uglify())
    .pipe($.rename extname: '.min.js')
    .pipe(gulp.dest './dist/js')

gulp.task 'default', [
  'clean'
  'css'
  'scripts'
]