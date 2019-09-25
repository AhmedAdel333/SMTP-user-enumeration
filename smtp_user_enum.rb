require "socket"
# $data = 252 2.0.0 msfadmin

$conn = TCPSocket.new("192.168.1.11", 25)
$bann = $conn.recv(1024).chomp
$users = File.open("users.txt", "r")

for line in $users do 
	$user = line.strip
	$conn.send("VRFY #{$user} \n\r", 0)
	$data = $conn.recv(1024).chomp
	if $data.split[2] == $user then 
		puts "[+] User: #{$user} Found"
	else
		puts "[-] User #{$user} Not Found"
	end
end