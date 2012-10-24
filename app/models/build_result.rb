class BuildResult < ActiveRecord::Base
  include ActionView::Helpers::DateHelper

  belongs_to :revision
  belongs_to :build

  attr_accessible :build_id, :result, :revision_id

  def display_time
    return 'unkown' unless build_time.present?
    minutes = build_time / 1000 / 60
    time_ago_in_words(minutes.minutes.ago)
  end

  def css_class
    case self.result
    when 'SUCCESS'
      'icon-ok'
    when 'FAILURE'
      'icon-remove'
    when 'UNKNOWN', 'ABORTED'
      'icon-question-sign'
    end
  end
end
