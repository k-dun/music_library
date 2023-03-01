require_relative 'lib/database_connection'

# We need to give the database name to the method `connect`.
DatabaseConnection.connect('music_library')

# Perform a SQL query on the database and get the result set.
sql = 'SELECT id, name, genre FROM artists;'
result = DatabaseConnection.exec_params(sql, [])

# Print out each record from the result set .
result.each do |record|
  puts "#{record["id"]} - #{record["name"]} - #{record["genre"]}"
end