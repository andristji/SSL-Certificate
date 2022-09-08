clear
mkdir /cert/
mkdir /etc/cert
apt install socat -y
clear
echo -e "============================================="
echo -e "  Install Certificate Google Trust Services  "
echo -e "       Support Multi Domain & Wildcard       "
echo -e "============================================="
echo -e " Bahan yang diperlukan:                      "
echo -e " [1]> Domain utama                           "
echo -e "  (contoh: domain.com, bukan xx.domain.com)  "
echo -e " [2]> Global API Key Cloudflare              "
echo -e " [3]> Email yang terdaftar Cloudflare        "
echo -e " [4]> Email Google                           "
echo -e " [5]> ID Key Google                          "
echo -e " [6]> Hmac Key Google                        "
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
echo "$cfkey" >> /etc/cert/cfemail
echo "$cfkey" >> /etc/cert/gmail
echo "$kid" >> /etc/cert/kid
echo "$hmackey" >> /etc/cert/hmackey
cd /root/
curl https://get.acme.sh | sh
source ~/.bashrc
cd .acme.sh
export CF_Key="$cfkey"
export CF_Email="$cfemail"
bash acme.sh --register-account -m $gmail --server google --eab-kid $kid --eab-hmac-key $hmackey
bash acme.sh --issue --dns dns_cf -d $domain -d *.$domain --server google --dnssleep --log
bash acme.sh --installcert -d $domain --fullchain-file /cert/fullchain.cer --key-file /cert/private.key
cd