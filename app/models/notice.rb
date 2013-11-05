class Notice < ActiveRecord::Base
  validates :notice_type, inclusion: %w(planned emergent)

  def self.last_planned
    self.find_all_by_notice_type("planned").last
  end

  def self.last_emergent
    self.find_all_by_notice_type("emergent").last
  end
end
