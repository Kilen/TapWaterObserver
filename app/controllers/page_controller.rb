require "open-uri"
class PageController < ApplicationController
  def index
    @url = "http://www.whwater.com/news/tstz/"
    @notices = fetch_notices
  end

  private
  #return format: [
  #  { time: "xxxx", event: "xxx" }
  #]
  def fetch_notices
    Nokogiri::HTML(open(@url)).css(".STYLE8").map do |item|
      { event: item.text, time: item.next.next.text }
    end
  end
end
