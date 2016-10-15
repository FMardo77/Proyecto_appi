class AppToken

	def self.valid(token)
		# Rails.logger.debug("> X #{x}")

		begin
			# 1) Test if we can decode the token with our secret
			decoded_token = JWT.decode(
				token,
				Rails.application.secrets.jwt_secret,
				true,
				{algorithm: 'HS256'}
			)

			# [{"data"=>"data", "exp"=>1472842131}, {"typ"=>"JWT", "alg"=>"HS256"}]
#
			# 2) Test if token has not expired
			exp = decoded_token.first['exp']
			if exp and Time.at(exp) < Time.current
				return false
			end

			# 3) Test if we can start using the token
			nbf = decoded_token.first['nbf']
			if nbf and Time.at(nbf) > Time.current
				return false
			end

		rescue => e
			return false
		end

		return true
	end




end
