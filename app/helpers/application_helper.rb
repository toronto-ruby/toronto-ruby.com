module ApplicationHelper
  def title
    text = content_for(:page_title)
    if text.present?
      "#{text} | Toronto Ruby"
    else
      'Toronto Ruby'
    end
  end

  def description
    text = content_for(:page_description)
    if text.present?
      text
    else
      'Toronto Ruby Meetups'
    end
  end
end
