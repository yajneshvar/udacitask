require './todolist.rb'

# Creates a new todo list
list = TodoList.new("Yaj's to do list")

# Add four new items
list.add_item("Buy groceries","Meetup with Karan","Check on sis","Finish anthropology")

    #NEW FEATURE added to task

    #Add date for an item
    list.add_date(item: "Meetup with Karan", year: 2016, month: 7, day:11)
    
    #Add details for an item
    list.add_details("Meetup with Karan", "meet at 2pm near starbucks")
    
    #Categorize an item according to 4 priorities: important_urgent, important_not_urgent, not_important_urgent, not_important_not_urgent 
    list.add_priority(name: "Finish anthropology", important_urgent: true) 

# Print the list
#need to set verbose true to print out date and details
#set print_by priority to sort list by priority
list.print_list(verbose: true,print_by: "priority")

# Delete the first item
list.remove_item("Buy groceries")

# Print the list
# just calling list.print_list will print a very simple to do list without priority/date and detail
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

#New feature added to task
#save to file
list.save_to_file("new_year")
