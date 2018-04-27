# encoding: UTF-8

class Blockchain
	def initialize
		@chain = []
	end
	def mining

	history = []
	begin
		nonce = rand(100000)
		history << nonce
		hashed = Digest::SHA256.hexdigest(nonce.to_s)
	end while hashed[0..3] != "0000"
	
	block = {
		"index" => @chain.size + 1,
		"time" => Time.now.to_i,
		"nonce" => nonce
	}
	@chain << block

	history.size
	end

	def all_chains
		@chain
	end
end