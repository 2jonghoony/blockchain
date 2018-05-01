require 'securerandom'

class Blockchain
	def initialize
		@chain = []
		@trans = []
	end

	def make_a_wallet
		SecureRandom.uuid.gsub("-", "")
	end

	def make_a_trans(s, r, a)
		trans = {
			"sender" => s,
			"rcpt" => r,
			"amount" => a
		}
		@trans << trans
		"다음 블럭에 쓰여집니다." + (@chain.length + 1).to_s
	end

	def mining

	history = []
	begin
		nonce = rand(100000000)
		history << nonce
		hashed = Digest::SHA256.hexdigest(nonce.to_s)
	end while hashed[0..3] != "0000"
	
	block = {
		"index" => @chain.size + 1,
		"time" => Time.now.to_i,
		"nonce" => nonce,
		"previous_address" => Digest::SHA256.hexdigest(last_block.to_s),
		"transactions" => @trans
	}
	@trans = []
	@chain << block

	history.size
	end

	def last_block
		@chain[-1]
	end

	def all_chains
		@chain
	end
end