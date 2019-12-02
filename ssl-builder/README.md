
* If your client has their own certificate authority, you will not need to create a ca and intermediate certificate.

* configure env.sh file as needed for:

  * desired passwords for ca, intermediate, and broker/client certificates

  * add to the machines if you need additional certificates (needed if are to do SSL mutual auth).

* Steps

  1. create_ca.sh -- create the CA root cert, if you run this you will need to re-run all other scripts.

  2. create_intermediate.sh -- this creates an intermediate certificate as most companies have multiple layers of certificates, and this
     shows how chaining of certificates is performed for signing, so using them here.

  3. create_certs.sh -- for each machine call the create_cert.sh script to create the certificate for each machine; in the case described
     here this is for each broker.

  4. create_keystore.sh -- bundled the certificates into Java keystore files.  Keystore password and key passwords must match, limitation
     of JKS format of certificates stored in keystore.

* There are many ways to create certificates for java applications.  I have found using openssl to be more true to leveraging certificate signing
  if you were not creating your own CA/Intermediate certificates.

* Certificates are tricky and I do not expect I have all the nuances figured out, adding extensions is tricky, having extensions part of the 
certificate request to propriate to the certificate when signed is even more tricky.  To make this easier, I provide an openssl.cnf file and provide
that to the openssl command when possible.  Again, there are times when you don't provide an openssl configuration, because you don't use one. 
Using bash shell embedded file-handling like `(cat ./openssl.cnf <(printf "\n[ext]\nbasicConstraints=CA:TRUE,pathlen:0"))` makes it easier
to provide the alternate cnf file w/out having to maintain multiple copies of them.

* The scripts are written to where you can restart at any level, so if you have a CA and Intermediate certificate you are happy with, just run steps 3 
and 4 to generate new broker scripts and JKS files.  If you need a new CA cert and run the first script, then you need to redo all of them.  Also,
I have had countless issues with scripts for ssl failing but the script continuing, so pieces didn't run or get recreated.  Ever command in the script
checks status response and will terminate immediately.   
