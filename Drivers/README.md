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

###   3.  PFX ファイル作成

```
pvk2pfx -pvk trustedpub.pvk -spc trustedpub.cer -pfx trustedpub.pfx -pi 123 -f
```

###   4.  デバイスドライバに署名


```
Inf2Cat /driver:<inf ファイルがあるディレクトリ> /usrlocaltime  ^
/os:7_X86,7_X64,8_X86,8_X64,10_X86,10_X64,Server2008R2_X64,Server10_X64
```

```
signtool sign /f trustedpub.pfx /p 123 /t http://timestamp.digicert.com px4_drv_winusb.cat
```
