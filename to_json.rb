require "json"

def get_array_from_file( file_name )
  puts("starting " + (file_name.to_s))
  file = File.open(file_name, "r")
  edges = file.read
  puts("Done Read for " + (file_name.to_s))
  edges = edges.split("\n")
  puts("Done Split for " + (file_name.to_s))
  edges = edges.map { |e| e.split(",").map { |f| f.strip } }
  puts("Compleated " + (file_name.to_s))
  file.close
  return edges
end


edges = get_array_from_file "out.csv"

output = {:nodes => edges.map { |e| {:id => e[0], :group => 1 }}}.filter {|e| e != nil}
links = []
edges.each {|e| e.each { |g| if e[0] != g then links.push({:source => e[0], :target => g, :value => 1}) end}}
output["links"] = links.filter {|e| e != nil}
j = output.to_json
pp(j)
File.write("short.json", j)
