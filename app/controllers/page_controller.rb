require "open-uri"
class PageController < ApplicationController
  def index
    @url = "http://www.whwater.com/news/tstz/"
    @planned_notices = fetch_notices "http://www.whwater.com/news/jhxts/Index.html"
    @emergent_notices = fetch_notices "http://www.whwater.com/news/tfxts/Index.html"
    if changed_in_website?
      save_last_one
    end
  end

  # only used by heroku scheduler: PageController.new.send_mail
  def send_mail
    @url = "http://www.whwater.com/news/tstz/"
    @planned_notices = fetch_notices "http://www.whwater.com/news/jhxts/Index.html"
    @emergent_notices = fetch_notices "http://www.whwater.com/news/tfxts/Index.html"
    if changed_in_website?
      TabWaterMailer.tab_water_info(@planned_notices, @emergent_notices, @url).deliver
    end
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

  def changed_in_website?
    !match?(@planned_notices.first, Notice.last_planned) || !match?(@emergent_notices.first, Notice.last_emergent)
  end

  def match?(notice_from_site, notice_from_db)
    notice_from_site[:time] == notice_from_db.try(:time) && notice_from_site[:event] == notice_from_db.try(:event)
  end

  def save_last_one
    Notice.create!(
      event: @planned_notices.first[:event],
      time: @planned_notices.first[:time],
      notice_type: "planned"
    )
    Notice.create!(
      event: @emergent_notices.first[:event],
      time: @emergent_notices.first[:time],
      notice_type: "emergent"
    )
  end
end
