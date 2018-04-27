# encoding: UTF-8

class Blockchain

	def mining

	begin
		nonce = rand(100000)
		hashed = Digest::SHA256.hexdigest(nonce.to_s)
	end while hashed[0..3] != "0000"
	nonce
	end
end