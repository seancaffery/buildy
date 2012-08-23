class BuildResult < ActiveRecord::Base
  belongs_to :revision
  belongs_to :build

  attr_accessible :build_id, :result, :revision_id

  def css_class
    case self.result
    when 'SUCCESS'
      'icon-ok'
    when 'FAILURE'
      'icon-remove'
    when 'UNKNOWN'
      'icon-question-sign'
    end
  end
end
