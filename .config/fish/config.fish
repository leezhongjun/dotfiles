function fish_greeting
end

if status is-interactive 
	# Start tmux
	if not set -q TMUX
		if tmux has-session -t home
			exec tmux attach-session -t home
		else
			tmux new-session -s home
		end
	end

	# Commands to run in interactive sessions can go here
	alias vi="nvim"
	alias vim="nvim"
	alias oldvim="nvim"
	alias v="nvim"
	alias p="termux-clipboard-get"
	alias c="termux-clipboard-set"
 	clear   	
end
