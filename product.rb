require 'uri'
require 'pry'
require 'json'
require 'net/http'
require 'openssl'
require 'cgi'
require_relative 'api_requester'

puts "Product Search"
class Product

    include ApiRequester

  def initialize() 
  end
  

  def search(query)
    u = url("https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/food/products/search?query=", query)
    response = http(u).request(request(u))
    result = JSON.parse(response.read_body)
    display(result)
  end

  def grocery_products_by_UPC(upc)
      u = url("https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/food/products/upc/041631000564", upc)
      response = http(u).request(request(u))
      JSON.parse(response.read_body)
  end

  def product_information(id)
    u = url("https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/food/products/22347", id)
    response = http(u).request(request(u))
    JSON.parse(response.read_body)
  end
  def display(result)  
    # binding.pry
    result['results'].each do |a|
      puts "===========start============="
      puts "id = #{a['id']}"
      puts "nama = #{a['name']}"
      puts "image = #{a['image']}"
      puts "============end============="
    end
end
end
# binding.pry
obj1 = Product.new
# binding.pry
puts obj1.search("snickers").inspect
# puts obj1.grocery_products_by_UPC("041631000564")
# puts obj1.product_information("oran").inspect