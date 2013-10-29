require 'minitest/autorun'
require 'rss'
require 'open-uri'

class TestRSSParsing < MiniTest::Unit::TestCase


  def test_consuming_external_resource_npr_news_headlines
    rss_sample1 = SampleRSSReader.new("http://www.npr.org/rss/rss.php?id=1001")
    content = []
    content = rss_sample1.get_rss_details
    assert content.include?("Title: News") 
  end

  def test_consuming_external_resource_npr_news_music
    rss_sample1 = SampleRSSReader.new("http://www.npr.org/rss/rss.php?id=1039")
    content = []
    content = rss_sample1.get_rss_details
    assert content.include?("Title: Music") 
  end


end


class SampleRSSReader
  attr_accessor :url

  def initialize(url)
    @url = url
  end

  def get_rss_details
    open(@url) do |rss|
      feed = RSS::Parser.parse(rss)
      rss_content = []
      puts "Title: #{feed.channel.title}"
      puts "Description: #{feed.channel.description}"
      puts "Link: #{feed.channel.link}"
      rss_content << "Title: #{feed.channel.title}"
      rss_content << "Description: #{feed.channel.description}"
      rss_content << "Link: #{feed.channel.link}"
      puts "Date: #{feed.channel.date} \n\n"
      feed.items.each do |item|    
        puts "Item: #{item.title}"
        rss_content << "Item: #{item.title}"
      end
      rss_content
    end
  end
end