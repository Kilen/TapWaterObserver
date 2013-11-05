class TabWaterMailer < ActionMailer::Base
  default from: "zhilin.eno@gmail.com"

  def tab_water_info(planned_notices, emergent_notices, url)
    @planned_notices, @emergent_notices, @url = planned_notices, emergent_notices, url
    mail(to: "zhilin.eno@gmail.com", subject: "Tab water infomation")
  end
end
