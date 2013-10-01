###
# Blog settings
###

Time.zone = "Beijing"

activate :blog do |blog|
  # blog.prefix = "blog"
  # blog.sources = ":year-:month-:day-:title.html"
  blog.permalink = ":title"
  blog.layout = "layouts/article"
  blog.month_link = ":year/:month"
  # blog.summary_separator = /(READMORE)/
  # blog.summary_length = 250
  # blog.year_link = ":year.html"
  # blog.day_link = ":year/:month/:day.html"
  # blog.default_extension = ".markdown"

  #blog.taglink = "tags/:tag.html"
  blog.tag_template = "tag.html"
  # blog.calendar_template = "calendar.html"

  blog.paginate = true
  blog.per_page = 10
  blog.page_link = "page/:num"
  blog.summary_length = 800
end

set :encoding, "utf-8"
set :trailing_slash, false
activate :directory_indexes

page "/rss.xml", :layout => false
page "/sitemap.xml", :layout => false
page "/404.html", :directory_index => false

###
# Compass
###

# Susy grids in Compass
# First: gem install susy --pre
# require 'susy'
require 'rgbapng'

# Change Compass configuration
# compass_config do |config|
#   config.output_style = :compact
# end

###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
# page "/path/to/file.html", :layout => false
#
# With alternative layout
# page "/path/to/file.html", :layout => :otherlayout
#
# A path which all have the same layout
# with_layout :admin do
#   page "/admin/*"
# end

# Proxy (fake) files
# page "/this-page-has-no-template.html", :proxy => "/template-file.html" do
#   @which_fake_page = "Rendering a fake page with a variable"
# end

###
# Helpers
###

# Automatic image dimensions on image_tag helper
# activate :automatic_image_sizes

# Methods defined in the helpers block are available in templates
# helpers do
#   def some_helper
#     "Helping"
#   end
# end

# Methods defined in the helpers block are available in templates
helpers do
  def disqus_identifier(article)
    article.data["disqus_identifier"] || article.title.parameterize
  end

  def author_tag(ident, size = 24)
    author = author(ident)
    %Q!<a href="#{author.link}" target="_blank"><img src="/images/#{author.avatar}" width="#{size}" height="#{size}"/></a>!
  end

  def author(ident)
    data.author[ident]
  end
end

# Assets PATH
set :css_dir, 'stylesheets'
set :js_dir, 'javascripts'
set :images_dir, 'images'

activate :syntax

set :markdown_engine, :redcarpet
set :markdown, fenced_code_blocks: true, autolink: true, smartypants: true, tables: true

# Livereload
# use: https://github.com/middleman/middleman-livereload
activate :livereload

# Build-specific configuration
configure :build do

  # Or use a different image path
  # set :http_path, "/Content/images/"

  # Make favicons
  # use: https://github.com/follmann/middleman-favicon-maker
  activate :favicon_maker

  # Minify
  # see: https://github.com/middleman/middleman-guides/blob/master/source/advanced/file-size-optimization.html.markdown#compressing-images
  activate :minify_css
  activate :minify_javascript

  # Enable cache buster
  # see: https://github.com/middleman/middleman-guides/blob/master/source/advanced/improving-cacheability.html.markdown#cache-buster-in-query-string
  activate :cache_buster

  # Use relative URLs
  # activate :relative_assets

  # Compress PNGs after build
  # use: https://github.com/middleman/middleman-smusher
  # activate :smusher

  # Gzip HTML, CSS, and JavaScript
  # see: https://github.com/middleman/middleman-guides/blob/master/source/advanced/file-size-optimization.html.markdown#gzip-text-files
  activate :gzip
end

activate :deploy do |deploy|
  deploy.method = :git
  
  if ENV["BLOG_PREFIX"] == "true"
    deploy.branch = "internal"
  else
    deploy.branch = "gh-pages"
  end
end
