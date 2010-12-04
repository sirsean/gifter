require 'yaml'

class Array
    def random
        self[rand(self.size)]
    end
end

class FamilyGifter
    def initialize(families)
        @families = families
    end

    def give
        tries = 0
        loop do
            tries += 1
            if tries > 100
                raise "Tried 100 times, and couldn't find a match"
            end
            begin
                gifts = try_to_give
                verify_gifts(gifts)
                return gifts
            rescue => err
            end
        end
    end

    def try_to_give
        gifts = {}
        @families.each do |family,names|
            other_names = @families.values.flatten - names
            names.each do |name|
                gifts[name] = (other_names - gifts.values).random
            end
        end
        gifts
    end

    def verify_gifts(gifts)
        ungifted = (@families.values.flatten - gifts.values)
        if not ungifted.empty?
            raise "Unmatched gifts"
        end
    end

    def display(gifts)
        @families.each do |family,names|
            puts "Family: #{family}"
            names.each do |name|
                puts "-- #{name}: #{gifts[name]}"
            end
        end
    end
end

families = YAML::load(File.read("gifter.yaml"))

gifter = FamilyGifter.new(families)
gifts = gifter.give
gifter.display(gifts)

