function genpkcs -d "Generate a keypair (public + private + PKCS#8 private)"
	set na $argv[1]
	if test (count $argv) -eq 2
		set bi $argv[2]
	else
		set bi "2048"
	end

	openssl genpkey -algorithm RSA -out $na.pem -pkeyopt "rsa_keygen_bits:"$bi
	openssl rsa -pubout -in $na.pem -out $na.pub
	openssl pkcs8 -topk8 -in $na.pem -nocrypt -out {$na}_pkcs.pem
end
