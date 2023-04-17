require 'uri'
require 'pry'
require 'json'
require 'net/http'
require 'openssl'
require 'cgi'
require_relative 'api_requester'
puts "|===========Choice Ur Menu=============="
puts "|         Pilih menu operasi"
puts "| 1.search menu items"
puts "| 2.get menu item information"
puts "| 3.Auto complete menu item"
puts "|===============MENU=================="
print "| Pilih Menu = "
nomor = gets.chomp


if nomor == "1"
  print "| Masukan Bahan = "
  menuitem = gets.chomp
elsif nomor == "2"
  print "| Masukan ID = "
  menuinformation = gets.chomp.to_s
elsif nomor == "3"
  print "| Masukan Kata = "
  autocomplete = gets.chomp.to_s
  
else 
    puts "ERROR"
end



class Menu_Items
include ApiRequester


  def search_menu_items(query)
    u = url("https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/food/menuItems/search?query=", query)
    response = http(u).request(request(u))
    result = JSON.parse(response.read_body)
    send("search_display", result)
  end

  def menuitem_information(id)
    # binding.pry
      u = url("https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/food/ingredients/9266/information?", id)
      response = http(u).request(request(u))
      result2 = JSON.parse(response.read_body)
      send("information_display", result2)
  end

  def autocomplete_menu_item_search(query)
    u = url("https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/food/menuItems/suggest?query=", query)
    response = http(u).request(request(u))
    result3 = JSON.parse(response.read_body)
          # binding.pry
    send("subtitues_display", result3)
  end

   def search_display(result)
   result['menuItems'].each do |a|
    puts "============START=============="
    puts "| id = #{a["id"]}"
    puts "| title = #{a["title"]}"
    puts "| image = #{a["image"]}"
    puts "=============END==============="
     end
    end

    def information_display(result2)
      #  binding.pry
       result2.each do |b|
        puts "=============START=============="
        puts "| id = ",result2["id"]
        puts "| name = ",result2["name"]
        puts "| image = ",result2["image"]
        puts "==============END==============="
        end
     end
     
 def subtitues_display(result3) 
  #  binding.pry
  result3['results'].each do |c|
   puts "| ============START=============="
   puts "| title = #{c["title"]}"
   puts "| id = #{c["id"]}"
   puts "| =============END==============="
    end
 end 
end



obj1 = Menu_Items.new


if nomor == "1"
    obj1.search_menu_items(menuitem).inspect
elsif nomor == "2"
  obj1.menuitem_information(menuinformation).inspect
elsif nomor == "3"
     obj1.autocomplete_menu_item_search(autocomplete).inspect
  else
    puts "ERROR"
end