require 'socket'

fdholder_path = ARGV[0]
key = ARGV[1]

exec_args = ARGV.dup

while arg = exec_args.shift
  break if arg == '--'
end
exec_args = ["cat"] if exec_args.empty?

fdholder = UNIXSocket.new(fdholder_path)
fdholder.sendmsg("get #{key}")
io = fdholder.recv_io()

exec(*exec_args, in: io)
