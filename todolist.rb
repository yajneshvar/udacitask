class TodoList
    # methods and stuff go here
    attr_reader :title, :items

    def initialize (title_name)
        @title = title_name
        @items = Array.new
    end

    def add_item(*new_item)
        new_item.each do |item| 
          entry  = Item.new(item)
          new_id = @items.length
          entry.id = new_id + 1
          @items << entry
        end
    end

    def remove_item(item_name)
        @items.delete_if{|item| item.description == item_name}
        @items.each_with_index {|item,i| item.id = i + 1 }
    end

    def update_item_completed(item_name)
        index = @items.find_index {|item| item.description == item_name} 
        @items[index].update_status(true)
    end


    def find_item_index(item_name)
        @items.find_index {|item| item.description == item_name}
    end

    def add_details(item_name,details)
        index = find_item_index(item_name)
        @items[index].edit_details(details)
        return 0
    end

    def add_date(date={})
        if(date.empty?)
            return
        end
        index = find_item_index(date[:item])
        @items[index].edit_date(date)

    end

    def add_priority(opts={})
                
        if(opts.empty?)
            return
        end

        index = find_item_index(opts[:name])
        opts.delete(:name)
        @items[index].edit_priority(opts)

    end

    def change_title(new_title)
        @title = new_title
    end    


    def print_important_urgent(opts={})
        puts "--Important and Urgent--"
        @items.each do |item|
            if(item.important_urgent?)
                item.print_item(opts)
            end
        end
    end

    def print_important_xurgent(opts={})
         puts "--Important and Not Urgent--"
        @items.each do |item|
            if(item.important_xurgent?)
                item.print_item(opts)
            end
        end
    end

    def print_ximportant_urgent(opts={})
        puts "--Not Important and Urgent--"
        @items.each do |item|
            if(item.ximportant_urgent?)
                item.print_item(opts)
            end
        end 
    end


    def print_ximportant_xurgent(opts={})
        puts "--Not Important and Not Urgent--"
        @items.each do |item|
            if(item.ximportant_xurgent?)
                item.print_item(opts)
            end
        end
    end

    def print_priority(opts={})
        print_important_urgent(opts)
        print_important_xurgent(opts)
        print_ximportant_urgent(opts)
        print_ximportant_xurgent(opts)
    end


    def print_list(opts={})
        puts "---------------------"
        puts @title
        puts "----------------------"

        #print by priority of the task
        if(opts[:print_by] == "priority")
            print_priority(opts)
        end


        @items.each do |item|
            item.print_item(opts)
        end

        puts
        puts "Legend X:completed ?:uncompleted"
    end
    

end

class Item
    attr_accessor :id
    attr_reader :description, :completed_status, :details, :date, :priority

    def initialize(item_description)
        @description = item_description
        @completed_status = false
        @id = 0
        @details = "none"
        @priority = {important_urgent: false, important_xurgent: false, ximportant_urgent: false, ximportant_xurgent: true}
    end

    def update_status(status)
        @completed_status = status
    end

    def edit_details(text)
        @details = text
    end

    def edit_date(due_date={})
        if(due_date.empty?)
            return
        end
        @date = Time.new(due_date[:year],due_date[:month],due_date[:day])
    end

    def edit_priority(opts={})
        if(opts.empty?)
            return
        end
        
        @priority.merge!(opts)

    end

    def important_urgent?
        @priority[:important_urgent]
    end

    def important_xurgent?
        @priority[:important_xurgent]
    end

    def ximportant_urgent?
        @priority[:ximportant_urgent]
    end

    def ximportant_xurgent?
        @priority[:ximportant_xurgent]
    end

    def print_item(opts={})
       options ={verbose: false}.merge!(opts)
       print "#{@id} - #{@description}  #{@completed_status ? "X" : "?"} "

       if(@date.nil?)
           print " #{options[:verbose] ? "Date: - \n" : "\n" }"
       else
           print "#{options[:verbose] ? @date.strftime(" Date: %d/%m/%y \n") : "\n" }" 
       end

       if ( options[:verbose])
           print " " * 10 
           print "#{@details}\n"
       end

        #sprintf("%-20s","Yaj is an idiot")
       
    end

end


