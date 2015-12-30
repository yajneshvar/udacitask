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
          @items << entry
        end
    end

    def remove_item(item_name)
        @items.delete_if{|item| item.description == item_name}
    end

    def update_item_completed(item_name)
        index = @items.find_index {|item| item.description == item_name} 
        @items[index].update_status(true)
    end

    def print_list
        puts "---------------------"
        puts @title
        puts "----------------------"

        @items.each do |item|
            item.print_item
        end
    end
    

end

class Item
    attr_accessor :id
    attr_reader :description, :completed_status

    def initialize(item_description)
        @description = item_description
        @completed_status = false
        @id = 0
    end

    def update_status(status)
        @completed_status = status
    end

    def print_item
       puts "#{@id}. #{@description} #{@completed_status ? "completed" : "uncompleted"}" 
    end
end

