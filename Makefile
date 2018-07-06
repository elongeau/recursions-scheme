ghcid:
	@ghcid --color=always --command="stack ghci --ghci-options='-fwarn-unused-binds -fwarn-unused-imports -isrc :load Main'" -T :main

run:
	@stack build
	@stack exec rec-scheme-exe