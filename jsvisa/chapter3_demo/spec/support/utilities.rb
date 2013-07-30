def full_title(page_title) 
  base_title = "Chapter3Demo"
  if page_title.empty? then 
    base_title 
  else
    "#{base_title} | #{page_title}"
  end
end
  
