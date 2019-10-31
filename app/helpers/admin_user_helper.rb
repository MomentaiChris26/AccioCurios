module AdminUserHelper
  def list_condition
    Condition.all
  end
  
  def new_condition
    Condition.new
  end

  def list_all_users
    User.all
  end

  def list_all_categories
    Category.all
  end

end
