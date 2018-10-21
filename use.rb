# usage:
# ./use.rb FOO BAR | clip

libs = {
  "sum" => "./lib/sum.rb",
}

MODULE_NAME = "N4"

puts [
  "module #{MODULE_NAME}",
  "module_function",
  libs.values_at(*ARGV).uniq.compact.map {|f| File.read(f).chomp.gsub(/\n\s*/, "; ") },
  "end",
]
