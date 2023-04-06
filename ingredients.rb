require 'uri'
require 'pry'
require 'json'
require 'net/http'
require 'openssl'
require 'cgi'
require 'artii'
require_relative 'api_requester'

a = Artii::Base.new :font => 'slant'
puts a.asciify('Ingredients')
puts "1. Search"
puts "2. information"
puts "3. autocompletion"
print "silahkan pilih nomor = "
nomor = gets.chomp.to_s

if nomor == "1"
  print "Masukan Bahan = "
  ingredients_search = gets.chomp
elsif nomor == "2"
  print "Masukan ID = "
  ingredients_information = gets.chomp.to_s
elsif nomor == "3"
  print "Masukan Kata = "
  ingredients_autocomplete = gets.chomp
else 
    puts "ERROR"
end

puts "INGREDIENTS SEARCH"
class Ingredients
include ApiRequester
  

  def search(query)
    u = url("https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/food/ingredients/search?query=", query)
    response = http(u).request(request(u))
    result = JSON.parse(response.read_body)
    send("search_display", result)
  end

  def ingredients_information(id)
    # binding.pry
      u = url("https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/food/ingredients/9266/information?", id)
      response = http(u).request(request(u))
      result2 = JSON.parse(response.read_body)
      send("information_display", result2)
  end

  def ingredients_autocomplete(query)
    u = url("https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/food/ingredients/autocomplete?query=", query)
    response = http(u).request(request(u))
    result3 = JSON.parse(response.read_body)
    send("autocomplete_display", result3)
  end

   def search_display(result)
    # binding.pry
   result['results'].each do |a|
    puts "=============START=============="
    puts "| id = #{a["id"]}        "
    puts "| name = #{a["name"]}    "
    puts "| image = #{a["image"]}  "
    puts "==============END==============="
     end
  end

def information_display(result2)
  #  binding.pry
   result2.each do |b|
    puts "=============START=============="
    puts "id = ",result2["id"]
    puts "name = ",result2["name"]
    puts "image = ",result2["image"]
    puts "==============END==============="
    end
 end

 def autocomplete_display(result3)
  result3.each do |c|
    # binding.pry
   puts "=============START=============="
   puts "name = #{c["name"]}"
   puts "image = #{c["image"]}"
   puts "==============END==============="
    end
 end 
end

obj1 = Ingredients.new

if nomor == "1"
  obj1.search(ingredients_search).inspect
elsif nomor == "2"
  obj1.ingredients_information(ingredients_information).inspect
elsif nomor == "3"
  obj1.ingredients_autocomplete(ingredients_autocomplete).inspect
  else
    puts "ERROR"
end