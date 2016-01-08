require 'json'

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


    def get_file(opts={})
        options = {file: STDOUT}.merge!(opts)
        return options[:file]
    end


    def print_important_urgent(opts={})
        file = get_file(opts)
        file.puts "--Important and Urgent--"
        any_item = false
        @items.each do |item|
            if(item.important_urgent?)
                item.print_item(opts)
                any_item = true
            end
        end

        if(!any_item)
            file.puts sprintf("%6s","None")
        end

    end

    def print_important_xurgent(opts={})
        file = get_file(opts)
        file.puts "--Important and Not Urgent--"
        any_item = false
        @items.each do |item|
            if(item.important_xurgent?)
                item.print_item(opts)
                any_item = true
            end
        end

        if(!any_item)
            file.puts sprintf("%6s","None")
        end


    end

    def print_ximportant_urgent(opts={})
       file = get_file(opts)
       file.puts "--Not Important and Urgent--"
       any_item = false
        @items.each do |item|
            if(item.ximportant_urgent?)
                item.print_item(opts)
                any_item = true
            end
        end 

        if(!any_item)
            file.puts sprintf("%6s","None")
        end


    end


    def print_ximportant_xurgent(opts={})
        file = get_file(opts)
        file.puts "--Not Important and Not Urgent--"
        any_item = false
        @items.each do |item|
            if(item.ximportant_xurgent?)
                item.print_item(opts)
                any_item = true
            end
        end

        if(!any_item)
            file.puts sprintf("%6s","None")
        end

    end

    def print_priority(opts={})
        print_important_urgent(opts)
        print_important_xurgent(opts)
        print_ximportant_urgent(opts)
        print_ximportant_xurgent(opts)
    end

#print method for list class
#takes in :verbose true|false :file file_object :print_by priority
    def print_list(opts={})
        file = get_file(opts)

        file.puts "---------------------"
        file.puts @title
        file.puts "----------------------"

        #print by priority of the task
        if(opts[:print_by] == "priority")
            print_priority(opts)
        else
            @items.each do |item|
                item.print_item(opts)
            end
        end

        file.puts
        file.puts "Legend X:completed ?:uncompleted"
        file.puts
    end


    def save_to_file(name)
        file = File.new(name,"w+")
        print_list(verbose:true, file: file, print_by: "priority")
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
       
        options = {ximportant_xurgent: false}.merge!(opts)
        @priority.merge!(options)

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
       options ={verbose: false, file: STDOUT}.merge!(opts)
       file = options[:file]

       file.print sprintf("%-2s"," #{(opts[:print_by] == "priority") ? "" : "#{@id} - "  } ")
       file.print sprintf("%-40s","#{@description}")
       file.print sprintf("%5s","#{@completed_status ? "X" : "?"} ")

       if(@date.nil?)
           file.print " #{options[:verbose] ? sprintf("%12s","Date: - \n") : "\n" }"
       else
           file.print "#{options[:verbose] ? sprintf("%20s",@date.strftime(" Date: %d/%m/%y \n")) : "\n" }" 
       end

       if ( options[:verbose])
           file.print " " * 10 
           file.print sprintf("%10s","Details: #{@details}\n")
       end

    end


end


