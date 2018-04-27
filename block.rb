# encoding: UTF-8

class Blockchain

	def mining

	history = []

	begin
		nonce = rand(100000)
		history << nonce
		hashed = Digest::SHA256.hexdigest(nonce.to_s)
	end while hashed[0..3] != "0000"
	history
	end
end