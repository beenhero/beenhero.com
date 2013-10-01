# -*- coding: utf-8 -*-
xml.instruct!
xml.rss "xmlns:atom" => "http://www.w3.org/2005/Atom", "version" => "2.0" do
  xml.channel do
    xml.id "http://beenhero.com"
    xml.title "~/Bin's Blog"
    xml.link "http://beenhero.com"
    xml.language "zh-cn"
    xml.copyright "&#x2117; &amp; &#xA9; 2013 Bin He"
    xml.link "href" => "http://beenhero.com"
    xml.link "href" => "http://beenhero.com/rss.xml", "rel" => "self"
    xml.updated blog.articles.first.date.to_time.iso8601
    xml.lastBuildDate blog.articles.first.date.to_time.iso8601
    xml.pubDate blog.articles.first.date.to_time.iso8601
    xml.description "~Bin got his ideas out of head."
    xml.author { xml.name "Bin He" }

    blog.articles.each do |article|
      xml.item do
        xml.title article.title
        xml.link "http://beenhero.com#{article.url}"
        xml.description article.body, "type" => "html"
        xml.guid "tag:beenhero.com,article.url"
        xml.pubDate article.date.to_time.iso8601
        xml.category article.tags.join(', ')
      end
    end
  end
end
