module ApplicationHelper
  def auth_token
    "<input type=\"hidden\" name=\"authenticity_token\"
    value\"#{form_authenticity_token}\">".html_safe
  end

  def slice_comment(content)
    comment = content[0..10]
    comment << "..." if content.length > 10
    comment
  end
end
