require './todolist.rb'

# Creates a new todo list
list = TodoList.new("Yaj's to do list")

# Add four new items
list.add_item("Buy groceries","Meetup with Karan","Check on sis","Finish anthropology")

# Print the list
list.print_list

# Delete the first item
list.remove_item("Buy groceries")

# Print the list
list.print_list

# Delete the second item
list.remove_item("Check on sis")

# Print the list
list.print_list

# Update the completion status of the first item to complete
list.update_item_completed("Meetup with Karan")

# Print the list
list.print_list

# Update the title of the list
list.change_title("New_year to do list")

# Print the list
list.print_list



#### MY own stuff #####


list.add_details("Meetup with Karan", "meet at 2pm near starbucks")

list.print_list(verbose: true)
