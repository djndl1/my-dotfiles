cd ~

Set-PSReadLineOption -EditMode Emacs

Del Alias:curl -ErrorAction SilentlyContinue
Del Alias:wget -ErrorAction SilentlyContinue

Function git-dotfile {
	        git --git-dir=$Env:HOME/.dotfiles --work-tree=$env:HOME $Args 
}

 Function Set-HongKong-Proxy {
	 $Local:HongkongProxy='http://djn:freebird@43.128.11.210:8888'
	 $Env:http_proxy=$Local:HongkongProxy
	 $Env:https_proxy=$Local:HongkongProxy
 }

 Function Unset-Proxy {
	 $Env:http_proxy=$Null
	 $Env:https_proxy=$Null
 }

 Function nvim-vim {
	nvim -u ~/.config/nvim/init.lua $args
 }

 Function nvim-qt-vim {
	nvim-qt -- -u ~/.config/nvim/init.lua $args
 }
 
. $env:USERPROFILE/Documents/WindowsPowerShell/SiteSpecific.ps1
