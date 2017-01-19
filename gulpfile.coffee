gulp            = require('gulp')
browserifyInc   = require('browserify-incremental')
coffeeify       = require('coffeeify')
fs              = require('fs')
aliasify        = require('aliasify')
hamlify         = require('hamlify')
babelify        = require('babelify')
_               = require('lodash')
mkdirp          = require('mkdirp')
path            = require('path')
runSequence     = require('run-sequence').use(gulp)
source          = require('vinyl-source-stream')
buffer          = require('gulp-buffer')
batch           = require('gulp-batch')
changed         = require('gulp-changed')
notify          = require('gulp-notify')
rename          = require('gulp-rename')
rimraf          = require('gulp-rimraf')
sass            = require('gulp-sass')
sourcemaps      = require('gulp-sourcemaps')
util            = require('gulp-util')
watch           = require('gulp-watch')

gulp.task 'build', (cb) ->
  runSequence(
    'clean',
    'copy-html',
    'sass',
    'coffee-ensure-cache-file',
    'coffee',
    cb
  )

gulp.task 'watch', ->
  gulp.start('build')

  watch([
    'lib/**/*.js',
    'lib/**/*.coffee',
    'lib/**/*.hamlc',
    'doc/**/*.js',
    'doc/**/*.coffee',
    'doc/**/*.hamlc'
  ], { read: false }, batch((events, done) ->
    runSequence('coffee', done)
  ))

  watch([
    'css/**/*.sass',
    'doc/**/*.sass'
  ], { read: false }, batch((events, done) ->
    runSequence('sass', done)
  ))

  watch([
    'doc/**/*.html'
  ], { read: false }, batch((events, done) ->
    runSequence('copy-html', done)
  ))

gulp.task 'clean', ->
  gulp.src([
    'build/**/*.css',
    'build/**/*.js',
    'build/**/*.html',
    'tmp',
  ], { read: false })
  .pipe(rimraf())


# ------------------------------------------------------------------------------------
# coffee

gulp.task 'coffee', ->
  stream = buildBrowserify(['doc/index.coffee'], {
    debug:      true
    extensions: [".coffee", ".js", ".json"]
    cacheFile:  'tmp/browserify.json'
    paths: ['node_modules']
  })
  stream = appendError(stream, 'Coffee Error')
  stream = stream.pipe(source('index.js'))
  stream = stream.pipe(buffer())
  stream = stream.pipe(gulp.dest('build'))
  stream = appendNotify(stream, "Coffee", 'Done compiling')

gulp.task 'coffee-ensure-cache-file', ->
  cacheFile = 'tmp/browserify.json'
  if _.isString(cacheFile)
    try
      fs.accessSync(cacheFile, fs.R_OK)
    catch e
      mkdirp.sync(path.dirname(cacheFile), { mode: (0o755 & (~process.umask())) })
      fs.writeFileSync(cacheFile, JSON.stringify({
        modules: {}
        packages: {}
        mtimes: {}
        filesPackagePaths: {}
        dependentFiles: {}
      }, null, 2))

# ------------------------------------------------------------------------------------
# sass

gulp.task 'sass', ->
  stream = gulp.src('doc/index.sass')
  stream = appendError(stream, "Sass Error")
  stream = stream.pipe(sourcemaps.init())
  stream = stream.pipe(sass({
    indentedSyntax:   true
    errLogToConsole:  true
    includePaths: [
      'css',
      'node_modules/bourbon/app/assets/stylesheets',
      'node_modules',
    ]
  }).on('error', sass.logError))
  stream = stream.pipe(sourcemaps.write())
  stream = stream.pipe(rename('index.css'))
  stream = stream.pipe(gulp.dest('build'))
  stream = appendNotify(stream, "Sass", 'Done compiling')


# ------------------------------------------------------------------------------------
# copy html

gulp.task 'copy-html', ->
  stream = gulp.src('doc/index.html')
  stream = stream.pipe(gulp.dest('build'))
  stream = appendNotify(stream, "HTML", 'Done copying')

# ------------------------------------------------------------------------------------
# helper methods

appendError = (stream, title) ->
  stream.on 'error', (error) ->
    util.log.bind(util, "#{title} - #{error.toString()}")
    util.log(error)

    if config.notify == true
      notify.onError({
        title:    title
        message:  error.toString()
      })(error)

    @emit('end')

appendNotify = (stream, title, message) ->
  stream.pipe(notify({
    title:    title
    message:  message
  }))

buildBrowserify = (files, config) ->
  stream = browserifyInc(files, _.extend(browserifyInc.args, config))
  stream = stream.transform(hamlify, { global: true })
  stream = stream.transform(coffeeify, {
    sourceMap:  true
    global:     true
  })
  stream = stream.transform(babelify, {
    # sourceMapsAbsolute: true
    presets: [
      require('babel-preset-es2015'),
      require('babel-preset-es2016')
    ]
  })
  stream = stream.transform(aliasify, { global: true, aliases: { 'vue': 'vue/dist/vue' } })
  stream = appendError(stream, 'Curo Coffee Error')
  stream = stream.bundle()
  stream



