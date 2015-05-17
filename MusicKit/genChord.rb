infile = "ChordQuality.swift"
outfile = "Chord.swift"
lines = File.readlines(infile)

newlines = [
	"import Foundation", "\n",
	"public enum Chord  {",
]

starts = "//:"
continues = "//>"
ends = "//."

for line in lines
	if line.include? starts
		newlines.push line.strip
	end
	if line.include? continues
		newlines.push line.strip
	end 
	if line.include? ends
		newlines.push "}"
		break
	end 
	if line.include? "case"
		quality = line.rpartition('=')[0].sub("case", "").strip
		newlines.push "public static let #{quality} = Harmony.create(ChordQuality.#{quality}.intervals)"
	end
end

File.open(outfile, "w").puts newlines