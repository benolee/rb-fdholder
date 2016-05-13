require 'socket'

fdholder_path = ARGV[0]
key = ARGV[1]

fdholder = UNIXSocket.new(fdholder_path)
fdholder.sendmsg("delete #{key}")
