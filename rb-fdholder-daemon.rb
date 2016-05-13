require 'logger'
require 'socket'

fdholder_path = ARGV[0]

if fdholder_path.empty? || /\A[[:space:]]*\z/ === fdholder_path
  logger.error('rb-fdholder-daemon') { "fdholder_path is BLANK!" }
  exit(1)
end

logger = Logger.new(STDOUT)

File.unlink(fdholder_path) if File.exists?(fdholder_path) && File.socket?(fdholder_path)
listener = UNIXServer.new fdholder_path

ios = {}

begin
  loop do
    client = listener.accept
    action, path = client.recvmsg.first.split

    case action
    when "put"
      logger.info('rb-fdholder-daemon') { "action: #{action.inspect}, path: #{path.inspect}" }
      io = client.recv_io
      logger.info('rb-fdholder-daemon') { "putting #{path.inspect}: #{io.inspect}" }
      ios[path] = io
    when "get"
      logger.info('rb-fdholder-daemon') { "action: #{action.inspect}, path: #{path.inspect}" }
      logger.info('rb-fdholder-daemon') { "getting #{path.inspect}: #{ios[path]}" }
      client.send_io(ios[path])
    when "list"
      logger.info('rb-fdholder-daemon') { "action: #{action.inspect}, path: #{path.inspect}" }
      client.sendmsg ios.inspect
    when "delete"
      logger.info('rb-fdholder-daemon') { "action: #{action.inspect}, path: #{path.inspect}" }
      logger.info('rb-fdholder-daemon') { "deleting #{path.inspect}: #{ios[path]}" }
      ios.delete(path)
    else
      logger.info('rb-fdholder-daemon') { "unrecognized action: #{action.inspect}" }
    end
    client.close
  end
ensure
  listener.close
  File.unlink(fdholder_path) if File.exists?(fdholder_path) && File.socket?(fdholder_path)
end
