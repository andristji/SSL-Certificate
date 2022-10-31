clear
apt install socat -y
rm -rf .acme.sh/
rm -rf /cert/
rm -rf /etc/cert
mkdir /cert/
mkdir /etc/cert
clear
echo " "
sleep 0.5
echo -e "============================================="
echo -e "  Install Certificate Google Trust Services  "
echo -e "       Support Multi Domain & Wildcard       "
echo -e "============================================="
echo -e " Bahan yang dibutuhkan:                      "
echo -e " -> Domain utama                             "
echo -e "  (contoh: domain.com, bukan xxx.domain.com) "
echo -e " -> Global API Key Cloudflare                "
echo -e " -> Email yang terdaftar Cloudflare          "
echo -e " -> Email Google                             "
echo -e " -> ID Key Google                            "
echo -e " -> Hmac Key Google                          "
echo -e "============================================="
echo -e " "
read -p "Masukkan main domain anda: " domain
read -p "Masukan Global API Key Cloudflare anda: " cfkey
read -p "Masukan Email Cloudflare anda: " cfemail
read -p "Masukan Email Google anda: " gmail
read -p "Masukan ID Key Google anda: " kid
read -p "Masukan Hmac Key Google anda: " hmackey
echo "$domain" >> /etc/cert/domain
echo "$cfkey" >> /etc/cert/cfkey
echo "$cfemail" >> /etc/cert/cfemail
echo "$gmail" >> /etc/cert/gmail
echo "$kid" >> /etc/cert/kid
echo "$hmackey" >> /etc/cert/hmackey
clear
echo " "
echo Install dimulai..........
sleep 0.5
cd /root/
curl https://get.acme.sh | sh
source ~/.bashrc
cd .acme.sh
export CF_Key="$cfkey"
export CF_Email="$cfemail"
bash acme.sh --register-account -m $gmail --server google --eab-kid $kid --eab-hmac-key $hmackey
bash acme.sh --issue --dns dns_cf -d $domain -d *.$domain --server google --debug
bash acme.sh --installcert -d $domain --fullchain-file /cert/fullchain.cer --key-file /cert/private.key
rm -f install-cert.sh
cd
