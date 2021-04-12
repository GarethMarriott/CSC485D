import csv


f = open("enwiki.wikilink_graph.2018-03-01.csv", "r")

lookup_table = {}
index = 0
counter = 0
f.readline()

for line in f:
    counter = counter+1
    split = line.split("\t")
    for ind,i in enumerate(split,start=0):
        split[ind] = i.replace('"', '')
        split[ind] = i.strip()
    if split[1] in lookup_table:
        pass
    else:
        lookup_table[split[1]] = index
        index = index+1
    if split[3] in lookup_table:
        pass
    else:
        lookup_table[split[3]] = index
        index = index+1
    print("Indexed so far: "+str(index),end="\r")

print("\nnow adding to list\n")
f.close()

f = open("enwiki.wikilink_graph.2018-03-01.csv", "r")
f.readline()
counter2 = 0
adjlist = [[] for row in range(len(lookup_table))]
for line in f:
    counter2 = counter2+1
    split = line.split("\t")
    for ind,i in enumerate(split,start=0):
        split[ind] = i.replace('"', '')
        split[ind] = i.strip()
    adjlist[lookup_table[split[1]]].append(lookup_table[split[3]])
    print("added to list: "+str(counter2)+"/"+str(counter),end="\r")

f.close()
# print(str(lookup_table))
# print(str(adjlist))

with open('lookup_table.txt', 'w') as file:
    writer = csv.writer(file, delimiter='\t')
    for key, value in lookup_table.items():
       writer.writerow([key, value])

# with open("lookup.csv", "w", newline="") as f:
#     writer = csv.writer(f)
#     writer.writerows(lookup_table)

with open("edges.txt", "w", newline="") as g:
    writerg = csv.writer(g, delimiter='\t')
    writerg.writerows(adjlist)
