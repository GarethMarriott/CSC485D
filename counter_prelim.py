

f = open("enwiki.wikilink_graph.2018-03-01.csv", "r")

count = 0
doup = 0
total = 0
prev_id = ""
print(f.readline().split("\t")[0])
for line in f:
    total = total + 1
    split = line.split("\t")
    id = split[0]
    if int(split[2]) < 10:
        print("")
        print(split)
        print("-")
    if id != prev_id:
        count = count+1
        prev_id = id
    else:
        doup = doup+1
    print("unique ids: " + str(count)+"   doup: "+str(doup), end ="\r")

print("\n\nFINAL ids: "+str(count)+" FINAL DOUP: "+str(doup))
print("TOTAL: "+str(total))
f.close()
