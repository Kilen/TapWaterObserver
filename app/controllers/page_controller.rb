require "open-uri"
class PageController < ApplicationController
  def index
    @url = "http://www.whwater.com/news/tstz/"
    @planned_notices = fetch_notices "http://www.whwater.com/news/jhxts/Index.html"
    @emergency_notices = fetch_notices "http://www.whwater.com/news/tfxts/Index.html"
  end

  private
  #return format: [
  #  { time: "xxxx", event: "xxx" }
  #]
  def fetch_notices(url)
    Nokogiri::HTML(open(url)).css(".STYLE8").map do |item|
      { event: item.text, time: item.next.next.text }
    end
  end
end
