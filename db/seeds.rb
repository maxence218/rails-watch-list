# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# Movie.create(title: "Wonder Woman 1984", overview: "Wonder Woman comes into conflict with the Soviet Union during the Cold War in the 1980s", poster_url: "https://image.tmdb.org/t/p/original/8UlWHLMpgZm9bx6QYh0NFoq67TZ.jpg", rating: 6.9)
# Movie.create(title: "The Shawshank Redemption", overview: "Framed in the 1940s for double murder, upstanding banker Andy Dufresne begins a new life at the Shawshank prison", poster_url: "https://image.tmdb.org/t/p/original/q6y0Go1tsGEsmtFryDOJo3dEmqu.jpg", rating: 8.7)
# Movie.create(title: "Titanic", overview: "101-year-old Rose DeWitt Bukater tells the story of her life aboard the Titanic.", poster_url: "https://image.tmdb.org/t/p/original/9xjZS2rlVxm8SFx8kPC3aIGCOYQ.jpg", rating: 7.9)
# Movie.create(title: "Ocean's Eight", overview: "Debbie Ocean, a criminal mastermind, gathers a crew of female thieves to pull off the heist of the century.", poster_url: "https://image.tmdb.org/t/p/original/MvYpKlpFukTivnlBhizGbkAe3v.jpg", rating: 7.0)
require 'uri'
require 'net/http'
require 'json'


url = URI("https://api.themoviedb.org/3/movie/popular?language=en-US&page=1")

http = Net::HTTP.new(url.host, url.port)
http.use_ssl = true

request = Net::HTTP::Get.new(url)
request["accept"] = 'application/json'
request["Authorization"] = 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI4OTNmNTlmZGFjNGIwNDdhODUwMmU1MWQ0NDRlODcxYSIsIm5iZiI6MTc2MzYzNjQ4MS4xMjEsInN1YiI6IjY5MWVmNTAxOWY2MDE2YjdhMzRhMmEzYiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.d_wNKIevGRfq0o5SVKnpPkqCMO2HRcylwPppV-hybRw'

response = http.request(request)
result =  response.read_body

result = JSON.parse(response.read_body)
p "remove db"
Movie.delete_all
p " start seeding"
result["results"].each_with_index do |movie, index|
  p "film #{index}"
  Movie.create(title: "#{movie["title"]}", overview: "#{movie["overview"]}", poster_url: "https://image.tmdb.org/t/p/original#{movie["poster_path"]}", rating: "#{movie["vote_average"]}")
end

