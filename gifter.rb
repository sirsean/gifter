class Gifter
    def initialize(names)
        @names = names
    end

    def unused_names(all_names, used_names)
        all_names - used_names
    end

    def random_name(names)
        names[rand(names.size)]
    end

    def random_name_excluding(names, exclude)
        if names.size == 1 and names[0] == exclude
            raise "Cannot assign #{exclude} to self"
        end
        name = self.random_name(names)
        while name == exclude
            name = self.random_name(names)
        end
        name
    end

    def try_to_give
        gifts = {}
        @names.each do |name|
            gifts[name] = self.random_name_excluding(self.unused_names(@names, gifts.values), name)
        end
        gifts
    end

    def give
        if @names.size == 1
            raise "You can't exchange gifts if you're all by yourself, you poor lonely fool!"
        end
        loop do
            begin
                return try_to_give
            rescue
            end
        end
    end
end

names = File.read("names").split("\n")

gifter = Gifter.new(names)
gifts = gifter.give

gifts.keys.each do |giver|
    puts "#{giver}: #{gifts[giver]}"
end

