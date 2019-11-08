module AdminUserHelper

  def list_condition # Retrieves all the conditions to display in the admin menu
    Condition.all
  end
  
  def new_condition # Initialises the Condition for creating a new entry
    Condition.new
  end

  def list_all_users # Retrieves all the users to display in the admin menu
    User.all
  end
  
  def new_category # Initialises the Category for creating a new entry
    Category.new
  end

  def list_all_categories # Retrieves all the categories to display in the admin menu
    Category.all
  end

  def search_buyer(user)
    User.find(user)
  end

end
