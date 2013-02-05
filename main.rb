require 'pg'
require 'pry'
require 'HTTParty'
require 'JSON'


def menu
  puts `clear`
  puts '    __  __  ______      _______ ______ ______'
  puts '   |  \/  |/ __ \ \    / /_   _|  ____|___  /'
  puts '   | \  / | |  | \ \  / /  | | | |__     / / '
  puts '   | |\/| | |  | |\ \/ /   | | |  __|   / /  '
  puts '   | |  | | |__| | \  /   _| |_| |____ / /__ '
  puts '   |_|  |_|\____/   \/   |_____|______/_____|'
  puts '                                             '
  puts "Welcome to Moviez! Our app is as bad as our spelling!"
  puts "(A)dd Movie to database"
  puts "(Q)uit Moviez \n"
  print "> "
  gets.chomp.downcase
end

def get_title_data
  print "Enter movie title: "
  input = gets.chomp.split.join('+')

  rawdata = HTTParty.get("http://www.omdbapi.com/?t=#{input}")
  movie_data = JSON(rawdata.body)

  title = movie_data["Title"]
  year = movie_data["Year"]
  rated = movie_data["Rated"]
  runtime = movie_data["Runtime"]
  genre = movie_data["Genre"]
  director = movie_data["Director"]
  writer = movie_data["Writer"]
  actors = movie_data["Actors"]

  sql = "insert into moviez (title, year, rated, runtime, genre, director, writer, actors) values ('#{title}', '#{year}', '#{rated}', '#{runtime}', '#{genre}', '#{director}', '#{writer}', '#{actors}')"

  conn = PG.connect(:dbname =>'moviez_app', :host => 'localhost')
  conn.exec(sql)
  conn.close

  print "\n #{title} has been added! "
  print "Press return to continue"
  gets
end


response = menu
while response != 'q'
  case response
  when 'a' then get_title_data
  end
  response = menu
end



