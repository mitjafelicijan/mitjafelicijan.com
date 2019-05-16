'use strict';

const util = require('util');
const gulp = require('gulp');
const concat = require('gulp-concat');
const terser = require('gulp-terser');
const clean = require('gulp-clean-css');
const settings = require('./settings.js');
const minify = require('html-minifier').minify;

const fs = require('fs');
const markdown = require('markdown-it');
const prism = require('markdown-it-prism');
const nunjucks = require('nunjucks');
const yaml = require('yaml');
const slugify = require('slugify');
const dayjs = require('dayjs');

const md = new markdown({
  html: true,
  linkify: false,
  typographer: true,
  breaks: true,
})
  .use(prism)
  .use(require('markdown-it-table').markdownItTable)
  .use(require('markdown-it-deflist'))
  .use(require('markdown-it-footnote'))
  .use(require('markdown-it-anchor'))
  .use(require('markdown-it-checkbox'))

nunjucks.configure('source/layouts', {
  autoescape: false,
  noCache: true,
});

gulp.task('js', () => gulp.src(settings.assets.javascript)
  .pipe(concat('bundle.js'))
  .pipe(terser())
  .pipe(gulp.dest('tmp'))
);

gulp.task('css', () => gulp.src(settings.assets.css)
  .pipe(concat('bundle.css'))
  .pipe(clean({}))
  .pipe(gulp.dest('tmp'))
);

gulp.task('copy-robots', () => gulp.src('robots.txt')
  .pipe(gulp.dest('public'))
);

gulp.task('copy-files', () => gulp.src('content/files/**/*')
  .pipe(gulp.dest('public/files'))
);

gulp.task('generate-static', function (done) {
  fs.readdir('content', function (err, items) {

    let posts = [];
    items.forEach(item => {
      if (item.endsWith('.md')) {

        processMarkdown(`content/${item}`);

        let contents = fs.readFileSync(`content/${item}`, 'utf8');
        let raw = contents.split('---');
        let meta = null;

        try {
          meta = yaml.parse(raw[1])
        } catch (error) { }

        if (meta.layout == 'post') {
          meta.dateFormatted = dayjs(meta.date).format('MMMM D, YYYY');
          meta.dateOriginal = meta.date;
          meta.date = new Date(meta.date);
          posts.push(meta)
        }
      }
    });

    const css = fs.readFileSync('tmp/bundle.css', 'utf8');
    const javascript = fs.readFileSync('tmp/bundle.js', 'utf8');

    let page = nunjucks.render(`index.njk`, {
      css: `<style>${css}</style>`,
      javascript: `<script>${javascript}</script>`,
      currentYear: new Date().getFullYear(),
      timestamp: Math.floor(Date.now() / 1000),
      vars: settings.vars,
      posts: posts.reverse(),
    });

    util.log(`Processing: Index`);

    fs.writeFileSync(`public/index.html`, minify(page, {
      removeAttributeQuotes: true,
      collapseWhitespace: true,
      removeComments: true,
      removeTagWhitespace: true,
    }));

  });

  done();
});

const processMarkdown = (file) => {
  const contents = fs.readFileSync(file, 'utf8');
  let raw = contents.split('---');
  let meta = null;

  try {
    meta = yaml.parse(raw[1])
  } catch (error) { }

  //const slug = slugify(meta.title, { lower: true });
  const slug = meta.slug;
  const css = fs.readFileSync('tmp/bundle.css', 'utf8');
  const javascript = fs.readFileSync('tmp/bundle.js', 'utf8');

  raw.shift();
  raw.shift();

  let post = nunjucks.render(`${meta.layout}.njk`, {
    content: md.render(raw.join('')),
    title: meta.title, //.substring(0, 65)
    description: meta.description,
    css: `<style>${css}</style>`,
    javascript: `<script>${javascript}</script>`,
    slug: slug,
    currentYear: new Date().getFullYear(),
    timestamp: Math.floor(Date.now() / 1000),
    vars: settings.vars,
    writtenDate: {
      formatted: dayjs(meta.date).format('MMMM D, YYYY'),
      original: meta.date,
    },
  });

  util.log(`Processing: ${meta.title}`);

  fs.writeFileSync(`public/${slug}.html`, minify(post, {
    removeAttributeQuotes: true,
    collapseWhitespace: true,
    removeComments: true,
    removeTagWhitespace: true,
  }));
};

const watchers = (done) => {
  gulp.watch('source/assets/*.css', {
    awaitWriteFinish: true,
  }).on('change', gulp.series('css'));

  gulp.watch('source/assets/*.js', {
    awaitWriteFinish: true,
  }).on('change', gulp.series('js'));

  gulp.watch('content/*.md', {
    awaitWriteFinish: true,
  }).on('change', processMarkdown);

  done();
}

gulp.task('dev', gulp.parallel(watchers));
gulp.task('build', gulp.series('css', 'js', 'copy-robots', 'copy-files', 'generate-static'));
