infile = "../MusicKit.playground/section-1.swift"
outfile = "FrameworkOverview.md"
lines = File.readlines(infile).drop(3).join("").gsub("///", "")
File.open(outfile, "w").puts lines