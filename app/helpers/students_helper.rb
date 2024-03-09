module StudentsHelper
  def generate_random_password
    characters = [('0'..'9'), ('A'..'Z'), ('a'..'z')].map(&:to_a).flatten
    password = (0...12).map { characters[rand(characters.length)] }.join
  end
end
