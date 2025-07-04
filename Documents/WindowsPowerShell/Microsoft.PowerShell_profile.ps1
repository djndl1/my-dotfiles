cd ~

 Set-PSReadLineOption -EditMode Emacs

Del Alias:curl
Del Alias:wget

 Function Set-HongKong-Proxy {
	 $Local:HongkongProxy='http://xxx:xxx@mytencent:8888'
	 $Env:http_proxy=$Local:HongkongProxy
	 $Env:https_proxy=$Local:HongkongProxy
 }

 Function Unset-Proxy {
	 $Env:http_proxy=$Null
	 $Env:https_proxy=$Null
 }
