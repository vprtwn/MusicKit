infile = "ChordQuality.swift"
outfile = "ChordQualities.swift"
lines = File.readlines(infile)

newlines = [
	"import Foundation", "\n",
	"struct ChordQualities {",
]

starts = "//:"
continues = "//>"
ends = "//."

for line in lines
	if line.include? starts
		group = line.sub(starts, "").strip.capitalize
		newlines.push "static let #{group} = ["
	end
	if line.include? continues
		group = line.sub(continues, "").strip.capitalize
		newlines.push "]"
		newlines.push "static let #{group} = ["
	end 
	if line.include? ends
		newlines.push "]"
		newlines.push "}"
		break
	end 
	if line.include? "case"
		quality = line.rpartition('=')[0].sub("case", "").strip
		newlines.push "ChordQuality.#{quality},"
	end
end

File.open(outfile, "w").puts newlines