require 'socket'

fdholder_path = ARGV[0]
key = ARGV[1]

io = STDIN

fdholder = UNIXSocket.new(fdholder_path)
fdholder.sendmsg("put #{key}")
fdholder.send_io(io)
fdholder.close
