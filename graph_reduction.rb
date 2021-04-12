require "pp"
require "csv"

def get_array_from_file_num( file_name )
  puts("starting " + (file_name.to_s))
  file = File.open(file_name, "r")
  edges = file.read
  puts("Done Read for " + (file_name.to_s))
  edges = edges.split("\n")
  puts("Done Split for " + (file_name.to_s))
  edges = edges.map { |e| e.split("\t").map { |f| f.strip.to_i } }
  file.close
  puts("Compleated " + (file_name.to_s))
  return edges
end

def get_array_from_file( file_name )
  puts("starting " + (file_name.to_s))
  file = File.open(file_name, "r")
  edges = file.read
  puts("Done Read for " + (file_name.to_s))
  edges = edges.split("\n")
  puts("Done Split for " + (file_name.to_s))
  edges = edges.map { |e| e.split("\t").map { |f| f.strip } }
  puts("Compleated " + (file_name.to_s))
  file.close
  return edges
end

edges = get_array_from_file_num "edges.txt"
lookup_table = get_array_from_file "lookup_table.txt"
lookup_table = lookup_table.map { |e| [e[0], e[1].to_i] }
pp(edges.length)


edges = edges.map { |e| if e.length < 700 then [] else e end }
edges = edges.map { |e| e.filter { |f| edges[f] != [] }}

puts("done")
pp(edges.filter{ |e| e != []}.length)

edges = edges.map { |e| e.map { |g| (lookup_table[g])[0] } }
lookup_table = (lookup_table.map { |e| if edges[e[1]] != [] then [e[0]] + edges[e[1]] else [] end}).filter { |g| g != []}

puts "Writing to file"
CSV.open("out.csv", "wb") do |csv|
  lookup_table.each { |e| csv << e }
end
