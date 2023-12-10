module ApplicationHelper
  def title
    "#{content_for(:page_title)} | Toronto Ruby" || 'Toronto Ruby'
  end

  def description
    content_for(:page_description) || 'Toronto Ruby Meetups'
  end
end
