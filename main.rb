require 'uri'
require 'pry'
require 'json'
require 'net/http'
require 'openssl'
require 'cgi'
require 'artii'
require_relative 'api_requester'

a = Artii::Base.new :font => 'slant'
puts a.asciify('MAIN MENU!')
puts "|===========Choice Ur Menu=============="
puts "|         Pilih menu operasi"
puts "| 1. Ingredient"
puts "| 2. Recipe"
puts "| 3. Product"
puts "| 4. Menu Item"
puts "|===============MENU=================="
print "| silahkan pilih nomor = "
nomor = gets.chomp.to_s
# binding.pry


if nomor == "1"
    require_relative 'ingredients'
elsif nomor == "2"
    require_relative 'recipe'
elsif nomor == "3"
    require_relative 'product'
elsif nomor == "4"
    require_relative 'menuitem'
else 
    puts "ERROR"
end


