require 'securerandom'
require 'httparty'

class Blockchain
	def initialize
		@chain = []
		@trans = []
		@wallet = {}
		@node = []
	end

	def add_port(port)
		@node << port
	end

	def all_node
		@node
	end

	def ask_block
		@node.each do |n|
			n_block = HTTParty.get("http://localhost:"+n+"/number_of_blocks").body
			if @chain.length < n_block.to_i
				@chain = []
			end
		end
	end

	def wallet_list
		@wallet
	end

	def make_a_wallet
		address = SecureRandom.uuid.gsub("-", "") 
		@wallet[address] = 100
		@wallet
	end

	def make_a_trans(s, r, a)

		if @wallet[s].nil?
			"보내는 지갑이 존재하지 않습니다."
		elsif @wallet[r].nil?
			"받는 지갑이 존재하지 않습니다."
		elsif @wallet[s].to_f < a.to_f
			"돈이 부족합니다."
		else

			@wallet[s] = @wallet[s] - a.to_f
			@wallet[r] = @wallet[r] + a.to_f

			trans = {
				"sender" => s,
				"rcpt" => r,
				"amount" => a
			}
			@trans << trans
			"다음 블럭에 쓰여집니다." + (@chain.length + 1).to_s
		end

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