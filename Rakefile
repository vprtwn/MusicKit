desc "Generate Chord.swift and ChordQualities.swift"
task :codegen do
	Rake::Task['gen_chordqualities'].execute
	Rake::Task['gen_chord'].execute
end

task :docgen do
	Rake::Task['gen_frameworkoverview'].execute
end

task :gen_chordqualities do
	infile = "MusicKit/ChordQuality.swift"
	outfile = "MusicKit/ChordQualities.swift"
	lines = File.readlines(infile)

	newlines = [
		"import Foundation", "\n",
		"public extension ChordQuality {",
	]

	starts = "//:"
	continues = "//>"
	ends = "//."

	all_qualities = []
	quality_names = []
	for line in lines
		if line.include? starts
			group = line.sub(starts, "").strip
			newlines.push "public static let #{group} = ["
		end
		if line.include? continues
			group = line.sub(continues, "").strip
			newlines.push "]"
			newlines.push "public static let #{group} = ["
		end 
		if line.include? ends
			newlines.push "]"
			newlines.push "public static let Tetrads = ChordQuality.UnalteredTetrads + ChordQuality.AlteredTetrads"
			newlines.push "public static let Pentads = ChordQuality.UnalteredPentads + ChordQuality.AlteredPentads"
			newlines.push "public static let Hexads = ChordQuality.UnalteredHexads + ChordQuality.AlteredHexads"
			newlines.push "public static let Heptads = ChordQuality.UnalteredHeptads + ChordQuality.AlteredHeptads"
			newlines.push "public static let All = ["
			newlines.concat all_qualities
			newlines.push "]"
			newlines.push "public var name : String {"
			newlines.push "switch self {"
			newlines.concat quality_names
			newlines.push "}"
			newlines.push "}"
			newlines.push "}"
			break
		end 
		if line.include? "case"
			quality = line.rpartition('=')[0].sub("case", "").strip
			qline = "ChordQuality.#{quality},"
			all_qualities.push qline
			quality_names.push "case #{quality}: return \"#{quality}\""
			newlines.push qline
		end
	end

	File.open(outfile, "w").puts newlines
	print("Generated ChordQualities.swift with #{all_qualities.length} chord qualities\n")
end

task :gen_chord do
	infile = "MusicKit/ChordQuality.swift"
	outfile = "MusicKit/Chord.swift"
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
	print("Generated Chord.swift\n")
end

task :gen_frameworkoverview do
	infile = "Playgrounds/FrameworkOverview.playground/section-1.swift"
	outfile = "Documentation/FrameworkOverview.md"
	lines = File.readlines(infile).drop(3).join("").gsub("///", "")
	File.open(outfile, "w").puts lines
	print("Generated FrameworkOverview.md\n")
end