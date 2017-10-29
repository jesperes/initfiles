#!/usr/bin/ruby

def svnurl()
  arg = ARGV[0]
  if arg
    return arg
  end

  IO.popen("git svn info").readlines.each do |info|
    if info =~ /URL: (.*)/
      return $1
    end
  end
end

def svnrepo()
  if svnurl =~ /^(http(s)?:\/\/[^\/]*).*/
    return $1
  else
    puts "Could not get svn repo from #{svnurl}"
    exit 1
  end
end

SVNURL=svnurl
SVNREPO=svnrepo

def get_svn_dirs()
  return IO.popen("svn ls -R #{svnurl}").readlines.collect { |f| f =~ /\/$/ and f.strip }.compact.concat([""])
end

def get_external_url(urlspec)
  if urlspec =~ /^(http:|https:)/
    return urlspec
  elsif urlspec =~ /^\^(.*)/
    return "#{SVNURL}#{$1}"
  elsif urlspec =~ /^\/\/^(.*)/
    raise "not supported: #{urlspec}"
  elsif urlspec =~ /^\/(.*)/
    return "#{SVNREPO}/#{$1}"
  else
    raise "not supported: #{urlspec}"
  end
end

def handle_externals(url, items, io)
  # dir is the directory which contains the URL, relative to the root
  # of the WC.
  dir = url[SVNURL.length+1 .. url.length-1]
  if not dir
    dir = "."
  end
  
  if items[1] =~ /-r(.*)/
    cmdline = "svn checkout -q #{items[1]} #{get_external_url(items[2])} #{File.join(dir, items[0])}"
  else
    cmdline = "svn checkout -q #{get_external_url(items[0])} #{File.join(dir, items[1])}"
  end
  
  io.puts(cmdline)
end

def get_externals(io)
  dirs = get_svn_dirs

  while dirs.length > 0 do
    dirs_short = []

    100.times do
      dirs_short << dirs.shift
      break if dirs.length == 0
    end

    cmdline = dirs_short.collect { |f| "\"#{SVNURL}/#{f}\"" }.join(" ")
    IO.popen("svn propget svn:externals #{cmdline}").readlines.join("").split(/\n\n/m).each do |external|
      external =~ /(.*) - (.*)/m
      url=$1
      puts "Processing externals for #{url}"
      $2.split(/\n/m).each do |line|
        handle_externals(url, line.split, io)
      end
    end
  end
end

File.open("update-externals.sh", "w") do |io|
  puts "Scanning externals (this may take a while)..."
  io.puts "#!/bin/bash"
  io.puts "echo 'Running auto-generated script to update externals.'"
  io.puts "set -e"
  get_externals(io)
  io.close
  system("chmod +x #{io.path}")
  puts "Wrote update-script to #{io.path}"
end
