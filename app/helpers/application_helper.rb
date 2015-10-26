module ApplicationHelper
  def create_list(arr)
    content_tag :ol do
      arr.collect do |line|
        content_tag :li, line
      end.join.html_safe
    end
  end
end
