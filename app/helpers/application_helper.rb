module ApplicationHelper
  def sort_column(column, industry_id,title = nil)
    title ||= column.titleize
    direction = (column == params[:sort] && params[:direction] == "asc") ? "desc" : "asc"
    link_to title, :sort => column, :direction => direction, :industry_id => industry_id
  end
end
