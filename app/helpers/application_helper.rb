module ApplicationHelper
  def title
    base_title = "Ruby on rails tutorial Sample Application"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end
end
