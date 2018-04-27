# encoding: UTF-8

class Blockchain

	def mining

	begin
		nonce = rand(10000)
	end while nonce != 0
	nonce
	end
end