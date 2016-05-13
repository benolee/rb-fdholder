require 'socket'

fdholder_path = ARGV[0]
key = ARGV[1]

fdholder = UNIXSocket.new(fdholder_path)
fdholder.sendmsg("list #{key}")
list = fdholder.recvmsg.first
puts list
