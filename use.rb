# usage:
# ./use.rb FOO BAR | clip

libs = {
  "sum" => "./lib/sum.rb",
}

MODULE_NAME = "N4"

puts [
  "# https://github.com/n4o847/procon-library-ruby",
  "module #{MODULE_NAME}",
  "module_function",
  libs.values_at(*ARGV).uniq.compact.map {|f|
    File.read(f)[/(?<=# BEGIN).*(?=# END)/m].strip.gsub(/\n\s*/, "; ")
  },
  "end",
]
