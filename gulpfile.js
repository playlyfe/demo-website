var gulp = require('gulp');
var browserify = require('gulp-browserify');
var uglify = require('gulp-uglify');
var rename = require('gulp-rename');

var paths = {
  scripts: ["app/app.coffee"],
  sources: ["app/**/*.coffee"]
};

// Gulp task to build website in production environment
gulp.task('build', function() {
  return gulp.src(paths.scripts, { read: false })
            .pipe(browserify({
              transform: ['coffeeify', 'debowerify', 'deamdify'],
              extensions: ['.coffee']
            }))
            .pipe(uglify())
            .pipe(rename('main.js'))
            .pipe(gulp.dest('public/lib'));
});

// Gulp task to build website in development environment
gulp.task('build-dev', function() {
  return gulp.src(paths.scripts, { read: false })
            .pipe(browserify({
              transform: ['coffeeify', 'debowerify', 'deamdify'],
              extensions: ['.coffee'],
              shim: {
                jquery: {
                  path: './public/components/jquery/dist/jquery.js',
                  exports: '$'
                },
                moment: {
                  path: './public/components/moment/moment.js',
                  exports: 'moment'
                },
                'angular': {
                  path: './public/components/angular/angular.js',
                  depends: {
                    jquery: '$',
                    sockjs: 'SockJS'
                  },
                  exports: 'angular'
                },
                'angular-resource': {
                  path: './public/components/angular-resource/angular-resource.js',
                  depends: {
                    'angular': null
                  },
                  exports: null
                },
                'angular-sanitize': {
                  path: './public/components/angular-sanitize/angular-sanitize.js',
                  depends: {
                    'angular': null
                  },
                  exports: null
                },
                'angular-moment': {
                  path: './public/components/angular-moment/angular-moment.js',
                  depends: {
                    'angular': null,
                    'moment': 'moment'
                  },
                  exports: null
                },
                'sockjs': {
                  path: './public/components/sockjs/sockjs.js',
                  exports: 'SockJS'
                }
              },
              debug: true
            }))
            .pipe(rename('main.js'))
            .pipe(gulp.dest('public/lib'));
});

gulp.task('watch', function() {
  gulp.watch(paths.sources, ['build-dev']);
});

gulp.task('default', ['build-dev', 'watch']);
