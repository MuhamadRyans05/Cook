require 'uri'
require 'pry'
require 'json'
require 'net/http'
require 'openssl'
require 'cgi'
require_relative 'api_requester'
puts "|===========Choice Ur Menu=============="
puts "|         Pilih menu operasi"
puts "| 1.search_grocery_roducts"
puts "| 2.product_information"
puts "| 3.product_autocomplete"
print "| Pilih Menu = "
nomor = gets.chomp
# puts "|===============RECIPE=================="


if nomor == "1"
  print "| Masukan Produk Grosir = "
  search_grocery_roducts = gets.chomp
elsif nomor == "2"
  print "| Produk Informasi = "
  recipe_information = gets.chomp
elsif nomor == "3"
  print "| Masukan Pencarian Produk Pelengkapan Otomatis = "
  product_autocomplete = gets.chomp.to_s


else 
  puts "ERROR"
end

class Product
include ApiRequester
  

  def search_grocery_roducts(query)
    u = url("https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/food/products/search?query=", query)
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

def autocomplete(query)
  u = url("https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/food/ingredients/autocomplete?query=", query)
  response = http(u).request(request(u))
  result3 = JSON.parse(response.read_body)
  send("autocomplete_display", result3)
end
   def search_display(result)
    # binding.pry
   result['products'].each do |a|
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
     puts "|============START==============|"
     puts "id = ",result2["id"]
     puts "title = ",result2["title"]
     puts "image = ",result2["image"]
     puts "|=============END===============|"
     end
  end
 

  def autocomplete_display(result3)
    result3.each do |c|
      #  binding.pry
     puts "=============START=============="
     puts "name = #{c["name"]}"
     puts "image = #{c["image"]}"
     puts "==============END==============="
      end
   end 
end



obj1 = Product.new

if nomor == "1"
  obj1.search_grocery_roducts(search_grocery_roducts).inspect
elsif nomor == "2"
obj1.recipe_information(recipe_information).inspect
elsif nomor == "3"
  obj1.autocomplete(product_autocomplete).inspect
  else
    puts "ERROR"
end