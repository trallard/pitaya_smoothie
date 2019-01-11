# Taken from Xaringan https://github.com/yihui/xaringan/blob/master/R/render.R
moon_reader = function(
  css = c('default', 'default-fonts'), self_contained = FALSE, seal = TRUE, yolo = FALSE,
  chakra = 'https://remarkjs.com/downloads/remark-latest.min.js', nature = list(),
  ...
) {
  theme = grep('[.]css$', css, value = TRUE, invert = TRUE)
  deps = if (length(theme)) {
    css = setdiff(css, theme)
    check_builtin_css(theme)
    list(css_deps(theme))
  }
  tmp_js = tempfile('xaringan', fileext = '.js')  # write JS config to this file
  tmp_md = tempfile('xaringan', fileext = '.md')  # store md content here (bypass Pandoc)

  play_js = if (is.numeric(autoplay <- nature[['autoplay']]) && autoplay > 0)
    sprintf('setInterval(function() {slideshow.gotoNextSlide();}, %d);', autoplay)

  if (isTRUE(countdown <- nature[['countdown']])) countdown = autoplay
  countdown_js = if (is.numeric(countdown) && countdown > 0) sprintf(
    '(%s)(%d);', pkg_file('js/countdown.js'), countdown
  )

  if (is.null(title_cls <- nature[['titleSlideClass']]))
    title_cls = c('center', 'middle', 'inverse')
  title_cls = paste(c(title_cls, 'title-slide'), collapse = ', ')

  before = nature[['beforeInit']]
  for (i in c('countdown', 'autoplay', 'beforeInit', 'titleSlideClass')) nature[[i]] = NULL

  write_utf8(as.character(tagList(
    tags$script(src = chakra),
    if (is.character(before)) if (self_contained) {
      tags$script(HTML(file_content(before)))
    } else {
      lapply(before, function(s) tags$script(src = s))
    },
    tags$script(HTML(paste(c(sprintf(
      'var slideshow = remark.create(%s);', if (length(nature)) xfun::tojson(nature) else ''
    ), pkg_file('js/show-widgets.js'), pkg_file('js/print-css.js'),
    play_js, countdown_js), collapse = '\n')))
  )), tmp_js)

  html_document2 = function(
    ..., includes = list(), mathjax = 'default', pandoc_args = NULL
  ) {
    if (length(includes) == 0) includes = list()
    includes$before_body = c(includes$before_body, tmp_md)
    includes$after_body = c(tmp_js, includes$after_body)
    if (identical(mathjax, 'local'))
      stop("mathjax = 'local' does not work for moon_reader()")
    if (!is.null(mathjax)) {
      if (identical(mathjax, 'default')) {
        mathjax = 'https://mathjax.rstudio.com/latest/MathJax.js?config=TeX-MML-AM_CHTML'
      }
      pandoc_args = c(pandoc_args, '-V', paste0('mathjax-url=', mathjax))
      mathjax = NULL
    }
    pandoc_args = c(pandoc_args, '-V', paste0('title-slide-class=', title_cls))
    rmarkdown::html_document(
      ..., includes = includes, mathjax = mathjax, pandoc_args = pandoc_args
    )
  }

  optk = list()

  highlight_hooks = NULL
  if (isTRUE(nature$highlightLines)) {
    # an ugly way to access hooks of markdown output in knitr
    hooks = local({
      ohooks = knitr::knit_hooks$get(); on.exit(knitr::knit_hooks$restore(ohooks))
      knitr::render_markdown()
      knitr::knit_hooks$get(c('source', 'output'))
    })
    highlight_hooks = list(
      source = function(x, options) {
        hook = hooks[['source']]
        res = hook(x, options)
        highlight_code(res)
      },
      output = function(x, options) {
        hook = hooks[['output']]
        res = highlight_output(x, options)
        hook(res, options)
      }
    )
  }