#!/usr/bin/ruby
require 'pp'
class Pfinder
  def initialize
    @edges = get_array_from_file "edges.txt"
    @lookup_table = get_array_from_file "lookup_table.txt"
  end

  def get_array_from_file( file_name )
    puts("starting " + (file_name.to_s))
    file = File.open(file_name, "r")
    edges_raw = file.read
    edges_raw = edges_raw.split("\n")
    edges_raw = edges_raw.map { |e| e.split("\t") }
    file.close
    return edges_raw
  end

  def bfs(start,target)
    queue = Array.new
    checked = Array.new
    queue.push(Array.new([start,[]]))
    index = 0
    while queue != [] do
      id = queue.shift
      index = index + 1
      print(index.to_s + "\r")
      (@edges[id[0].to_i]).each { |e|
        if e != target
          if not checked.include?(e)
            checked.push(e)
            queue.push([e,id[1] + [id[0]]])
          end
        else
          return (id[1] + [id[0],target])
        end }
    end
  end

  def get_path(start,target)
    bfs(start,target).map { |e| @lookup_table[e.to_i] }
  end

end


finder = Pfinder.new()

first = ""
second = ""

while true
  puts "enter start node"
  first = gets.chomp
  if first == "exit"
    break
  end

  puts "enter end node"
  second = gets.chomp

  pp(finder.get_path(first,second))
end
