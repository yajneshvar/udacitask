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

    def add_details(item_name,details)
        index = find_item(item_name)
        index = 0
        @items[index].edit_details(details)
        return 0
    end

    def find_item(item_name)
        @items.find_index {|item| item.description == item_name}
    end

    def change_title(new_title)
        @title = new_title
    end    


    def print_list(opts={})
        puts "---------------------"
        puts @title
        puts "----------------------"

        @items.each do |item|
            item.print_item(opts)
        end

        puts
        puts "Legend X:completed ?:uncompleted"
    end
    

end

class Item
    attr_accessor :id
    attr_reader :description, :completed_status, :details

    def initialize(item_description)
        @description = item_description
        @completed_status = false
        @id = 0
    end

    def update_status(status)
        @completed_status = status
    end

    def edit_details(text)
        @details = text
    end

    def print_item(opts={})
       options ={verbose: false}.merge!(opts)
       puts "#{@id} - #{@description}  #{@completed_status ? "X" : "?"}" 
       if ( options[:verbose])
           print " " * 10 
           print "#{@details}\n"
       end
    end

end


