require 'uri'
require 'pry'
require 'json'
require 'net/http'
require 'openssl'
require 'cgi'
require 'artii'
require_relative 'api_requester'
a = Artii::Base.new :font => 'slant'
puts a.asciify('Recipe!')
puts "|===========Choice Ur Menu=============="
puts "|         Pilih menu operasi"
puts "| 1.recipe_search"
puts "| 2.recipe_information"
puts "| 3.recipe_autocomplete"
puts "|===============RECIPE=================="

print "| Pilih Menu = "
nomor = gets.chomp

if nomor == "1"
  print "| Masukan Bahan = "
  recipe_search = gets.chomp
elsif nomor == "2"
  print "| Masukan ID = "
  recipe_information = gets.chomp
elsif nomor == "3"
  print "| Masukan Kata = "
  recipe_autocomplete = gets.chomp.to_s
  
else 
    puts "ERROR"
end


class Ingredients
include ApiRequester


  def search(query)
    u = url("https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/complexSearch?query=", query)
    response = http(u).request(request(u))
    result = JSON.parse(response.read_body)
    send("search_display", result)
  end

  def recipe_information(id)
      u = url("https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/479101/information?", id)
      response = http(u).request(request(u))
      result2 = JSON.parse(response.read_body)
      send("information_display", result2)
  end

  def recipe_autocomplete(query)
    u = url("https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/autocomplete?query= ", query)
    response = http(u).request(request(u))
    result3 = JSON.parse(response.read_body)
    send("subtitues_display", result3)
  end

   def search_display(result)
   result['results'].each do |a|
    puts "|============START=============="
    puts "|id = #{a["id"]}"
    puts "|title = #{a["title"]}"
    puts "|image = #{a["image"]}"
    puts "|=============END==============="
     end
  end

def information_display(result2)
   # binding.pry
   result2.each do |b|
    puts "|============START=============="
    puts "id = ",result2["id"]
    puts "title = ",result2["title"]
    puts "image = ",result2["image"]
    puts "|=============END==============="
    end
 end

 def subtitues_display(result3) 
   result3.each do |c|
    # binding.pry
   puts "|============START=============="
   puts "|id = #{c["id"]}"
   puts "|title = #{c["title"]}"
   puts "|image = #{c["imageType"]}"
   puts "|=============END==============="
    end
 end 
end



obj1 = Ingredients.new


if nomor == "1"
  obj1.search(recipe_search).inspect
elsif nomor == "2"
  obj1.recipe_information(recipe_information).inspect
elsif nomor == "3"
  obj1.recipe_autocomplete(recipe_autocomplete).inspect
  else
    puts "ERROR"
end

