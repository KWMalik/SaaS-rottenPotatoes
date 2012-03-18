module MoviesHelper
  # Checks if a number is odd:
  def oddness(count)
    count.odd? ?  "odd" :  "even"
  end
  
  def sort_by(name)
    (session[:sort_by] == name ? 'hilite' : '')
  end
  
  def sort_order()
    if(session[:order].blank?)
      'DESC'
    else
      (session[:order] == 'ASC' ? 'DESC' : 'ASC')
    end
  end
end
