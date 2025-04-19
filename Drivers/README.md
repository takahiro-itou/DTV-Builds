# デバイスドライバ

##  ドライバの自己署名

###   1.  信頼されたルート証明機関の証明書作成

```
makecert -r -pe -n "CN=px4_drv CA,O=px4_drv CA,C=JP" -a sha256 -b 01/01/2000 -e 12/31/2099 -sv root.pvk -cy autority -eku 1.3.6.1.5.5.7.3.3 root.cer
```

###   2.  信頼された発行元の証明書作成

```
makecert -n "CN=px4_drv CA" -a sha256 -b 01/01/2000 -e 12/31/2099 -iv root.pvk -ic root.cer -sv trustedpub.pvk -cy end -eku 1.3.6.1.5.5.7.3.3 trustedpub.cer
```
